# ⏳ Time Differences and Lag Functions in SQL

Analyser, der afhænger af rækkefølge, historik eller forsinkelser mellem begivenheder, kræver specialiserede SQL-funktioner som `LAG()`, `LEAD()` og forskelle mellem timestamps.

---

## 📌 Centrale funktioner

| Funktion                           | Formål                                            | Eksempel                                         |
| ---------------------------------- | ------------------------------------------------- | ------------------------------------------------ |
| `LAG(column) OVER (ORDER BY ...)`  | Returnerer værdien fra forrige række              | `LAG(date_created) OVER (ORDER BY date_created)` |
| `LEAD(column) OVER (ORDER BY ...)` | Returnerer værdien fra næste række                | `LEAD(profits) OVER (ORDER BY year)`             |
| `ts2 - ts1`                        | Subtraktion mellem to timestamps (giver interval) | `date_completed - date_created`                  |
| `EXTRACT(EPOCH FROM interval)`     | Konverterer et interval til sekunder (numerisk)   | `EXTRACT(EPOCH FROM gap)`                        |

---

## 🔍 Eksempler

### 1. Tid mellem to hændelser:

```sql
SELECT
  date_created,
  LAG(date_created) OVER (ORDER BY date_created) AS previous,
  date_created - LAG(date_created) OVER (ORDER BY date_created) AS gap
FROM evanston311;
```

### 2. Forskellen i værdi over tid:

```sql
SELECT
  date,
  profits,
  profits - LAG(profits) OVER (ORDER BY date) AS change
FROM company_financials;
```

### 3. Gennemsnitlig tid mellem hændelser:

```sql
WITH gaps AS (
  SELECT
    date_created - LAG(date_created) OVER (ORDER BY date_created) AS gap
  FROM evanston311
)
SELECT AVG(gap) FROM gaps;
```

---

## 🎯 Brugsscenarier

* Tidsbaseret procesanalyse
* Kunderejse- og flow-analyser
* Forsinkelser mellem hændelser
* Finansiel performance og udvikling over tid
