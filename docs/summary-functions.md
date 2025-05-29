# 📊 Summary Functions in SQL

Summary (or aggregate) functions are at the heart of Exploratory Data Analysis in SQL. They allow you to describe data distributions, identify extremes, and detect trends or irregularities by computing values across rows.

---

## 🔢 Core Summary Functions

| Function            | Description                          | Example Usage                             |
| ------------------- | ------------------------------------ | ----------------------------------------- |
| `COUNT(*)`          | Total number of rows                 | `SELECT COUNT(*) FROM table;`             |
| `COUNT(column)`     | Number of non-null values            | `COUNT(email)`                            |
| `MIN()`             | Minimum value                        | `MIN(order_total)`                        |
| `MAX()`             | Maximum value                        | `MAX(created_at)`                         |
| `AVG()`             | Average of numeric values            | `AVG(score)`                              |
| `SUM()`             | Total sum of values                  | `SUM(profits)`                            |
| `STDDEV()`          | Standard deviation                   | `STDDEV(sales)`                           |
| `PERCENTILE_DISC()` | Exact percentile using rank ordering | `PERCENTILE_DISC(0.5) WITHIN GROUP (...)` |

---

## 🧠 Key Concepts

* `COUNT(*)` includes all rows, including NULLs
* `COUNT(column)` excludes NULLs — useful for data quality checks
* Use `GROUP BY` to compute summaries per category
* Standard deviation requires numeric columns — cast if needed
* Percentiles are ideal for detecting skewness and outliers

---

## ✅ Examples from This Project

| Use Case                      | Function(s) Used                  |
| ----------------------------- | --------------------------------- |
| Number of requests per street | `COUNT(*)`, `GROUP BY street`     |
| Detect missing zip codes      | `COUNT(*) - COUNT(zip)`           |
| Revenue summary by sector     | `AVG(revenue)`, `STDDEV(revenue)` |
| Daily question count trends   | `AVG(count)` per `DATE_TRUNC()`   |
| Outlier detection             | `PERCENTILE_DISC(0.95)`           |

---

## 🛠 Best Practices

* Always cast columns when unsure (`CAST(col AS NUMERIC)`)
* Use `GROUP BY` with caution — one wrong column can distort results
* Use `HAVING` instead of `WHERE` to filter aggregated values
* Combine with window functions for advanced summaries

---

*“Aggregate functions are your telescope — they reveal what the eye can’t see row by row.”*
