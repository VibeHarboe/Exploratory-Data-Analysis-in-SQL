# 📅 Generate Series and Binning in SQL

Når man arbejder med tidsserier eller kontinuerlige data, kan man bruge `generate_series()` til at oprette dynamiske intervaller eller datoperioder. Det er især nyttigt til:

* At finde manglende datoer
* Gruppere data i bins (fx 50-intervaller)
* Oprette tilpassede aggregeringsvinduer (f.eks. 6 måneder)

---

## ⚙️ Funktion: `generate_series()`

```sql
-- Syntax:
SELECT generate_series(start, stop, step);
```

* `start`: Startdato eller værdi
* `stop`: Slutdato eller værdi
* `step`: Intervallet som fx '1 day', '6 months', 50 osv.

---

## 📊 Eksempler

### 1. Manglende datoer i tidsserier

```sql
SELECT day
  FROM (
    SELECT generate_series(MIN(date_created), MAX(date_created), '1 day')::date AS day
    FROM evanston311
  ) AS all_dates
 WHERE day NOT IN (
    SELECT date_created::date FROM evanston311
 );
```

### 2. Binning: Antal spørgsmål pr. 50 interval

```sql
WITH bins AS (
  SELECT generate_series(2200, 3050, 50) AS lower,
         generate_series(2250, 3100, 50) AS upper),
     dropbox AS (
  SELECT question_count FROM stackoverflow WHERE tag = 'dropbox')
SELECT lower, upper, COUNT(question_count)
  FROM bins
       LEFT JOIN dropbox
       ON question_count >= lower AND question_count < upper
 GROUP BY lower, upper
 ORDER BY lower;
```

### 3. Median requests pr. 6 måneders periode

```sql
WITH bins AS (
  SELECT generate_series('2016-01-01', '2018-01-01', '6 months') AS lower,
         generate_series('2016-07-01', '2018-07-01', '6 months') AS upper),
     daily_counts AS (
  SELECT day, COUNT(date_created) AS count
    FROM (
      SELECT generate_series('2016-01-01', '2018-06-30', '1 day')::date AS day
    ) AS daily_series
    LEFT JOIN evanston311 ON day = date_created::date
  GROUP BY day)
SELECT lower, upper,
       PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY count) AS median
  FROM bins
       LEFT JOIN daily_counts
       ON day >= lower AND day < upper
 GROUP BY lower, upper
 ORDER BY lower;
```

---

## 🧠 Tips

* Brug `LEFT JOIN` for at inkludere perioder uden hændelser
* Kombinér `generate_series()` med `date_trunc()` eller `percentile_disc()` for avanceret gruppering
* Brug `coalesce()` til at erstatte NULL med 0, hvis nødvendigt

---

*“Binning reveals trends — even when the data hides them.”*
