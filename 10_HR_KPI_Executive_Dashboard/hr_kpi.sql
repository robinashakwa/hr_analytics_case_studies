/* ==========================================================================
   Project 10: HR KPI Executive Dashboard
   Purpose: Build foundational HR KPIs for leadership dashboards including
            headcount, hiring, attrition, absenteeism, performance,
            promotion, and workforce cost.
   ========================================================================== */


---------------------------------------------------------------
-- 1. TOTAL HEADCOUNT (ACTIVE EMPLOYEES)
---------------------------------------------------------------

SELECT
    COUNT(*) AS total_headcount
FROM employees
WHERE termination_date IS NULL;



---------------------------------------------------------------
-- 2. MONTHLY NEW HIRES
---------------------------------------------------------------

SELECT
    DATE_TRUNC('month', hire_date) AS month,
    COUNT(*) AS total_hires
FROM employees
GROUP BY DATE_TRUNC('month', hire_date)
ORDER BY month;



---------------------------------------------------------------
-- 3. MONTHLY ATTRITION
---------------------------------------------------------------

SELECT
    DATE_TRUNC('month', termination_date) AS month,
    COUNT(*) AS total_attrition
FROM employees
WHERE termination_date IS NOT NULL
GROUP BY DATE_TRUNC('month', termination_date)
ORDER BY month;



---------------------------------------------------------------
-- 4. ATTRITION RATE
---------------------------------------------------------------

SELECT
    (SELECT COUNT(*) FROM employees WHERE termination_date IS NOT NULL) * 1.0
    /
    (SELECT COUNT(*) FROM employees) 
    AS attrition_rate;



---------------------------------------------------------------
-- 5. GENDER RATIO
---------------------------------------------------------------

SELECT
    gender,
    COUNT(*) AS count_by_gender
FROM employees
WHERE termination_date IS NULL
GROUP BY gender;



---------------------------------------------------------------
-- 6. AVERAGE PERFORMANCE SCORE
---------------------------------------------------------------

SELECT
    AVG(performance_rating) AS avg_performance_score
FROM performance;



---------------------------------------------------------------
-- 7. PROMOTION RATE
---------------------------------------------------------------

SELECT
    (SELECT COUNT(*) FROM promotions WHERE promotion_status = 'Promoted') * 1.0
    /
    (SELECT COUNT(*) FROM employees) AS promotion_rate;



---------------------------------------------------------------
-- 8. ABSENTEEISM RATE
---------------------------------------------------------------

SELECT
    (SELECT SUM(absent_days) FROM absenteeism) * 1.0
    /
    (SELECT COUNT(*) * 260 FROM employees) AS absenteeism_rate;
    -- assuming 260 total working days per year



---------------------------------------------------------------
-- 9. AVERAGE COST PER EMPLOYEE
---------------------------------------------------------------

SELECT
    AVG(
        s.base_salary
        + s.bonus
        + COALESCE(ot.overtime_cost,0)
        + COALESCE(ab.absenteeism_cost,0)
        + COALESCE(t.training_cost,0)
        + COALESCE(h.hiring_cost,0)
    ) AS avg_cost_per_employee

FROM employees e

LEFT JOIN (
    SELECT employee_id, base_salary, bonus
    FROM salaries
) s ON e.employee_id = s.employee_id

LEFT JOIN (
    SELECT employee_id, SUM(overtime_hours * overtime_rate) AS overtime_cost
    FROM overtime
    GROUP BY employee_id
) ot ON e.employee_id = ot.employee_id

LEFT JOIN (
    SELECT a.employee_id, SUM(a.absent_days * s.daily_salary) AS absenteeism_cost
    FROM absenteeism a
    LEFT JOIN salaries s ON a.employee_id = s.employee_id
    GROUP BY a.employee_id
) ab ON e.employee_id = ab.employee_id

LEFT JOIN (
    SELECT employee_id, SUM(training_cost) AS training_cost
    FROM training
    GROUP BY employee_id
) t ON e.employee_id = t.employee_id

LEFT JOIN (
    SELECT employee_id, SUM(recruitment_cost + onboarding_cost) AS hiring_cost
    FROM hiring
    GROUP BY employee_id
) h ON e.employee_id = h.employee_id;



---------------------------------------------------------------
-- 10. DEPARTMENT HEADCOUNT
---------------------------------------------------------------

SELECT
    department,
    COUNT(*) AS dept_headcount
FROM employees
WHERE termination_date IS NULL
GROUP BY department
ORDER BY dept_headcount DESC;
