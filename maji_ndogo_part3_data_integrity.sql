
-- Project: Maji Ndogo - Data Integrity Investigation
-- Purpose: Identify discrepancies between auditor scores and
-- employee-recorded water quality scores.
--
-- Note: This is a portfolio reconstruction based on the verified
-- database view, not a copy of the original coursework script.

-- 1. Inspect records identified by the incorrect_records view

SELECT *
FROM incorrect_records
LIMIT 10;


-- 2. Count the records flagged by the view

SELECT COUNT(*) AS total_incorrect_records
FROM incorrect_records;


-- 3. Summarize discrepancies by employee

SELECT
    employee_name,
    COUNT(*) AS discrepancy_count
FROM incorrect_records
GROUP BY employee_name
ORDER BY discrepancy_count DESC;

-- 4. Search statements for possible corruption indicators
-- These keywords flag records for further investigation;
-- they do not prove wrongdoing.

SELECT
    employee_name,
    statements,
    COUNT(*) AS flagged_records
FROM incorrect_records
WHERE LOWER(statements) LIKE '%cash%'
   OR LOWER(statements) LIKE '%bribe%'
   OR LOWER(statements) LIKE '%corruption%'
GROUP BY employee_name, statements
ORDER BY flagged_records DESC;


-- 5. Rank employees by the number of discrepancies
-- Higher counts warrant further review but do not prove misconduct.

WITH employee_errors AS (
    SELECT
        employee_name,
        COUNT(*) AS error_count
    FROM incorrect_records
    GROUP BY employee_name
)
SELECT
    employee_name,
    error_count,
    RANK() OVER (ORDER BY error_count DESC) AS error_rank
FROM employee_errors
ORDER BY error_count DESC;
