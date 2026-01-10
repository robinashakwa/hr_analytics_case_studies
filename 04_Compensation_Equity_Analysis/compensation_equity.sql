/* =============================================================
   Project 04: Compensation Equity Analysis
   Purpose: Identify unfair pay gaps across gender, role,
            performance, and experience.
   ============================================================= */


/* =============================================================
   1. BASE EMPLOYEE + SALARY DATA
   ============================================================= */

SELECT
    e.employee_id,
    e.full_name,
    e.gender,
    e.department,
    e.job_role,
    e.years_of_experience,
    p.performance_rating,
    s.base_salary,
    s.bonus,
    (s.base_salary + s.bonus) AS total_compensation
FROM employees e
LEFT JOIN salaries s
    ON e.employee_id = s.employee_id
LEFT JOIN performance p
    ON e.employee_id = p.employee_id;



/* =============================================================
   2. MEDIAN SALARY PER JOB ROLE
   ============================================================= */

SELECT
    job_role,
    PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY total_compensation) AS median_salary
FROM (
    SELECT
        e.job_role,
        (s.base_salary + s.bonus) AS total_compensation
    FROM employees e
    LEFT JOIN salaries s
        ON e.employee_id = s.employee_id
) x
GROUP BY job_role;



/* =============================================================
   3. GENDER PAY GAP BY JOB ROLE
   ============================================================= */

SELECT
    job_role,
    AVG(CASE WHEN gender = 'Male' THEN total_compensation END) AS avg_male_salary,
    AVG(CASE WHEN gender = 'Female' THEN total_compensation END) AS avg_female_salary,
    (
        AVG(CASE WHEN gender = 'Male' THEN total_compensation END)
        - AVG(CASE WHEN gender = 'Female' THEN total_compensation END)
    ) AS gender_pay_gap
FROM (
    SELECT
        e.gender,
        e.job_role,
        (s.base_salary + s.bonus) AS total_compensation
    FROM employees e
    LEFT JOIN salaries s
        ON e.employee_id = s.employee_id
) x
GROUP BY job_role;



/* =============================================================
   4. PAY EQUITY SCORE PER EMPLOYEE
   ============================================================= */

SELECT
    e.employee_id,
    e.full_name,
    e.job_role,
    total_compensation,
    m.median_salary,
    
    CASE
        WHEN total_compensation >= m.median_salary * 0.9 THEN 'Fairly Paid'
        ELSE 'Underpaid'
    END AS pay_equity_status

FROM (
    SELECT
        e.employee_id,
        e.full_name,
        e.job_role,
        (s.base_salary + s.bonus) AS total_compensation
    FROM employees e
    LEFT JOIN salaries s
        ON e.employee_id = s.employee_id
) e
LEFT JOIN (
    SELECT
        job_role,
        PERCENTILE_CONT(0.5)
           WITHIN GROUP (ORDER BY (base_salary + bonus)) AS median_salary
    FROM salaries s
    LEFT JOIN employees e
        ON s.employee_id = e.employee_id
    GROUP BY job_role
) m
ON e.job_role = m.job_role;



/* =============================================================
   5. EXPERIENCE VS COMPENSATION FAIRNESS
   ============================================================= */

SELECT
    e.employee_id,
    e.full_name,
    e.years_of_experience,
    total_compensation,
    AVG(total_compensation) OVER (PARTITION BY years_of_experience) AS avg_comp_for_experience_group
FROM (
    SELECT
        e.employee_id,
        e.full_name,
        e.years_of_experience,
        (s.base_salary + s.bonus) AS total_compensation
    FROM employees e
    LEFT JOIN salaries s
        ON e.employee_id = s.employee_id
) e;
