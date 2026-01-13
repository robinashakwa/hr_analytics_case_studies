-- CREATE TABLES FOR RECRUITMENT FUNNEL ANALYSIS

-- 1. APPLICATIONS TABLE
CREATE TABLE applications_raw (
    candidate_id INT PRIMARY KEY,
    department VARCHAR(50),
    application_date DATE,
    source VARCHAR(100),
    recruiter VARCHAR(100)
);

-- 2. SCREENING TABLE
CREATE TABLE screening_raw (
    candidate_id INT,
    screening_pass INT
);

-- 3. INTERVIEWS TABLE
CREATE TABLE interviews_raw (
    candidate_id INT,
    interview_round INT,        -- 0 = none, 1 = first round, 2 = final round
    interview_score INT
);

-- 4. OFFERS TABLE
CREATE TABLE offers_raw (
    candidate_id INT,
    offer_status VARCHAR(50)    -- Accepted / Rejected / Pending / No Offer
);

-- 5. HIRES TABLE
CREATE TABLE hires_raw (
    candidate_id INT,
    hire_status INT,            -- 1 = hired, 0 = not hired
    hire_date DATE,
    cost_to_hire INT
);
