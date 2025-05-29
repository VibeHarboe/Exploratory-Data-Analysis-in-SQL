# 📦 Grouping and Aggregation in SQL

Grouping allows you to organize data into logical subsets for analysis. When combined with aggregation functions like `SUM()`, `AVG()`, or `COUNT()`, it enables deep insights across categories, timeframes, or attributes.

---

## 🔁 Basic Syntax

```sql
SELECT category, COUNT(*)
  FROM evanston311
 GROUP BY category;
```

This query groups the data by `category` and counts how many rows exist in each.

---

## 🛠 Aggregation Functions Recap

| Function   | Purpose                          |
| ---------- | -------------------------------- |
| `COUNT()`  | Count of rows / non-null entries |
| `SUM()`    | Total of numeric values          |
| `AVG()`    | Arithmetic mean                  |
| `MIN()`    | Smallest value                   |
| `MAX()`    | Largest value                    |
| `STDDEV()` | Spread of values (deviation)     |

---

## 🧠 Grouping Logic

* **`GROUP BY`** defines the level of detail.
* **`HAVING`** filters groups *after* aggregation (like `WHERE`, but for aggregates).
* **`ORDER BY`** can be applied to aggregated columns.

### Example: Average completion time by category

```sql
SELECT category, AVG(date_completed - date_created) AS avg_days_open
  FROM evanston311
 GROUP BY category
 ORDER BY avg_days_open DESC;
```

---

## 🧰 Advanced Grouping Techniques

### 1. Multiple Columns

Group by combinations, e.g. `sector` + `year`:

```sql
GROUP BY sector, EXTRACT(YEAR FROM date_created)
```

### 2. Conditional Aggregation

```sql
SELECT
  priority,
  SUM(CASE WHEN description ILIKE '%@%' THEN 1 ELSE 0 END) AS email_count
FROM evanston311
GROUP BY priority;
```

### 3. `ROLLUP` and `CUBE` (if supported)

```sql
GROUP BY ROLLUP(category, priority)
```

These enable subtotal and grand total generation.

---

## 📍 Common Pitfalls

* Forgetting `GROUP BY` columns that appear in `SELECT`
* Using `WHERE` instead of `HAVING` for filters on aggregates
* Unintended aggregations from joins (check cardinality!)

---

## 🔍 In This Project

| Use Case                          | Technique                |
| --------------------------------- | ------------------------ |
| Requests per street               | Simple `GROUP BY`        |
| Profit analysis by sector         | Multiple groupings       |
| Exclude low-volume zip codes      | `HAVING count(*) > 100`  |
| Distribution of request durations | `GROUP BY interval bins` |

---

*“Group to make sense. Aggregate to see scale.”*
