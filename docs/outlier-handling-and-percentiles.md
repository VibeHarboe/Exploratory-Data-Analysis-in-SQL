# 🎯 Outlier Handling and Percentiles in SQL

Når man arbejder med virkelige datasæt, er det vigtigt at kunne identificere og håndtere ekstreme værdier (outliers), som kan skævvride gennemsnit og beslutninger. SQL tilbyder percentile-funktioner og filtreringsteknikker til dette formål.

---

## 📊 Percentiler og fordelinger

### Funktion: `PERCENTILE_DISC()`

```sql
PERCENTILE_DISC(fraction) WITHIN GROUP (ORDER BY value)
```

* **Brug**: Returnerer den diskrete værdi ved et givet percentilniveau (fx median = 0.5)

### Eksempel: 95. percentil af responstid

```sql
SELECT PERCENTILE_DISC(0.95) WITHIN GROUP (ORDER BY date_completed - date_created)
  FROM evanston311;
```

---

## 🧹 Filtrering af outliers

For at udelukke de øverste X%:

```sql
SELECT category,
       AVG(date_completed - date_created) AS avg_completion_time
  FROM evanston311
 WHERE (date_completed - date_created) < (
         SELECT PERCENTILE_DISC(0.95) WITHIN GROUP (ORDER BY date_completed - date_created)
         FROM evanston311)
 GROUP BY category;
```

---

## 🧠 Kombinér med `CORR()`

Analyser hvordan outliers påvirker korrelationer.

```sql
SELECT CORR(avg_completion, count)
  FROM (
    SELECT date_trunc('month', date_created) AS month,
           AVG(EXTRACT(EPOCH FROM date_completed - date_created)) AS avg_completion,
           COUNT(*)
      FROM evanston311
     WHERE category = 'Rodents- Rats'
     GROUP BY month
  ) AS monthly_avgs;
```

---

## 🧮 Brugsscenarier

* Udelukke ekstreme sager ved estimering af gennemsnitlig svartid
* Sammenligne performance uden skævvredne data
* Forstå sæsonvariationer uden at miste præcision

---

*“Good analysts see the pattern — great analysts see what doesn’t belong in it.”*
