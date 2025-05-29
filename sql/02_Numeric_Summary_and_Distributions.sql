-- #########################################################
-- PostgreSQL functions and logic for summarizing, grouping,
-- analyzing numeric data, and building value distributions.
-- Includes statistical metrics, binning, and correlation.
-- #########################################################


-- ========================================================
-- SECTION 1: Revenue normalization per employee
-- Use case: Compare revenue efficiency across sectors
-- ========================================================

SELECT 
  sector, 
  ROUND(AVG(revenues / employees::numeric), 2) AS avg_rev_employee
FROM 
  fortune500
GROUP BY 
  sector
ORDER BY 
  avg_rev_employee DESC;


-- ========================================================
-- SECTION 2: Validation of stored percentage metric
-- Use case: Verify that unanswered_pct reflects actual ratio
-- ========================================================

SELECT 
  unanswered_count / question_count::numeric AS computed_pct, 
  unanswered_pct
FROM 
  stackoverflow
WHERE 
  question_count > 0
LIMIT 10;


-- ========================================================
-- SECTION 3: Profit summary and cross-tag variability
-- Use case: Identify dispersion and distribution of key metrics
-- ========================================================

WITH profit_stats AS (
  SELECT 
    sector,
    MIN(profits) AS min_profit,
    MAX(profits) AS max_profit,
    AVG(profits) AS avg_profit,
    STDDEV(profits) AS stddev_profit
  FROM 
    fortune500
  GROUP BY sector
)
SELECT 
  'TOTAL' AS sector_label,
  MIN(profits),
  MAX(profits),
  AVG(profits),
  STDDEV(profits)
FROM 
  fortune500
UNION ALL
SELECT 
  sector,
  min_profit,
  max_profit,
  avg_profit,
  stddev_profit
FROM 
  profit_stats
ORDER BY 
  avg_profit DESC;

SELECT 
  MIN(maxval),
  MAX(maxval),
  AVG(maxval),
  STDDEV(maxval)
FROM (
  SELECT MAX(question_count) AS maxval
  FROM stackoverflow
  GROUP BY tag
) AS max_results;


-- ========================================================
-- SECTION 4: Value binning for headcount analysis
-- Use case: Simplify employee distribution into logical ranges
-- ========================================================

SELECT 
  TRUNC(employees, -5) AS employee_bin,
  COUNT(*) AS company_count
FROM 
  fortune500
GROUP BY 
  employee_bin
ORDER BY 
  employee_bin;

SELECT 
  TRUNC(employees, -4) AS employee_bin,
  COUNT(*) AS company_count
FROM 
  fortune500
WHERE 
  employees < 100000
GROUP BY 
  employee_bin
ORDER BY 
  employee_bin;


-- ========================================================
-- SECTION 5: Distribution binning with generate_series()
-- Use case: Analyze frequency distribution of question activity
-- ========================================================

WITH bins AS (
  SELECT 
    generate_series(2200, 3050, 50) AS lower,
    generate_series(2250, 3100, 50) AS upper
),
  dropbox AS (
    SELECT question_count FROM stackoverflow WHERE tag = 'dropbox'
)
SELECT 
  lower, 
  upper, 
  COUNT(question_count) AS question_count
FROM 
  bins
LEFT JOIN dropbox
  ON question_count >= lower AND question_count < upper
GROUP BY 
  lower, upper
ORDER BY 
  lower;


-- ========================================================
-- SECTION 6: Correlation between financial metrics
-- Use case: Identify linear relationships in financial data
-- ========================================================

SELECT 
  CORR(revenues, profits) AS rev_profits,
  CORR(revenues, assets) AS rev_assets,
  CORR(revenues, equity) AS rev_equity
FROM 
  fortune500;


-- ========================================================
-- SECTION 7: Mean and median of company assets by sector
-- Use case: Compare central tendencies using multiple statistical methods
-- ========================================================

SELECT 
  sector,
  ROUND(AVG(assets), 2) AS mean,
  PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY assets) AS median
FROM 
  fortune500
GROUP BY 
  sector
ORDER BY 
  mean DESC;


-- ========================================================
-- SECTION 8: Identify top 20% profit performers by sector
-- Use case: Segment high-profit companies relative to industry peers
-- ========================================================

DROP TABLE IF EXISTS profit80;

CREATE TEMP TABLE profit80 AS
SELECT 
  sector, 
  PERCENTILE_DISC(0.8) WITHIN GROUP (ORDER BY profits) AS pct80
FROM 
  fortune500
GROUP BY 
  sector;

SELECT 
  f.title, 
  f.sector, 
  f.profits, 
  ROUND(f.profits / p.pct80, 2) AS profit_ratio
FROM 
  fortune500 f
JOIN profit80 p ON f.sector = p.sector
WHERE f.profits > p.pct80;


-- ========================================================
-- SECTION 9: Question count change from first to last recorded date
-- Use case: Track tag growth by comparing initial and final day counts
-- ========================================================

DROP TABLE IF EXISTS startdates;

CREATE TEMP TABLE startdates AS
SELECT tag, MIN(date) AS mindate
FROM stackoverflow
GROUP BY tag;

SELECT 
  s.tag, 
  s.mindate, 
  min_data.question_count AS start_count,
  max_data.question_count AS end_count,
  max_data.question_count - min_data.question_count AS change
FROM 
  startdates s
JOIN stackoverflow min_data ON s.tag = min_data.tag AND s.mindate = min_data.date
JOIN stackoverflow max_data ON s.tag = max_data.tag AND max_data.date = '2018-09-25';


-- ========================================================
-- SECTION 10: Correlation matrix using insert into temp table
-- Use case: Create reusable correlation table between financial metrics
-- ========================================================

DROP TABLE IF EXISTS correlations;

CREATE TEMP TABLE correlations AS
SELECT 'profits'::varchar AS measure,
       CORR(profits, profits) AS profits,
       CORR(profits, profits_change) AS profits_change,
       CORR(profits, revenues_change) AS revenues_change
FROM fortune500;

INSERT INTO correlations
SELECT 'profits_change',
       CORR(profits_change, profits),
       CORR(profits_change, profits_change),
       CORR(profits_change, revenues_change)
FROM fortune500;

INSERT INTO correlations
SELECT 'revenues_change',
       CORR(revenues_change, profits),
       CORR(revenues_change, profits_change),
       CORR(revenues_change, revenues_change)
FROM fortune500;

SELECT 
  measure, 
  ROUND(profits::numeric, 2) AS profits,
  ROUND(profits_change::numeric, 2) AS profits_change,
  ROUND(revenues_change::numeric, 2) AS revenues_change
FROM 
  correlations;
