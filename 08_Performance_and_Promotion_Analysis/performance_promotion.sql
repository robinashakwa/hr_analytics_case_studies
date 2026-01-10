/* ========================================================================
   Project 08: Performance & Promotion Analysis
   Purpose: Analyze employee performance trends, identify top performers,
            evaluate promotion decisions, and ensure promotion fairness.
   ======================================================================== */


---------------------------------------------------------------
-- 1. EMPLOYEE PERFORMANCE SUMMARY
---------------------------------------------------------------

SELECT
    e.employee_id,
    e.full_name,
    e.department,
    e.job_role,
    p.performance_year,
    p.performance_rating
FROM performance p
LEFT JOIN employees e
    ON p.employee_id = e.employee_id
ORDER BY e.employee_id, p.performance_year;



---------------------------------------------------------------
-- 2. AVERAGE PERFORMANCE PER EMPLOYEE
---------------------------------------------------------------

SELECT
    p.employee_id,
    e.full_name,
    AVG(p.performance_rating) AS avg_performance_rating
FROM performance p
LEFT JOIN employees e
    ON p.employee_id = e.employee_id
GROUP BY p.employee_id, e.full_name;



---------------------------------------------------------------
-- 3. TOP PERFORMERS (RATING ≥ 4)
---------------------------------------------------------------

SELECT
    p.employee_id,
    e.full_name,
    AVG(p.performance_rating) AS avg_rating
FROM performance p
LEFT JOIN employees e
    ON p.employee_id = e.employee_id
GROUP BY p.employee_id, e.full_name
HAVING AVG(p.performance_rating) >= 4;



---------------------------------------------------------------
-- 4. PERFORMANCE TREND (IMPROVING / DECLINING)
---------------------------------------------------------------

SELECT
    p.employee_id,
    e.full_name,
    MIN(p.performance_rating) AS min_rating,
    MAX(p.performance_rating) AS max_rating,
    CASE 
        WHEN MAX(p.performance_rating) > MIN(p.performance_rating)
            THEN 'Improving'
        WHEN MAX(p.performance_rating) < MIN(p.performance_rating)
            THEN 'Declining'
        ELSE 'Consistent'
    END AS performance_trend
FROM performance p
LEFT JOIN employees e
    ON p.employee_id = e.employee_id
GROUP BY p.employee_id, e.full_name;



---------------------------------------------------------------
-- 5. PROMOTION HISTORY DETAILS
---------------------------------------------------------------

SELECT
    pr.employee_id,
    e.full_name,
    pr.promotion_date,
    pr.previous_role,
    pr.new_role,
    pr.promotion_status
FROM promotions pr
LEFT JOIN employees e
    ON pr.employee_id = e.employee_id
ORDER BY pr.promotion_date DESC;



---------------------------------------------------------------
-- 6. PERFORMANCE BEFORE AND AFTER PROMOTION
---------------------------------------------------------------

SELECT
    pr.employee_id,
    e.full_name,
    pr.promotion_date,

    -- Performance 1 year before promotion
    (SELECT AVG(p1.performance_rating)
     FROM performance p1
     WHERE p1.employee_id = pr.employee_id
       AND p1.performance_year = EXTRACT(YEAR FROM pr.promotion_date) - 1
    ) AS performance_before,

    -- Performance 1 year after promotion
    (SELECT AVG(p2.performance_rating)
     FROM performance p2
     WHERE p2.employee_id = pr.employee_id
       AND p2.performance_year = EXTRACT(YEAR FROM pr.promotion_date) + 1
    ) AS performance_after

FROM promotions pr
LEFT JOIN employees e
    ON pr.employee_id = e.employee_id;



---------------------------------------------------------------
-- 7. PROMOTION FAIRNESS CHECK
-- (Was the employee a high performer before promotion?)
---------------------------------------------------------------

SELECT
    pr.employee_id,
    e.full_name,
    AVG(p.performance_rating) AS avg_rating_before_promotion,
    pr.previous_role,
    pr.new_role,
    CASE
        WHEN AVG(p.performance_rating) >= 4 THEN 'Fair Promotion'
        ELSE 'Questionable Promotion'
    END AS promotion_fairness
FROM promotions pr
LEFT JOIN performance p
    ON pr.employee_id = p.employee_id
LEFT JOIN employees e
    ON pr.employee_id = e.employee_id
WHERE p.performance_year < EXTRACT(YEAR FROM pr.promotion_date)
GROUP BY pr.employee_id, e.full_name, pr.previous_role, pr.new_role;



---------------------------------------------------------------
-- 8. DEPARTMENT PERFORMANCE SUMMARY
---------------------------------------------------------------

SELECT
    e.department,
    AVG(p.performance_rating) AS avg_dept_performance
FROM performance p
LEFT JOIN employees e
    ON p.employee_id = e.employee_id
GROUP BY e.department
ORDER BY avg_dept_performance DESC;
