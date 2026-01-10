/* =================================================================
   Project 06: Absenteeism & Leave Analytics
   Purpose: Analyze employee absence patterns, identify high
            absenteeism cases, and calculate financial impact.
   ================================================================= */


---------------------------------------------------------------
-- 1. EMPLOYEE TOTAL ABSENCE SUMMARY
---------------------------------------------------------------

SELECT
    a.employee_id,
    e.full_name,
    e.department,
    SUM(a.absent_days) AS total_absent_days
FROM absenteeism a
LEFT JOIN employees e
    ON a.employee_id = e.employee_id
GROUP BY a.employee_id, e.full_name, e.department;



---------------------------------------------------------------
-- 2. ABSENTEEISM COST (DAYS MISSED × DAILY SALARY)
---------------------------------------------------------------

SELECT
    a.employee_id,
    e.full_name,
    SUM(a.absent_days) AS total_absent_days,
    s.daily_salary,
    (SUM(a.absent_days) * s.daily_salary) AS absenteeism_cost
FROM absenteeism a
LEFT JOIN employees e
    ON a.employee_id = e.employee_id
LEFT JOIN salaries s
    ON a.employee_id = s.employee_id
GROUP BY a.employee_id, e.full_name, s.daily_salary;



---------------------------------------------------------------
-- 3. MONTHLY ABSENCE TREND (PER DEPARTMENT)
---------------------------------------------------------------

SELECT
    e.department,
    DATE_TRUNC('month', a.absence_date) AS month,
    SUM(a.absent_days) AS monthly_absent_days
FROM absenteeism a
LEFT JOIN employees e
    ON a.employee_id = e.employee_id
GROUP BY e.department, DATE_TRUNC('month', a.absence_date)
ORDER BY month, e.department;



---------------------------------------------------------------
-- 4. HIGH ABSENTEEISM EMPLOYEES (THRESHOLD > 10 DAYS)
---------------------------------------------------------------

SELECT
    a.employee_id,
    e.full_name,
    SUM(a.absent_days) AS total_absent
FROM absenteeism a
LEFT JOIN employees e
    ON a.employee_id = e.employee_id
GROUP BY a.employee_id, e.full_name
HAVING SUM(a.absent_days) > 10;



---------------------------------------------------------------
-- 5. ABSENTEEISM RATE PER EMPLOYEE
-- (Total absent days ÷ total working days)
---------------------------------------------------------------

SELECT
    a.employee_id,
    e.full_name,
    SUM(a.absent_days) AS total_absent_days,
    260 AS total_working_days,     -- assuming standard working year
    ROUND((SUM(a.absent_days) / 260.0) * 100, 2) AS absenteeism_rate_percent
FROM absenteeism a
LEFT JOIN employees e
    ON a.employee_id = e.employee_id
GROUP BY a.employee_id, e.full_name;
