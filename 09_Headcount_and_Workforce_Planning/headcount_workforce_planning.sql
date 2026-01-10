/* =======================================================================
   Project 09: Headcount & Workforce Planning
   Purpose: Calculate total employee count, monthly workforce trends,
            hiring needs, separations, and future workforce forecasting.
   ======================================================================= */


---------------------------------------------------------------
-- 1. CURRENT HEADCOUNT
---------------------------------------------------------------

SELECT
    COUNT(*) AS current_headcount
FROM employees
WHERE termination_date IS NULL;



---------------------------------------------------------------
-- 2. HEADCOUNT BY DEPARTMENT
---------------------------------------------------------------

SELECT
    department,
    COUNT(*) AS department_headcount
FROM employees
WHERE termination_date IS NULL
GROUP BY department
ORDER BY department_headcount DESC;



---------------------------------------------------------------
-- 3. MONTHLY JOINERS
---------------------------------------------------------------

SELECT
    DATE_TRUNC('month', hire_date) AS month,
    COUNT(*) AS joiners
FROM employees
GROUP BY DATE_TRUNC('month', hire_date)
ORDER BY month;



---------------------------------------------------------------
-- 4. MONTHLY SEPARATIONS
---------------------------------------------------------------

SELECT
    DATE_TRUNC('month', termination_date) AS month,
    COUNT(*) AS separations
FROM employees
WHERE termination_date IS NOT NULL
GROUP BY DATE_TRUNC('month', termination_date)
ORDER BY month;



---------------------------------------------------------------
-- 5. NET HEADCOUNT CHANGE (JOINERS - SEPARATIONS)
---------------------------------------------------------------

WITH joiners AS (
    SELECT DATE_TRUNC('month', hire_date) AS month, COUNT(*) AS join_count
    FROM employees
    GROUP BY DATE_TRUNC('month', hire_date)
),
separations AS (
    SELECT DATE_TRUNC('month', termination_date) AS month, COUNT(*) AS sep_count
    FROM employees
    WHERE termination_date IS NOT NULL
    GROUP BY DATE_TRUNC('month', termination_date)
)

SELECT
    COALESCE(j.month, s.month) AS month,
    COALESCE(j.join_count, 0) AS joiners,
    COALESCE(s.sep_count, 0) AS separations,
    COALESCE(j.join_count, 0) - COALESCE(s.sep_count, 0) AS net_change
FROM joiners j
FULL OUTER JOIN separations s
    ON j.month = s.month
ORDER BY month;



---------------------------------------------------------------
-- 6. FORECASTING NEXT MONTH'S HEADCOUNT
---------------------------------------------------------------

WITH workforce_trend AS (
    SELECT
        DATE_TRUNC('month', hire_date) AS month,
        COUNT(*) AS joiners
    FROM employees
    GROUP BY DATE_TRUNC('month', hire_date)
),

separation_trend AS (
    SELECT
        DATE_TRUNC('month', termination_date) AS month,
        COUNT(*) AS separations
    FROM employees
    WHERE termination_date IS NOT NULL
    GROUP BY DATE_TRUNC('month', termination_date)
),

avg_trends AS (
    SELECT
        (SELECT AVG(joiners) FROM workforce_trend) AS avg_monthly_joiners,
        (SELECT AVG(separations) FROM separation_trend) AS avg_monthly_separations
)

SELECT
    (SELECT COUNT(*) FROM employees WHERE termination_date IS NULL) AS current_headcount,
    avg_monthly_joiners,
    avg_monthly_separations,
    (SELECT COUNT(*) FROM employees WHERE termination_date IS NULL)
      + avg_monthly_joiners - avg_monthly_separations AS forecast_next_month_headcount
FROM avg_trends;



---------------------------------------------------------------
-- 7. ROLE-BASED HIRING NEEDS
-- (Roles where headcount < budgeted_strength)
---------------------------------------------------------------

SELECT
    r.job_role,
    r.budgeted_headcount,
    COUNT(e.employee_id) AS current_headcount,
    (r.budgeted_headcount - COUNT(e.employee_id)) AS hiring_needed
FROM role_budget r
LEFT JOIN employees e
    ON r.job_role = e.job_role AND e.termination_date IS NULL
GROUP BY r.job_role, r.budgeted_headcount
HAVING (r.budgeted_headcount - COUNT(e.employee_id)) > 0;
