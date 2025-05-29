# Exploratory Data Analysis in SQL

This folder showcases practical SQL techniques for performing **Exploratory Data Analysis (EDA)** across four comprehensive chapters. Each chapter aligns with real-world business problems and demonstrates how SQL can be used to extract insights, transform raw data, and analyze behavioral and operational trends using a structured, step-by-step approach.

---

## 📘 Chapter Overview

### 01 – Database Structure and Schema Exploration

**Goal**: Understand the structure, quality, and relationships within the database using joins, missing values, type casting, and basic profiling functions.

**Key Concepts:**

* Counting and handling NULL values
* INNER JOINs across related tables
* Entity-relationship understanding
* COALESCE() for fallback values
* CAST() and type conversion nuances
* Basic distribution exploration (GROUP BY, ORDER BY)

👉 *Ideal for establishing data readiness and profiling before analysis begins.*

---

### 02 – Numeric Summary and Distributions

**Goal**: Analyze numeric features using aggregation, binning, correlation, and truncation to understand variability and typical values in the dataset.

**Key Concepts:**

* AVG(), MIN(), MAX(), STDDEV()
* Truncating numeric values into bins with TRUNC()
* Custom binning using GENERATE\_SERIES()
* Calculating correlation with CORR()
* MEDIAN calculation using PERCENTILE\_DISC()
* Temporary tables for threshold-based queries

👉 *Useful for summarizing business KPIs, outlier detection, and high-level numeric diagnostics.*

---

### 03 – Text, Categoricals, and Pattern Matching

**Goal**: Clean, group, and extract structured meaning from messy or unstructured string-based data.

**Key Concepts:**

* TRIM(), SPLIT\_PART(), CONCAT(), LENGTH()
* LIKE / ILIKE pattern matching
* CASE WHEN for string shortening
* Text-based standardization and recoding
* Creating indicator variables for contact detection
* Temporary tables for standardized categorization (RECODE)

👉 *Critical when handling text-heavy fields like complaint descriptions or customer messages.*

---

### 04 – Event Timing and Duration Analysis

**Goal**: Explore time-based behavior and identify trends in request timing, processing speed, and date-based correlations.

**Key Concepts:**

* DATE\_PART(), DATE\_TRUNC(), EXTRACT(DOW), TO\_CHAR()
* Interval math with NOW(), LAG(), LEAD()
* Gaps in event sequences with LAG()
* Aggregation across custom time windows (e.g., 6-month bins)
* Completion time analysis with outlier handling
* Time-to-resolution correlations with workload

👉 *Excellent for operations analysis, service-level agreements (SLA), and historical performance evaluation.*

---

## ✅ Why This Matters

This EDA series illustrates how SQL goes beyond simple querying — enabling:

* Rich temporal insights
* Quality assurance and profiling
* Behavioral analytics on customer- or system-generated data
* Operational monitoring and diagnostics

---

## 🧠 Tech & Tools

* PostgreSQL
* PostgreSQL-specific functions (e.g. GENERATE\_SERIES, PERCENTILE\_DISC)
* Temporary tables and CTEs for readable, layered querying

---

## 👩‍💻 Author Notes

This project is part of my DataCamp training path in SQL for data analysis. Each SQL script demonstrates progressively more advanced use of SQL, reflecting the kind of skills used in real business intelligence work: from simple data preparation to robust trend analysis and metric evaluation.

---

## 📂 Folder Structure

```bash
/sql
├── 01_Database_Structure.sql
├── 02_Numeric_Summary_and_Distributions.sql
├── 03_Text_Categoricals_and_Indicators.sql
├── 04_Event_Timing_and_Duration.sql
└── README.md
```

---

## 💬 Feedback & Contributions

Suggestions for improvement, alternative solutions, or optimizations are always welcome!

---

*Built with SQL. Backed by business logic.*
