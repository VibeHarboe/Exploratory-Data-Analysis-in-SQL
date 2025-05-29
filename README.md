# Exploratory Data Analysis in SQL

Welcome to the **Exploratory Data Analysis (EDA) in SQL** repository. This project showcases essential SQL skills and techniques learned through DataCamp's Exploratory Data Analysis in SQL course.

## Project Overview

This repository demonstrates the key concepts, methodologies, and practical applications of exploratory data analysis using PostgreSQL. You'll find structured SQL scripts, comprehensive documentation, and examples of real-world analyses.

## Repository Structure

```
Exploratory-Data-Analysis-in-SQL/
├── LICENSE
├── README.md
├── certificate/
│   ├── Exploratory Data Analysis Certificate.png
│   └── README.md
├── data/
│   ├── README.md
│   └── erdiagram.png
├── docs/
│   ├── Numeric-data-summary.md
│   ├── Text-data-analysis.md
│   ├── Date-time-analysis.md
│   └── README.md
├── sql/
│   ├── 01_Database_Structure.sql
│   ├── 02_Numeric_Analysis.sql
│   ├── 03_Text_Analysis.sql
│   ├── 04_Date_Time_Analysis.sql
│   └── README.md
└── visuals/
    ├── README.md
    └── Data-distribution-example.png
```

## Key SQL Topics

### 1. Database Structure

* Understanding tables, primary keys, foreign keys, and constraints.
* Essential commands for database exploration: `information_schema` queries.

### 2. Numeric Data Analysis

* Aggregation and summary statistics: `AVG`, `MIN`, `MAX`, `SUM`.
* Variance, standard deviation, correlation, and binning techniques.

### 3. Text Data Analysis

* Character types (`char`, `varchar`, `text`), case conversion (`UPPER`, `LOWER`).
* Splitting, trimming, and concatenating text data.

### 4. Date and Time Analysis

* Handling dates, timestamps, and intervals.
* Aggregation by date/time, `date_trunc`, `extract`, and generating date/time series.

## Practical Examples

* SQL scripts in the `/sql` directory illustrate typical EDA tasks such as:

  * Summarizing data distributions and identifying outliers.
  * Cleaning text fields for consistent analysis.
  * Aggregating data by time intervals to identify trends and patterns.

## Certification

Find the course certificate in the `/certificate` directory, confirming successful completion of DataCamp's Exploratory Data Analysis in SQL.

## Documentation

Detailed markdown files in `/docs` provide clear explanations and examples for each SQL concept, making the repository a valuable reference.

## Data & Visuals

* ER diagrams and relevant images are stored in the `/data` directory.
* Visual examples of data distributions and analyses are in the `/visuals` directory.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
