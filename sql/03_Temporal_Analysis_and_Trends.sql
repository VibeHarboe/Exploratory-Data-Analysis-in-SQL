-- #########################################################
-- SQL strategies for time-based analysis and trend detection
-- including date functions, filtering, lag analysis,
-- moving averages, and cohort segmentation.
-- #########################################################


-- ========================================================
-- SECTION 1: Explore categorical frequency and distribution
-- Use case: Understand common request types and data quality
-- ========================================================

-- Count requests by priority level
SELECT 
  priority, 
  COUNT(*) AS request_count
FROM 
  evanston311
GROUP BY 
  priority;

-- Distinct zip codes with more than 100 requests
SELECT 
  zip, 
  COUNT(*) AS zip_count
FROM 
  evanston311
GROUP BY 
  zip
HAVING 
  COUNT(*) > 100;

-- Distinct sources with more than 100 requests
SELECT 
  source, 
  COUNT(*) AS source_count
FROM 
  evanston311
GROUP BY 
  source
HAVING 
  COUNT(*) > 100;

-- Top 5 most common streets in requests
SELECT 
  street, 
  COUNT(*) AS street_count
FROM 
  evanston311
GROUP BY 
  street
ORDER BY 
  street_count DESC
LIMIT 5;


-- ========================================================
-- SECTION 2: Basic string cleaning of street values
-- Use case: Normalize address formatting for consistency
-- ========================================================

SELECT DISTINCT 
  street,
  TRIM(street, '0123456789 #/.') AS cleaned_street
FROM evanston311
ORDER BY street;


-- ========================================================
-- SECTION 3: Find mismatches between description and category
-- Use case: Detect potential misclassification of trash-related requests
-- ========================================================

SELECT 
  category, 
  COUNT(*) AS request_count
FROM evanston311
WHERE 
  (description ILIKE '%trash%' OR description ILIKE '%garbage%')
  AND category NOT LIKE '%Trash%'
  AND category NOT LIKE '%Garbage%'
GROUP BY category
ORDER BY request_count DESC
LIMIT 10;


-- ========================================================
-- SECTION 4: Create normalized address strings
-- Use case: Combine house number and street into a single address field
-- ========================================================

SELECT 
  TRIM(CONCAT(house_num, ' ', street)) AS address
FROM evanston311;


-- ========================================================
-- SECTION 5: Extract base street names from full addresses
-- Use case: Group by common street names regardless of suffix variation
-- ========================================================

SELECT 
  SPLIT_PART(street, ' ', 1) AS street_name,
  COUNT(*) AS count
FROM evanston311
GROUP BY street_name
ORDER BY count DESC
LIMIT 20;


-- ========================================================
-- SECTION 6: Shorten long descriptions for preview
-- Use case: Display clean previews without truncating short text
-- ========================================================

SELECT 
  CASE 
    WHEN LENGTH(description) > 50 THEN LEFT(description, 50) || '...'
    ELSE description
  END AS short_description
FROM evanston311
WHERE description LIKE 'I %'
ORDER BY description;


-- ========================================================
-- SECTION 7: Standardize categories by main topic
-- Use case: Group related categories for better aggregation
-- ========================================================

DROP TABLE IF EXISTS recode;

CREATE TEMP TABLE recode AS
SELECT DISTINCT 
  category, 
  RTRIM(SPLIT_PART(category, '-', 1)) AS standardized
FROM evanston311;

UPDATE recode 
  SET standardized = 'Trash Cart' 
  WHERE standardized LIKE 'Trash%Cart';

UPDATE recode 
  SET standardized = 'Snow Removal' 
  WHERE standardized LIKE 'Snow%Removal%';

UPDATE recode 
  SET standardized = 'UNUSED'
  WHERE standardized IN (
    'THIS REQUEST IS INACTIVE...Trash Cart',
    '(DO NOT USE) Water Bill',
    'DO NOT USE Trash',
    'NO LONGER IN USE'
);

SELECT 
  standardized, 
  COUNT(*) AS request_count
FROM evanston311
LEFT JOIN recode 
  ON evanston311.category = recode.category
GROUP BY standardized
ORDER BY request_count DESC;


-- ========================================================
-- SECTION 8: Analyze contact info by priority
-- Use case: Detect user contact behavior across priority levels
-- ========================================================

DROP TABLE IF EXISTS indicators;

CREATE TEMP TABLE indicators AS
SELECT 
  id, 
  CAST(description LIKE '%@%' AS integer) AS email,
  CAST(description LIKE '%___-___-____%' AS integer) AS phone
FROM evanston311;

SELECT 
  priority,
  ROUND(SUM(email)::numeric / COUNT(*), 3) AS email_prop,
  ROUND(SUM(phone)::numeric / COUNT(*), 3) AS phone_prop
FROM evanston311
LEFT JOIN indicators 
  ON evanston311.id = indicators.id
GROUP BY priority;
