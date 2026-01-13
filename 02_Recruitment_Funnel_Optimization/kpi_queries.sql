-- RECRUITMENT KPI QUERIES

-- 1. Offer Acceptance Rate
SELECT 
    SUM(CASE WHEN offer_status = 'Accepted' THEN 1 ELSE 0 END) * 1.0 /
    SUM(CASE WHEN offer_status IN ('Accepted','Rejected','Pending') THEN 1 ELSE 0 END)
    AS offer_acceptance_rate
FROM offers_raw;

-- 2. Overall Conversion Rate (Application → Hire)
SELECT
    (SELECT COUNT(*) FROM hires_raw WHERE hire_status = 1) * 1.0 /
    (SELECT COUNT(*) FROM applications_raw) AS overall_conversion_rate;

-- 3. Average Time to Hire
SELECT AVG(DATEDIFF(day, application_date, hire_date)) AS avg_time_to_hire
FROM applications_raw a
JOIN hires_raw h USING (candidate_id)
WHERE h.hire_status = 1;

-- 4. Cost Per Hire
SELECT AVG(cost_to_hire) AS avg_cost_per_hire
FROM hires_raw
WHERE hire_status = 1;

-- 5. Hires by Recruiter
SELECT recruiter, COUNT(*) AS hires
FROM applications_raw a
JOIN hires_raw h USING (candidate_id)
WHERE h.hire_status = 1
GROUP BY recruiter
ORDER BY hires DESC;

-- 6. Hires by Department
SELECT department, COUNT(*) AS hires
FROM applications_raw a
JOIN hires_raw h USING (candidate_id)
WHERE h.hire_status = 1
GROUP BY department;
