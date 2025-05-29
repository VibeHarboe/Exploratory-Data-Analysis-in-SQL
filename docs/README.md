# 📘 docs/

This folder contains structured documentation to support the understanding, use, and presentation of all SQL techniques and concepts covered in the project. It is intended as a **reference and explainer layer** for anyone reviewing the repository — from peers and recruiters to hiring managers and fellow data professionals.

---

## 📂 Folder Purpose

Organize and centralize all documentation in markdown format that explains:

* SQL theory and syntax used
* Practical examples and use cases
* Annotated guides for window functions, CTEs, correlations, and more
* Supplementary resources and learning notes (e.g., from DataCamp, exam prep, etc.)

This documentation mirrors what might be available in a `wiki/` or `knowledge_base/` in a real-world data team.

---

## 📑 Content Types

### ✅ Cheatsheets

Quick-reference guides for SQL topics like:

* Window functions
* Aggregations
* Joins
* Data types and casting
* Temporal functions (e.g., `DATE_TRUNC`, `EXTRACT`, `NOW()`)

### ✅ Explained Concepts

More in-depth explanations with examples:

* `window-functions-explained.md`
* `ctes-and-subqueries.md`
* `eda-strategies-in-sql.md`

### ✅ Study Notes

Curated insights and key learnings extracted from the DataCamp SQL curriculum:

* `Exploratory Data Analysis in SQL_study_notes.md`
* Annotated flashcards and exam prep materials

---

## 🧭 Folder Strategy

Every markdown document in `docs/` serves as both a standalone learning aid and a supporting layer to the actual `.sql` files and project workflow.

* Each file is **task-specific**, meaning it's designed to answer a clear question or support a particular concept.
* Use internal cross-links if documents are related.
* Designed for reuse across future projects.

---

## 📌 How to Use

* Pair `.sql` code with its corresponding `.md` explainer
* Use when onboarding new analysts or reviewing concepts pre-interview
* Export or print for physical learning (e.g. laminated cheat sheets 💡)

---

*Document to understand. Script to analyze.*
