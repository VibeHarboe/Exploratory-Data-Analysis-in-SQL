-- #########################################################
-- SQL techniques for analyzing time-to-resolution,
-- service duration, delay trends, and scheduling behavior
-- in public service requests and time-based datasets.
-- #########################################################


-- ========================================================
-- SECTION 1: Accurate date filtering and timestamp logic
-- Use case: Count events occurring on exact calendar dates
-- ========================================================

-- Count requests on specific dates using three different methods
SELECT 
  COUNT(*) FILTER (WHERE date_created::date = '2017-01-31') AS requests_jan_31,
  COUNT(*) FILTER (WHERE date_created >= '2016-02-29' AND date_created < '2016-03-01') AS requests_feb_29,
  COUNT(*) FILTER (WHERE date_created >= '2017-03-13' AND date_created < '2017-03-14') AS requests_mar_13
FROM evanston311;


-- ========================================================
-- SECTION 2: Date arithmetic and time calculations
-- Use case: Calculate durations, time since events, and scheduling offsets
-- ========================================================

-- General calculations with timestamps and intervals
SELECT 
  MAX(date_created) - MIN(date_created) AS total_range,
  NOW() - MAX(date_created) AS time_since_latest,
  NOW() + '100 days'::interval AS plus_100_days,
  NOW() + '5 minutes'::interval AS plus_5_minutes
FROM evanston311;


-- ========================================================
-- SECTION 3: Average completion time by request category
-- Use case: Identify which request types take longest to resolve
-- ========================================================

SELECT 
  category, 
  AVG(date_completed - date_created) AS completion_time
FROM evanston311
GROUP BY category
ORDER BY completion_time DESC;


-- ========================================================
-- SECTION 4: Extract date parts and aggregate by time units
-- Use case: Monthly, hourly, weekday-based summaries
-- ========================================================

-- Requests per month (2016–2017)
SELECT DATE_PART('month', date_created) AS month, COUNT(*) AS request_count
FROM evanston311
WHERE date_created >= '2016-01-01' AND date_created < '2018-01-01'
GROUP BY month;

-- Most common hour for request creation
SELECT DATE_PART('hour', date_created) AS hour, COUNT(*) AS request_count
FROM evanston311
GROUP BY hour
ORDER BY request_count DESC
LIMIT 1;

-- Completed requests by hour
SELECT DATE_PART('hour', date_completed) AS hour, COUNT(*) AS completion_count
FROM evanston311
GROUP BY hour
ORDER BY hour DESC;

-- Average completion time by weekday
SELECT TO_CHAR(date_created, 'Day') AS day, AVG(date_completed - date_created) AS duration
FROM evanston311
GROUP BY day, EXTRACT(DOW FROM date_created)
ORDER BY EXTRACT(DOW FROM date_created);

-- Average daily requests per month using date truncation
WITH daily_count AS (
  SELECT DATE_TRUNC('day', date_created) AS day, COUNT(*) AS count
  FROM evanston311
  GROUP BY day
)
SELECT DATE_TRUNC('month', day) AS month, AVG(count) AS avg_daily_requests
FROM daily_count
GROUP BY month
ORDER BY month;

-- Find missing dates where no requests were created
WITH all_dates AS (
  SELECT GENERATE_SERIES(MIN(date_created)::date, MAX(date_created)::date, '1 day')::date AS day
  FROM evanston311
)
SELECT day
FROM all_dates
WHERE day NOT IN (SELECT date_created::date FROM evanston311);

-- Median requests per day in 6-month intervals
WITH bins AS (
  SELECT GENERATE_SERIES('2016-01-01', '2018-01-01', '6 months') AS lower,
         GENERATE_SERIES('2016-07-01', '2018-07-01', '6 months') AS upper
),
daily_counts AS (
  SELECT day, COUNT(date_created) AS count
  FROM (
    SELECT GENERATE_SERIES('2016-01-01', '2018-06-30', '1 day') AS day
  ) AS daily_series
  LEFT JOIN evanston311 ON day = date_created::date
  GROUP BY day
)
SELECT lower, upper, PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY count) AS median
FROM bins
LEFT JOIN daily_counts ON day >= lower AND day < upper
GROUP BY lower, upper
ORDER BY lower;

-- Monthly average request count including days with no requests
WITH all_days AS (
  SELECT GENERATE_SERIES('2016-01-01', '2018-06-30', '1 day') AS date
),
daily_count AS (
  SELECT DATE_TRUNC('day', date_created) AS day, COUNT(*) AS count
  FROM evanston311
  GROUP BY day
)
SELECT DATE_TRUNC('month', date) AS month, AVG(COALESCE(count, 0)) AS average
FROM all_days
LEFT JOIN daily_count ON all_days.date = daily_count.day
GROUP BY month
ORDER BY month;

-- Longest time gap between request submissions
WITH request_gaps AS (
  SELECT date_created,
         LAG(date_created) OVER (ORDER BY date_created) AS previous,
         date_created - LAG(date_created) OVER (ORDER BY date_created) AS gap
  FROM evanston311
)
SELECT *
FROM request_gaps
WHERE gap = (SELECT MAX(gap) FROM request_gaps);


-- ========================================================
-- SECTION 5: Deep-dive analysis of high-duration categories
-- Use case: Investigate outliers, correlation, and bottlenecks
-- ========================================================

-- Step 1: Distribution of completion times for 'Rodents- Rats'
SELECT DATE_TRUNC('day', date_completed - date_created) AS completion_time, COUNT(*) AS request_count
FROM evanston311
WHERE category = 'Rodents- Rats'
GROUP BY completion_time
ORDER BY completion_time;

-- Step 2: Average completion time excluding longest 5%
SELECT category, AVG(date_completed - date_created) AS avg_completion_time
FROM evanston311
WHERE (date_completed - date_created) < (
  SELECT PERCENTILE_DISC(0.95) WITHIN GROUP (ORDER BY date_completed - date_created)
  FROM evanston311
)
GROUP BY category
ORDER BY avg_completion_time DESC;

-- Step 3: Correlation between avg. completion time and request volume
SELECT CORR(avg_completion, count) AS corr_avg_time_vs_volume
FROM (
  SELECT DATE_TRUNC('month', date_created) AS month,
         AVG(EXTRACT(EPOCH FROM date_completed - date_created)) AS avg_completion,
         COUNT(*) AS count
  FROM evanston311
  WHERE category = 'Rodents- Rats'
  GROUP BY month
) AS monthly_avgs;

-- Step 4: Compare created vs. completed per month for 'Rodents- Rats'
WITH created AS (
  SELECT DATE_TRUNC('month', date_created) AS month, COUNT(*) AS created_count
  FROM evanston311
  WHERE category = 'Rodents- Rats'
  GROUP BY month
),
completed AS (
  SELECT DATE_TRUNC('month', date_completed) AS month, COUNT(*) AS completed_count
  FROM evanston311
  WHERE category = 'Rodents- Rats'
  GROUP BY month
)
SELECT created.month, created_count, completed_count
FROM created
INNER JOIN completed USING (month)
ORDER BY created.month;
