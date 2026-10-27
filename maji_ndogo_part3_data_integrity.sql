
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


-- 6. Identify employees with above-average discrepancy counts

WITH employee_errors AS (
    SELECT
        employee_name,
        COUNT(*) AS error_count
    FROM incorrect_records
    GROUP BY employee_name
),
average_errors AS (
    SELECT AVG(error_count) AS average_error_count
    FROM employee_errors
)
SELECT
    ee.employee_name,
    ee.error_count,
    ROUND(ae.average_error_count, 2) AS average_error_count
FROM employee_errors AS ee
CROSS JOIN average_errors AS ae
WHERE ee.error_count > ae.average_error_count
ORDER BY ee.error_count DESC;


-- 7. Calculate each employee's percentage of all discrepancies

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
    ROUND(
        100.0 * error_count / SUM(error_count) OVER (),
        2
    ) AS percentage_of_discrepancies
FROM employee_errors
ORDER BY error_count DESC;
