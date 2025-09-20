-- #########################################################
-- PostgreSQL utilities for schema discovery, data profiling,
-- joins, type handling, and numeric distribution analysis.
-- Designed for real-world audit, enrichment, and reporting pipelines.
-- #########################################################


-- ========================================================
-- SECTION 1: Explore table structure and schema metadata
-- Use case: Get full schema overview for available datasets
-- ========================================================

-- List tables in public schema
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';

-- Inspect column metadata (types and nullability)
SELECT table_name, column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name = 'fortune500';

-- List primary key columns
SELECT tc.table_name, kcu.column_name
FROM information_schema.table_constraints AS tc
JOIN information_schema.key_column_usage AS kcu
  ON tc.constraint_name = kcu.constraint_name
WHERE tc.constraint_type = 'PRIMARY KEY';

-- List foreign key relationships
SELECT tc.table_name, kcu.column_name, ccu.table_name AS foreign_table_name, ccu.column_name AS foreign_column_name
FROM information_schema.table_constraints AS tc
JOIN information_schema.key_column_usage AS kcu
  ON tc.constraint_name = kcu.constraint_name
JOIN information_schema.constraint_column_usage AS ccu
  ON ccu.constraint_name = tc.constraint_name
WHERE tc.constraint_type = 'FOREIGN KEY';

-- Count distinct values in key columns
SELECT COUNT(DISTINCT ticker) AS unique_tickers FROM fortune500;


-- ========================================================
-- SECTION 2: Assess missing and null values
-- Use case: Validate completeness and identify data gaps
-- ========================================================

-- Count nulls using COUNT(*) - COUNT(column)
SELECT COUNT(*) - COUNT(ticker) AS missing_ticker FROM fortune500;
SELECT COUNT(*) - COUNT(industry) AS missing_industry FROM fortune500;

-- Show rows with missing industry values
SELECT *
FROM fortune500
WHERE industry IS NULL;


-- ========================================================
-- SECTION 3: Explore table relationships with joins
-- Use case: Enrich datasets and trace referential logic
-- ========================================================

-- Enrich company with financial ranking data
SELECT company.name
FROM company
INNER JOIN fortune500 ON company.ticker = fortune500.ticker;

-- Identify most common tag type
SELECT tag_type.type, COUNT(tag_type.tag) AS count
FROM tag_type
GROUP BY tag_type.type
ORDER BY count DESC;

-- List companies using tags of a specific type (e.g. 'cloud')
SELECT company.name, tag_type.tag, tag_type.type
FROM company
INNER JOIN tag_company ON company.id = tag_company.company_id
INNER JOIN tag_type ON tag_company.tag = tag_type.tag
WHERE tag_type.type = 'cloud';


-- ========================================================
-- SECTION 4: Handle NULLs and fallback values with COALESCE
-- Use case: Create complete classification logic from sparse fields
-- ========================================================

SELECT COALESCE(industry, sector, 'Unknown') AS industry2, COUNT(*) AS count
FROM fortune500
GROUP BY industry2
ORDER BY count DESC
LIMIT 1;


-- ========================================================
-- SECTION 5: Data type casting and precision control
-- Use case: Normalize types for numeric logic and ETL alignment
-- ========================================================

-- Cast profits_change as integer to observe effect
SELECT profits_change, CAST(profits_change AS integer) AS profits_change_int
FROM fortune500;

-- Compare integer vs numeric division
SELECT 10 / 3 AS integer_division, 10::numeric / 3 AS numeric_division;

-- Convert string inputs to numeric (incl. scientific notation)
SELECT '3.2'::numeric, '-123'::numeric, '1e3'::numeric, '1e-3'::numeric, '02314'::numeric, '0002'::numeric;


-- ========================================================
-- SECTION 6: Summarize and group numeric distributions
-- Use case: Analyze business metric distributions & smooth outliers
-- ========================================================

-- Raw distribution of revenue change
SELECT revenues_change, COUNT(*) AS count
FROM fortune500
GROUP BY revenues_change
ORDER BY count DESC;

-- Binned revenue changes via integer casting
SELECT revenues_change::integer AS rev_change_group, COUNT(*) AS count
FROM fortune500
GROUP BY rev_change_group
ORDER BY count DESC;

-- Count companies with positive revenue change
SELECT COUNT(*) AS companies_with_growth
FROM fortune500
WHERE revenues_change > 0;

-- Use HAVING to filter aggregate results
SELECT industry, COUNT(*) AS company_count
FROM fortune500
GROUP BY industry
HAVING COUNT(*) > 10
ORDER BY company_count DESC;
