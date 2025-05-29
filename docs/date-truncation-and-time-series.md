# 📆 Date Truncation and Time Series Analysis in SQL

Når du arbejder med tidsbaserede data, er det afgørende at kunne gruppere og analysere efter datoenheder (dag, måned, år). `DATE_TRUNC()` gør dette nemt og kraftfuldt i SQL.

---

## ✂️ Funktion: `DATE_TRUNC()`

```sql
DATE_TRUNC('field', timestamp)
```

* Returnerer en timestamp, trunkeret til den angivne enhed
* Felter kan være: `'day'`, `'month'`, `'year'`, `'hour'`, etc.

---

## 📊 Eksempler

### 1. Antal oprettede forespørgsler pr. måned:

```sql
SELECT DATE_TRUNC('month', date_created) AS month,
       COUNT(*) AS request_count
  FROM evanston311
 GROUP BY month
 ORDER BY month;
```

### 2. Gennemsnit pr. måned inkl. 0-værdier (missing dates):

```sql
WITH all_days AS (
  SELECT generate_series('2016-01-01', '2018-06-30', '1 day') AS date
),
daily_count AS (
  SELECT DATE_TRUNC('day', date_created) AS day,
         COUNT(*) AS count
    FROM evanston311
   GROUP BY day
)
SELECT DATE_TRUNC('month', date) AS month,
       AVG(COALESCE(count, 0)) AS avg_requests
  FROM all_days
       LEFT JOIN daily_count ON all_days.date = daily_count.day
 GROUP BY month
 ORDER BY month;
```

### 3. Median requests per dag i 6-måneders bins:

```sql
WITH bins AS (
  SELECT generate_series('2016-01-01', '2018-01-01', '6 months') AS lower,
         generate_series('2016-07-01', '2018-07-01', '6 months') AS upper
),
daily_counts AS (
  SELECT day, COUNT(date_created) AS count
    FROM (
      SELECT generate_series('2016-01-01', '2018-06-30', '1 day')::date AS day
    ) AS daily_series
         LEFT JOIN evanston311 ON day = date_created::date
   GROUP BY day
)
SELECT lower, upper,
       PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY count) AS median
  FROM bins
       LEFT JOIN daily_counts ON day >= lower AND day < upper
 GROUP BY lower, upper
 ORDER BY lower;
```

---

## 🧠 Tips

* Brug `DATE_TRUNC()` til at samle data over tid uden at miste højere tidsenheder
* Kombinér med `generate_series()` for at håndtere huller i dataserier
* Brug `COALESCE()` for at sikre, at NULL-værdier behandles korrekt

---

*“Den bedste måde at forstå tidsmønstre er at tæmme uger, måneder og år i meningsfulde bidder.”*
