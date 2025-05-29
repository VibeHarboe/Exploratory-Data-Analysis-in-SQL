# 🧱 Data Types and Casting in SQL

Correct use of data types is critical in SQL, especially during exploratory analysis. It affects query performance, filtering logic, and the accuracy of aggregations and comparisons. Casting enables the conversion between types — essential when dealing with inconsistent or mixed-type data.

---

## 🗂️ Common Data Types

| Type        | Description                               | Example Values              |
| ----------- | ----------------------------------------- | --------------------------- |
| `INTEGER`   | Whole numbers                             | 1, 0, -32                   |
| `NUMERIC`   | Precise decimal numbers                   | 123.45, -0.01               |
| `TEXT`      | String-based values                       | 'abc', 'Sales - Europe'     |
| `BOOLEAN`   | True or false values                      | TRUE, FALSE                 |
| `DATE`      | Calendar dates without time               | 2024-06-01                  |
| `TIMESTAMP` | Dates with time (no timezone)             | 2024-06-01 14:23:00         |
| `INTERVAL`  | Durations between two timestamps or dates | '3 days', '2 months 5 days' |

---

## 🔁 Casting in SQL

Use casting to convert one type to another:

### 1. Using `CAST()`

```sql
SELECT CAST('3.14' AS NUMERIC);
```

### 2. Using `::` shortcut

```sql
SELECT '3.14'::NUMERIC;
```

---

## ⚠️ Why Casting Matters

* Comparing numbers and strings can yield incorrect results.
* Joining across tables may fail if data types don’t match.
* Aggregations like `AVG()` or `CORR()` require numeric types.
* Dates stored as text won’t work with date functions until cast.

---

## 🧪 Examples from This Project

| Scenario                                | Type Issue                     | Solution                           |
| --------------------------------------- | ------------------------------ | ---------------------------------- |
| `revenues / employees`                  | Integer division               | Cast `employees` as `NUMERIC`      |
| Comparing `'2016-01-01'` to `TIMESTAMP` | Type mismatch (string vs time) | Cast to `DATE` or `TIMESTAMP`      |
| Calculating correlations                | Requires numeric fields        | Ensure both columns are cast       |
| Time intervals between events           | Stored as `INTERVAL`           | Use `EXTRACT(EPOCH FROM interval)` |

---

## ✅ Best Practices

* Always validate types with `pg_typeof(column)` (PostgreSQL).
* Avoid implicit casting in JOIN or WHERE clauses.
* Use `::NUMERIC` when doing division to avoid rounding/truncation.
* Convert strings to proper date/timestamp format before filtering.

---

*“If your data type is wrong, everything downstream breaks.”*
