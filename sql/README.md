# Maji Ndogo SQL Analysis

## Project Overview
This folder documents SQL analysis for the Maji Ndogo water data project, focusing on data integrity and discrepancies between auditor scores and employee-recorded scores.

## Part 3: Data Integrity Investigation

### Objective
Investigate discrepancies in water quality scores and screen audit statements for potential integrity concerns.

### SQL Skills Demonstrated
- JOINs: Combined audit reports, visits, water quality records, and employee details.
- Views: Used the `incorrect_records` view to isolate mismatched scores from first visits.
- CTEs: Organized employee-level discrepancy analysis.
- Aggregate functions: Counted discrepancies and calculated average error counts.
- Window functions: Ranked employees and calculated their share of flagged records.
- Conditional aggregation: Compared statement matches for keywords such as `cash`, `bribe`, and `corruption`.

### Findings
Keyword screening identified statements associated with four employees that mentioned cash transactions:
- Bello Azibo: 8 cash mentions
- Zuriel Matembo: 5 cash mentions
- Malachi Mavuso: 4 cash mentions
- Lalitha Kaburi: 2 cash mentions

No statements matched the keyword `bribe`. Some statements also contained the word `corruption`.

### Limitations
Keyword matches and score discrepancies are indicators for further review, not proof of bribery or misconduct. Keyword counts may overlap because a statement can contain multiple terms.

### Portfolio Note
These SQL scripts are reconstructed learning examples based on database structures and queries verified during development. They are not claimed to be exact copies of the original coursework scripts.
