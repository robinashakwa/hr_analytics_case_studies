/* ================================================================
   Project 05: Workforce Productivity Analysis
   Purpose: Measure productivity at employee and department level,
            identify low performers, and track monthly trends.
   ================================================================ */


---------------------------------------------------------------
-- 1. DAILY PRODUCTIVITY SCORE
---------------------------------------------------------------

SELECT
    p.employee_id,
    e.full_name,
    e.department,
    p.work_date,
    p.tasks_completed,
    p.hours_worked,
    (p.tasks_completed / NULLIF(p.hours_worked, 0)) AS productivity_per_hour
FROM productivity p
LEFT JOIN employees e
    ON p.employee_id = e.employee_id;



---------------------------------------------------------------
-- 2. MONTHLY PRODUCTIVITY SUMMARY
---------------------------------------------------------------

SELECT
    p.employee_id,
    e.full_name,
    e.department,
    DATE_TRUNC('month', p.work_date) AS month,
    SUM(p.tasks_completed) AS total_tasks,
    SUM(p.hours_worked) AS total_hours,
    (SUM(p.tasks_completed) / NULLIF(SUM(p.hours_worked), 0)) AS avg_productivity
FROM productivity p
LEFT JOIN employees e
    ON p.employee_id = e.employee_id
GROUP BY p.employee_id, e.full_name, e.department, DATE_TRUNC('month', p.work_date);



---------------------------------------------------------------
-- 3. DEPARTMENT PRODUCTIVITY COMPARISON
---------------------------------------------------------------

SELECT
    e.department,
    AVG(p.tasks_completed / NULLIF(p.hours_worked, 0)) AS avg_department_productivity
FROM productivity p
LEFT JOIN employees e
    ON p.employee_id = e.employee_id
GROUP BY e.department;



---------------------------------------------------------------
-- 4. LOW PRODUCTIVITY EMPLOYEES (THRESHOLD < 1 TASK/HOUR)
---------------------------------------------------------------

SELECT
    p.employee_id,
    e.full_name,
    AVG(p.tasks_completed / NULLIF(p.hours_worked, 0)) AS avg_productivity_per_hour
FROM productivity p
LEFT JOIN employees e
    ON p.employee_id = e.employee_id
GROUP BY p.employee_id, e.full_name
HAVING AVG(p.tasks_completed / NULLIF(p.hours_worked, 0)) < 1;



---------------------------------------------------------------
-- 5. TOP PERFORMERS (TOP 10%)
---------------------------------------------------------------

WITH employee_avg AS (
    SELECT
        p.employee_id,
        e.full_name,
        AVG(p.tasks_completed / NULLIF(p.hours_worked, 0)) AS avg_productivity
    FROM productivity p
    LEFT JOIN employees e
        ON p.employee_id = e.employee_id
    GROUP BY p.employee_id, e.full_name
)

SELECT *
FROM employee_avg
WHERE avg_productivity >= (
    SELECT PERCENTILE_CONT(0.9)
    WITHIN GROUP (ORDER BY avg_productivity)
    FROM employee_avg
);
