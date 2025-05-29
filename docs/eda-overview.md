# 📊 Exploratory Data Analysis (EDA) in SQL

Exploratory Data Analysis (EDA) is the process of investigating data sets to summarize their main characteristics, uncover patterns, detect anomalies, test assumptions, and check data quality — all before any formal modeling.

In SQL-based workflows, EDA plays a crucial role in **profiling** data directly from the source (i.e., raw tables in your database), using **queries** instead of exported spreadsheets or BI tools.

---

## 🎯 Goals of EDA in SQL

* Understand the structure and contents of each table
* Detect missing, inconsistent, or malformed data
* Summarize key metrics across categories and time
* Identify distributions, outliers, and patterns
* Prepare data for modeling or dashboarding

---

## 🛠️ Key EDA Techniques in SQL

| Technique                     | SQL Function / Concept                    |
| ----------------------------- | ----------------------------------------- |
| Column profiling              | `COUNT(*)`, `COUNT(column)`, `DISTINCT`   |
| Missing value detection       | `COUNT(*) - COUNT(column)`                |
| Data type inspection          | `pg_typeof(column)`, `CAST()`             |
| Numeric summaries             | `AVG()`, `MIN()`, `MAX()`, `STDDEV()`     |
| Text cleaning & pattern match | `TRIM()`, `LIKE`, `ILIKE`, `SPLIT_PART()` |
| Temporal analysis             | `DATE_TRUNC()`, `EXTRACT()`, `INTERVAL`   |
| Grouped aggregations          | `GROUP BY`, `HAVING`, subqueries          |
| Correlation & comparisons     | `CORR()`, joins, conditional aggregations |

---

## 📈 Why SQL is a Strong EDA Tool

* Works **at scale** directly on your database
* Enables **reproducibility** via queries
* Supports **temporal and relational joins** better than Excel or pandas alone
* Often forms the **first step in ELT** workflows

---

## ✅ Best Practices

* Always start with `LIMIT 5` or `COUNT(*)` to understand table size
* Use `DISTINCT` and `GROUP BY` to explore categorical columns
* Watch out for `NULL` values — they're often more impactful than expected
* Profile both rows (records) and columns (features)
* Save useful queries as views or temp tables for reuse

---

EDA is not just about numbers — it’s about **understanding your data’s story.**

*“Let the data surprise you — before you decide what it means.”*
