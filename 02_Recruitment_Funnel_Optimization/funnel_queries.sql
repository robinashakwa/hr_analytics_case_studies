-- RECRUITMENT FUNNEL STAGE ANALYSIS

-- 1. APPLICATIONS COUNT
SELECT COUNT(*) AS total_applications
FROM applications_raw;

-- 2. SCREENING PASSED
SELECT COUNT(*) AS screening_passed
FROM screening_raw
WHERE screening_pass = 1;

-- 3. INTERVIEWS ATTENDED
SELECT COUNT(*) AS interviewed
FROM interviews_raw
WHERE interview_round > 0;

-- 4. OFFERS MADE
SELECT COUNT(*) AS offers_made
FROM offers_raw
WHERE offer_status IN ('Accepted','Rejected','Pending');

-- 5. HIRES COMPLETED
SELECT COUNT(*) AS hired
FROM hires_raw
WHERE hire_status = 1;

-- 6. FUNNEL DROP-OFF SUMMARY
SELECT
    (SELECT COUNT(*) FROM applications_raw) AS stage_applications,
    (SELECT COUNT(*) FROM screening_raw WHERE screening_pass = 1) AS stage_screening,
    (SELECT COUNT(*) FROM interviews_raw WHERE interview_round > 0) AS stage_interview,
    (SELECT COUNT(*) FROM offers_raw WHERE offer_status IN ('Accepted','Rejected','Pending')) AS stage_offer,
    (SELECT COUNT(*) FROM hires_raw WHERE hire_status = 1) AS stage_hired;
