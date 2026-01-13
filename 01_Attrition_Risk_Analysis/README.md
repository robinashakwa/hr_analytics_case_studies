📄 README.md — Attrition Risk Analysis (Project 01)
🧑‍💼 HR Analytics Case Study — Attrition Risk Analysis
📌 Project Overview

Employee attrition is one of the most critical HR challenges. High turnover affects productivity, hiring costs, team morale, and long-term organizational performance.

This project analyzes employee attrition using SQL, Excel, and Power BI to understand:

Why employees leave

Which departments are most affected

Attrition trends over time

Performance & engagement patterns

Insights for improving retention

This is a real-world HR Analytics scenario used in interviews for HR Analyst, HR Operations, People Analytics, and Business Analyst roles.

🎯 Business Objective

The goal is to:

Identify key attrition drivers

Find high-risk departments and job roles

Build KPIs and dashboards for HR leadership

Recommend data-backed actions to improve retention
📊 Key KPIs
| KPI                        | Description                               |
| -------------------------- | ----------------------------------------- |
| **Total Employees**        | Total employees in dataset                |
| **Attrition Count**        | Number of employees who exited            |
| **Attrition Rate**         | % Employees leaving the company           |
| **Avg Engagement Score**   | Average engagement among active employees |
| **Avg Performance Rating** | Overall employee performance              |
| **Avg Salary**             | Average salary across departments         |
🗂 Dataset Description
1. employees_cleaned.xlsx
| Column             | Description                                        |
| ------------------ | -------------------------------------------------- |
| employee_id        | Unique employee identifier                         |
| department         | HR, Sales, Finance, IT, Marketing                  |
| job_role           | Analyst, Manager, Specialist, Executive, Associate |
| tenure_days        | Total days worked                                  |
| salary             | Annual salary                                      |
| performance_rating | (1–5 scale)                                        |
| engagement_score   | (1–100 scale)                                      |
| is_active          | 1 = Active, 0 = Exited                             |
2. attrition_cleaned.xlsx
| Column      | Description                     |
| ----------- | ------------------------------- |
| employee_id | Matching ID from employee table |
| exit_date   | Date of employee exit           |
| exit_type   | Voluntary / Involuntary         |
🧮 SQL Work (Data Processing)
📁 SQL Files Included
sql/
│── 01_create_tables.sql  
│── 02_attrition_queries.sql  
│── 03_insights_queries.sql  
📝 Example SQL Queries
1. Create Employee Table
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
2. Attrition Count
SELECT COUNT(*) AS attrition_count
FROM attrition_cleaned;
3. Attrition by Department
SELECT e.department, COUNT(a.employee_id) AS exits
FROM employees_cleaned e
JOIN attrition_cleaned a USING (employee_id)
GROUP BY e.department
ORDER BY exits DESC;
📈 Power BI Dashboard
📌 Dashboard Features

✔ KPI cards
✔ Attrition by Department
✔ Attrition by Job Role
✔ Attrition Trend Over Time
✔ Interactive slicers
✔ Employee Detail Table
✔ Insights for HR

📸 Dashboard Screenshots

(Add these files to /images/)

dashboard_overview.png

attrition_by_department.png

attrition_trend.png

🔍 Insights Summary
🟦 Department Insights

Sales & Marketing have the highest attrition.

Finance shows the most stability and lowest exits.

🟦 Job Role Insights

Associates and Executives show higher turnover.

Manager-level attrition is lower.

🟦 Tenure Insights

Employees leaving early (<2 years) form the majority of exits.

🟦 Performance & Engagement

Employees with lower engagement scores and lower performance ratings show higher exit rates.

🟦 Trend Insights

Exit spikes are seen during mid-year (June–August).

🧠 Recommendations for HR

✔ Strengthen onboarding & buddy programs for new hires
✔ Improve employee engagement initiatives
✔ Conduct retention interviews in Sales & Marketing
✔ Provide performance coaching for low-score employees
✔ Offer career development paths and internal mobility

🛠 Tools Used

Excel – Data cleaning

SQL – Data processing and merging

Power BI – Dashboard & insights

GitHub – Version control & documentation

▶️ How to Run This Project

Download the cleaned dataset from this folder

Load Excel sheets into Power BI

Create relationships using employee_id

Create DAX measures for KPIs

Reproduce visualizations and insights

📦 Project Structure
01_Attrition_Risk_Analysis/
│── README.md  
│── project01_data_raw.xlsx  
│── project01_data_cleaned.xlsx  
│── project01_attrition_dashboard.pbix  
│── powerbi/  
│── images/
│── sql/  
⭐ Final Note

This project demonstrates the complete lifecycle of HR Analytics:

✔ Data cleaning
✔ SQL data modeling
✔ Dashboard creation
✔ Insights + recommendations
✔ Professional documentation

Perfect for showcasing HR Analytics capability to recruiters.
