/* =============================================================
   Project 04: Compensation Equity Analysis
   Purpose: Identify unfair pay gaps across gender, job role,
            experience, and performance using compensation data.
   ============================================================= */


/* =============================================================
   1. BASE EMPLOYEE + SALARY + PERFORMANCE DATA
   ============================================================= */

WITH base_data AS (
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
        ON e.employee_id = p.employee_id
)


/* =============================================================
   2. MEDIAN COMPENSATION PER JOB ROLE
   ============================================================= */
, role_medians AS (
    SELECT
        job_role,
        PERCENTILE_CONT(0.5)
             WITHIN GROUP (ORDER BY total_compensation) AS median_compensation
    FROM base_data
    GROUP BY job_role
)


/* =============================================================
   3. MEDIAN PAY GAP BY GENDER (PER ROLE)
   ============================================================= */
, gender_pay_gap AS (
    SELECT
        job_role,

        /* Median male salary */
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY total_compensation)
        FILTER (WHERE gender = 'Male') AS median_male_salary,

        /* Median female salary */
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY total_compensation)
        FILTER (WHERE gender = 'Female') AS median_female_salary

    FROM base_data
    GROUP BY job_role
)


/* =============================================================
   4. EXPERIENCE vs COMPENSATION FAIRNESS
   ============================================================= */
, experience_avg AS (
    SELECT
        years_of_experience,
        AVG(total_compensation) AS avg_comp_for_experience_group
    FROM base_data
    GROUP BY years_of_experience
)


/* =============================================================
   5. FINAL MASTER COMPENSATION EQUITY REPORT
   ============================================================= */
SELECT
    b.employee_id,
    b.full_name,
    b.gender,
    b.department,
    b.job_role,
    b.years_of_experience,
    b.performance_rating,

    /* Compensation */
    b.base_salary,
    b.bonus,
    b.total_compensation,

    /* Median for job role */
    rm.median_compensation AS role_median_salary,

    /* Pay Equity Score */
    ROUND(b.total_compensation / rm.median_compensation, 2) AS pay_equity_score,

    /* Fairness Tag */
    CASE
        WHEN b.total_compensation >= rm.median_compensation * 0.90
            THEN 'Fairly Paid'
        ELSE 'Underpaid'
    END AS pay_equity_status,

    /* Gender pay gap (role level) */
    gpg.median_male_salary,
    gpg.median_female_salary,
    (gpg.median_male_salary - gpg.median_female_salary) AS gender_pay_gap_amount,
    ROUND(
        (gpg.median_male_salary - gpg.median_female_salary)
        / NULLIF(gpg.median_male_salary, 0), 3
    ) AS gender_pay_gap_percentage,

    /* Experience comparison */
    ea.avg_comp_for_experience_group,
    ROUND(
        b.total_compensation / ea.avg_comp_for_experience_group,
        2
    ) AS experience_salary_index

FROM base_data b
LEFT JOIN role_medians rm
    ON b.job_role = rm.job_role
LEFT JOIN gender_pay_gap gpg
    ON b.job_role = gpg.job_role
LEFT JOIN experience_avg ea
    ON b.years_of_experience = ea.years_of_experience

ORDER BY b.employee_id;

