# 🧼 Text Cleaning and Standardization in SQL

Working with real-world data often means handling messy or inconsistent text. SQL provides essential tools for cleaning, transforming, and standardizing strings directly within the database.

This is particularly useful when performing categorization, pattern matching, or exploratory analysis on free-text fields like addresses, street names, or request descriptions.

---

## 🔧 Common String Functions

| Function              | Description                                             | Example Usage                          |
| --------------------- | ------------------------------------------------------- | -------------------------------------- |
| `LOWER()` / `UPPER()` | Standardize case                                        | `LOWER(name)`                          |
| `TRIM()`              | Remove leading/trailing whitespace or custom characters | `TRIM(street)`                         |
| `LTRIM()` / `RTRIM()` | Remove left/right padding                               | `LTRIM(street)`                        |
| `REPLACE()`           | Replace substrings within a string                      | `REPLACE(text, 'Trash', 'Refuse')`     |
| `SPLIT_PART()`        | Extract part of a string based on delimiter             | `SPLIT_PART(category, '-', 1)`         |
| `SUBSTRING()`         | Extract substring using a pattern or position           | `SUBSTRING(description FROM 1 FOR 30)` |
| `ILIKE` / `LIKE`      | Pattern matching (case-insensitive / case-sensitive)    | `description ILIKE '%rats%'`           |

---

## 🧠 Use Cases in This Project

| Objective                          | Function Used                         |
| ---------------------------------- | ------------------------------------- |
| Extract first word of street names | `SPLIT_PART(street, ' ', 1)`          |
| Clean inconsistent suffixes        | `TRIM(street, '1234567890#/ ')`       |
| Detect email and phone formats     | `LIKE '%@%'`, `LIKE '%___-___-____%'` |
| Shorten long descriptions          | `LEFT()` + `CASE WHEN LENGTH()>`      |
| Merge category variants            | `UPDATE` + `REPLACE()` + `JOIN`       |

---

## 🧪 Pattern Matching Tips

* Use `%` to match any sequence of characters
* Use `_` to match a single character
* `ILIKE` is case-insensitive (PostgreSQL only)
* Combine with `NOT LIKE` to exclude patterns

---

## 🚧 Common Issues

* Inconsistent delimiters (slashes, dashes, spaces)
* Embedded metadata in strings
* Repetition of similar phrases (e.g., “Trash Cart”, “Cart – Trash”)
* Mixed use of casing or special characters

---

## 💡 Best Practices

* Standardize case and trim before filtering
* Use `TEMP TABLE` for large-scale recoding or replacement
* Test patterns with `SELECT DISTINCT` before applying globally
* Avoid regex unless absolutely needed — simpler functions are faster and easier to read

---

*“If numbers are facts, text is context. Clean both before trusting either.”*
