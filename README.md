# Exploratory Data Analysis in SQL

> **Practical project repository based on the DataCamp course "Exploratory Data Analysis in SQL"**

This repository contains hands-on exercises, SQL scripts, and explanations based on the official DataCamp curriculum. It serves as documentation of practical skills within EDA using SQL and can be used as a reference, study tool, or portfolio project.

---

## 🎓 Background

The course and this project cover the full EDA process in SQL—from dataset preparation and outlier detection to grouping, summarization, and NULL handling. The project is structured in modules for systematic review or repetition.

DataCamp Certificate: *Exploratory Data Analysis in SQL* ✅
See certificate image or PDF in the `docs/` folder.

---

## 📄 Structure

```
eda-sql-project/
├── data/                    # Example datasets used for SQL queries
├── notebooks/              # EDA modules divided into separate SQL files
├── screenshots/            # Results and IDE screenshots for visual documentation
├── docs/                   # Theory, explanations, and project documentation
├── .gitignore              # Ignore e.g. data dumps and system files
└── README.md               # This file
```

---

## 🔄 Modules and Topics

| Module | Topic                | Description                                          |
| ------ | -------------------- | ---------------------------------------------------- |
| 01     | NULL Handling        | Identifying and managing missing values              |
| 02     | Outlier Detection    | Filtering extreme values using HAVING and conditions |
| 03     | Summary Statistics   | Using `AVG()`, `MIN()`, `MAX()`, `STDDEV()`, etc.    |
| 04     | Filtering & Sorting  | Combining `WHERE`, `ORDER BY`, `LIMIT`               |
| 05     | Aggregation & Groups | `GROUP BY`, `HAVING`, nested aggregates              |

---

## 📊 Example: Outlier Detection

```sql
SELECT name, revenue
FROM companies
WHERE revenue > 10000000;
```

*Description: Simple filter to identify revenue outliers.*

---

## 📖 Documentation and Explanation

See the `docs/` folder for:

* `eda_overview.md` – Introduction to EDA and SQL approach
* `handling-missing-values.sql` – Handling NULLs and NA analysis
* `explained_examples.md` – Walkthrough of selected course questions and answers

---

## 🛠️ Tools and Setup

* SQL engine: PostgreSQL, SQLite, or equivalent
* IDE: DBeaver, DataGrip, pgAdmin, etc.

Clone the project:

```bash
git clone https://github.com/YOUR_USERNAME/eda-sql-project.git
```

---

## 📈 Portfolio Use

This repository is part of my professional data portfolio and demonstrates the application of SQL for EDA tasks. It is suitable for:

* Recruiters and hiring partners
* Students or self-learners focusing on SQL
* Mentors and instructors

---

## 🚀 Future Improvements

* Add Lightdash visuals or `.png` screenshots
* Integrate with `dbt` for pipeline use cases

---

> Made with ❤️ & SQL – by Vibe Harboe Christensen
