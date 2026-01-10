/* =======================================================================
   Project 07: Training & Skills Impact Analysis
   Purpose: Measure training effectiveness by analyzing improvement in
            performance, productivity, and ROI for training programs.
   ======================================================================= */


---------------------------------------------------------------
-- 1. TOTAL TRAINING HOURS & COST PER EMPLOYEE
---------------------------------------------------------------

SELECT
    t.employee_id,
    e.full_name,
    e.department,
    SUM(t.training_hours) AS total_training_hours,
    SUM(t.training_cost) AS total_training_cost
FROM training t
LEFT JOIN employees e
    ON t.employee_id = e.employee_id
GROUP BY t.employee_id, e.full_name, e.department;



---------------------------------------------------------------
-- 2. TRAINING EFFECT ON PERFORMANCE
---------------------------------------------------------------

SELECT
    t.employee_id,
    e.full_name,
    p_before.performance_rating AS before_training_rating,
    p_after.performance_rating AS after_training_rating,
    (p_after.performance_rating - p_before.performance_rating) AS performance_improvement
FROM training t
LEFT JOIN employees e
    ON t.employee_id = e.employee_id
LEFT JOIN performance_before p_before
    ON t.employee_id = p_before.employee_id
LEFT JOIN performance_after p_after
    ON t.employee_id = p_after.employee_id
GROUP BY t.employee_id, e.full_name, p_before.performance_rating, p_after.performance_rating;



---------------------------------------------------------------
-- 3. TRAINING EFFECT ON PRODUCTIVITY
---------------------------------------------------------------

SELECT
    t.employee_id,
    e.full_name,
    AVG(prod_before.tasks_per_hour) AS avg_productivity_before,
    AVG(prod_after.tasks_per_hour) AS avg_productivity_after,
    (AVG(prod_after.tasks_per_hour) - AVG(prod_before.tasks_per_hour)) AS productivity_gain
FROM training t
LEFT JOIN employees e
    ON t.employee_id = e.employee_id
LEFT JOIN productivity_before prod_before
    ON t.employee_id = prod_before.employee_id
LEFT JOIN productivity_after prod_after
    ON t.employee_id = prod_after.employee_id
GROUP BY t.employee_id, e.full_name;



---------------------------------------------------------------
-- 4. TRAINING PROGRAM EFFECTIVENESS
---------------------------------------------------------------

SELECT
    t.training_program,
    AVG(p_after.performance_rating - p_before.performance_rating) AS avg_performance_improvement,
    AVG(prod_after.tasks_per_hour - prod_before.tasks_per_hour) AS avg_productivity_gain,
    AVG(t.training_cost) AS avg_program_cost
FROM training t
LEFT JOIN performance_before p_before
    ON t.employee_id = p_before.employee_id
LEFT JOIN performance_after p_after
    ON t.employee_id = p_after.employee_id
LEFT JOIN productivity_before prod_before
    ON t.employee_id = prod_before.employee_id
LEFT JOIN productivity_after prod_after
    ON t.employee_id = prod_after.employee_id
GROUP BY t.training_program;



---------------------------------------------------------------
-- 5. TRAINING ROI (RETURN ON INVESTMENT)
---------------------------------------------------------------

SELECT
    t.employee_id,
    e.full_name,
    total_training_cost,
    performance_improvement,
    (performance_improvement / NULLIF(total_training_cost, 0)) AS roi
FROM (
    SELECT
        t.employee_id,
        SUM(t.training_cost) AS total_training_cost,
        (p_after.performance_rating - p_before.performance_rating) AS performance_improvement
    FROM training t
    LEFT JOIN performance_before p_before
        ON t.employee_id = p_before.employee_id
    LEFT JOIN performance_after p_after
        ON t.employee_id = p_after.employee_id
    GROUP BY t.employee_id, p_before.performance_rating, p_after.performance_rating
) t
LEFT JOIN employees e
    ON t.employee_id = e.employee_id;
