📄 Attrition Risk Analysis — HR Analytics Case Study
🧑‍💼 Project Overview

Employee attrition is a major challenge for HR teams. High turnover impacts:

Hiring costs

Team productivity

Engagement levels

Organizational stability

This project analyzes employee attrition using SQL, Excel, and Power BI to uncover patterns, identify high-risk areas, and provide data-driven recommendations for improving retention.

🎯 Business Objective

The goal of this analysis is to:

Identify which departments and roles experience the highest attrition

Understand key patterns such as performance, engagement, and tenure

Analyze monthly attrition trends

Build KPIs and dashboards used by HR leadership

Provide actionable recommendations to reduce turnover

📊 Key Metrics (KPIs)
| KPI                            | Description                              |
| ------------------------------ | ---------------------------------------- |
| **Total Employees**            | Total number of employees in the dataset |
| **Attrition Count**            | Number of employees who exited           |
| **Attrition Rate**             | Percentage of employees who left         |
| **Average Salary**             | Company-wide average salary              |
| **Average Performance Rating** | Overall performance rating               |
| **Average Engagement Score**   | Engagement level among employees         |
🗂 Dataset Description
employees_cleaned.xlsx
| Column             | Description                                  |
| ------------------ | -------------------------------------------- |
| employee_id        | Unique employee identifier                   |
| department         | Department of employment                     |
| job_role           | Job role such as Manager, Analyst, Executive |
| tenure_days        | Number of days employed                      |
| salary             | Employee salary                              |
| performance_rating | Rating from 1 to 5                           |
| engagement_score   | Score from 1 to 100                          |
| is_active          | 1 = Active, 0 = Exited                       |
attrition_cleaned.xlsx
| Column      | Description                               |
| ----------- | ----------------------------------------- |
| employee_id | Unique identifier matching employee table |
| exit_date   | Date of exit                              |
| exit_type   | Voluntary or involuntary                  |
🧮 SQL Work

SQL scripts used for:

Cleaning raw datasets

Creating employee and attrition tables

Joining datasets

Building metrics such as attrition by department, job role, and tenure

Example Queries
1️⃣ Create employee table
CREATE TABLE employees_cleaned (
    employee_id INT,
    department VARCHAR(50),
    job_role VARCHAR(50),
    tenure_days INT,
    salary INT,
    performance_rating INT,
    engagement_score INT,
    is_active INT
);
2️⃣ Attrition by Department
SELECT e.department, COUNT(a.employee_id) AS exits
FROM employees_cleaned e
JOIN attrition_cleaned a USING (employee_id)
GROUP BY e.department
ORDER BY exits DESC;
All SQL scripts are available in the /sql folder.
📈 Power BI Dashboard

The dashboard includes:

✔ KPI Cards

Total Employees

Attrition Count

Attrition Rate

Avg Salary

Avg Performance

Avg Engagement

✔ Visualizations

Attrition by Department (Bar Chart)

Attrition by Job Role (Bar Chart)

Attrition Trend Over Time (Line Chart)

Slicers: Department, Job Role, Performance Rating

Employee Detail Table

✔ Dashboard Insights Summary

Sales & Marketing have the highest attrition

Finance shows the lowest attrition

Attrition rate is 38.4%

Majority exits occur early in tenure (<2 years)

Lower engagement & performance correlate with higher attrition

Peak exit months observed around mid-year

Dashboard file:
👉 project01_attrition_dashboard.pbix
🔍 Insights Summary
🟦 Department-level Observations

Sales and Marketing are high-risk areas

Finance has better employee stability

🟦 Job Role Insights

Associates and Executives show higher turnover

Manager-level attrition is relatively low

🟦 Performance & Engagement

Lower engagement employees leave more often

Performance rating 1–2 employees show higher risk

🟦 Tenure-based Observations

High exits occur in the first 1–2 years of employment
🧠 Recommendations for HR

✔ Improve onboarding experience for new employees
✔ Launch engagement and wellness programs
✔ Conduct stay interviews for high-risk job roles
✔ Provide training and coaching for low performers
✔ Monitor early-tenure employees more closely
✔ Strengthen retention incentives in Sales & Marketing
🛠 Tools Used

Excel – Data cleaning

SQL – Data transformation & analysis

Power BI – Dashboard & reporting

GitHub – Version control & project documentation
📦 Project Structure
01_Attrition_Risk_Analysis/
│── README.md  
│── project01_data_raw.xlsx  
│── project01_data_cleaned.xlsx  
│── project01_attrition_dashboard.pbix  
│── images/  
│── sql/  
│── powerbi/  
▶️ How to Run This Project

Download datasets from this folder

Load both Excel sheets into Power BI

Create relationship on employee_id

Build DAX measures for KPIs

Reproduce visuals

Review insights & recommendations

