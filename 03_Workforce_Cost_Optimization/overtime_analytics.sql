/* ============================================================
   Project 03: Workforce Cost Optimization
   Purpose: Calculate total workforce cost including salary,
            overtime, absenteeism, training, and hiring costs.
   ============================================================ */


---------------------------------------------------------------
-- 1. BASE EMPLOYEE DATA
---------------------------------------------------------------
SELECT
    employee_id,
    full_name,
    department,
    job_role,
    hire_date,
    termination_date,
    employment_type
FROM employees;



---------------------------------------------------------------
-- 2. SALARY COST
---------------------------------------------------------------
SELECT
    e.employee_id,
    e.department,
    s.base_salary,
    s.bonus,
    (s.base_salary + s.bonus) AS total_salary_cost
FROM employees e
LEFT JOIN salaries s
    ON e.employee_id = s.employee_id;



---------------------------------------------------------------
-- 3. OVERTIME COST
---------------------------------------------------------------
SELECT
    o.employee_id,
    e.department,
    o.overtime_hours,
    o.overtime_rate,
    (o.overtime_hours * o.overtime_rate) AS overtime_cost
FROM overtime o
LEFT JOIN employees e
    ON o.employee_id = e.employee_id;



---------------------------------------------------------------
-- 4. ABSENTEEISM COST
---------------------------------------------------------------
SELECT
    a.employee_id,
    e.department,
    a.absent_days,
    (a.absent_days * s.daily_salary) AS absenteeism_cost
FROM absenteeism a
LEFT JOIN employees e
    ON a.employee_id = e.employee_id
LEFT JOIN salaries s
    ON a.employee_id = s.employee_id;



---------------------------------------------------------------
-- 5. TRAINING COST
---------------------------------------------------------------
SELECT
    t.employee_id,
    e.department,
    t.training_program,
    t.training_cost
FROM training t
LEFT JOIN employees e
    ON t.employee_id = e.employee_id;



---------------------------------------------------------------
-- 6. HIRING COST
---------------------------------------------------------------
SELECT
    h.employee_id,
    h.recruitment_cost,
    h.onboarding_cost,
    (h.recruitment_cost + h.onboarding_cost) AS total_hiring_cost
FROM hiring h;



---------------------------------------------------------------
-- 7. FINAL WORKFORCE COST SUMMARY (MASTER REPORT)
---------------------------------------------------------------

SELECT
    e.employee_id,
    e.full_name,
    e.department,

    -- Salary
    (s.base_salary + s.bonus) AS total_salary_cost,

    -- Overtime
    COALESCE(ot.overtime_cost, 0) AS overtime_cost,

    -- Absenteeism
    COALESCE(ab.absenteeism_cost, 0) AS absenteeism_cost,

    -- Training
    COALESCE(t.training_cost, 0) AS training_cost,

    -- Hiring
    COALESCE(h.total_hiring_cost, 0) AS hiring_cost,

    -- Total employee cost
    (
        (s.base_salary + s.bonus)
        + COALESCE(ot.overtime_cost, 0)
        + COALESCE(ab.absenteeism_cost, 0)
        + COALESCE(t.training_cost, 0)
        + COALESCE(h.total_hiring_cost, 0)
    ) AS total_employee_cost

FROM employees e

LEFT JOIN salaries s
    ON e.employee_id = s.employee_id

LEFT JOIN (
    SELECT employee_id,
           (overtime_hours * overtime_rate) AS overtime_cost
    FROM overtime
) ot
    ON e.employee_id = ot.employee_id

LEFT JOIN (
    SELECT
        a.employee_id,
        (a.absent_days * s.daily_salary) AS absenteeism_cost
    FROM absenteeism a
    LEFT JOIN salaries s
        ON a.employee_id = s.employee_id
) ab
    ON e.employee_id = ab.employee_id

LEFT JOIN training t
    ON e.employee_id = t.employee_id

LEFT JOIN (
    SELECT
        employee_id,
        (recruitment_cost + onboarding_cost) AS total_hiring_cost
    FROM hiring
) h
    ON e.employee_id = h.employee_id;

