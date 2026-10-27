
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
