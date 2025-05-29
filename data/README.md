# 📂 data/

This folder contains raw and structured datasets used for all exercises, analyses, and case studies in this SQL project. It serves as the **single source of truth** for loading, joining, exploring, and transforming data across different modules.

---

## 🔍 Data Sources & Purpose

Each dataset in this folder is chosen to demonstrate specific SQL techniques as part of exploratory data analysis (EDA) and business-oriented querying.

### Key Tables Used:

#### 🏛️ `evanston311`

* **Source**: 311 service request data from Evanston, Illinois
* **Used in**: Chapter 3 & 4
* **Purpose**: Event timestamp analysis, text standardization, pattern matching, time-to-resolution analysis

#### 📊 `fortune500`

* **Source**: Simulated/aggregated Fortune 500 company data
* **Used in**: Chapter 1 & 2
* **Purpose**: Numeric analysis, outlier detection, sector-level comparison, correlation, and summary statistics

#### 🏢 `company`, `tag_company`, `tag_type`, `stackoverflow`

* **Source**: Simulated database schema from DataCamp
* **Used in**: Chapter 1
* **Purpose**: Demonstrating joins, foreign key relationships, metadata analysis, tag-category insights

---

## 🔐 Privacy Note

All datasets used here are anonymized or simulated for educational purposes and contain **no sensitive or personal information**.

---

## 📌 Notes for Use

* Ensure that data types and schema are preserved when importing into PostgreSQL or any RDBMS.
* If using dbt or Lightdash, consider snapshotting this data for downstream modeling.

---

## 🧪 Data Structure Example

```sql
SELECT *
FROM evanston311
LIMIT 5;
```

```text
| id | category        | date_created       | date_completed     | description                    |
|----|------------------|--------------------|---------------------|--------------------------------|
| 1  | Rodents - Rats   | 2016-04-12 08:41:00| 2016-06-15 10:35:00 | "There are rats in the alley" |
| 2  | Trash Pickup     | 2016-04-13 09:22:00| 2016-04-14 15:45:00 | "Missed garbage day."          |
```

---

## 🧭 Folder Intent

Keep this directory clean and version-controlled. Any raw, cleaned, or joined data used in this repo should originate from here.

---

## ✅ Recommended Formats

* `.csv`, `.sql`, or `.parquet` depending on your use case
* Use consistent column naming conventions (snake\_case)

---

*This folder powers your insights.*
