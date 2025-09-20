# ⏳ Time Differences and Lag Functions in SQL

Analyses that depend on sequence, history, or delays between events require specialized SQL functions such as `LAG()`, `LEAD()`, and differences between timestamps.

---

## 📌 Key Functions

| Function | Purpose | Example |
| --------------------------------- | ------------------------------------------------ | ----------------------------------------------- |
| `LAG(column) OVER (ORDER BY ...)` | Returns the value from the previous row | `LAG(date_created) OVER (ORDER BY date_created)` |
| `LEAD(column) OVER (ORDER BY ...)`| Returns the value from the next row | `LEAD(profits) OVER (ORDER BY year)` |
| `ts2 - ts1` | Subtraction between two timestamps (gives interval) | `date_completed - date_created` |
| `EXTRACT(EPOCH FROM interval)` | Converts an interval into seconds (numeric) | `EXTRACT(EPOCH FROM gap)` |                  |

---

## 🔍 Examples


### 1. Time between two events:


```sql
SELECT
date_created,
LAG(date_created) OVER (ORDER BY date_created) AS previous,
date_created - LAG(date_created) OVER (ORDER BY date_created) AS gap
FROM evanston311;
```

### 2. Difference in value over time:


```sql
SELECT
date,
profits,
profits - LAG(profits) OVER (ORDER BY date) AS change
FROM company_financials;
```


### 3. Average time between events:


```sql
WITH gaps AS (
SELECT
date_created - LAG(date_created) OVER (ORDER BY date_created) AS gap
FROM evanston311
)
SELECT AVG(gap) FROM gaps;
```


---


## 🎯 Use Cases


* Time-based process analysis
* Customer journey and flow analysis
* Delays between events
* Financial performance and development over time
