💰 Project 04: Compensation Equity Analysis
🧩 Business Problem

Fair and unbiased compensation practices are essential for employee satisfaction, retention, and organizational trust.
Companies must ensure that pay decisions are not influenced by gender, inconsistent job role benchmarks, or unequal reward distribution based on performance or experience.

This project analyzes employee compensation data to identify inequities and support HR in building a transparent and fair salary structure.

🎯 Objective

To evaluate whether employees are compensated fairly across:

Gender

Job roles

Experience levels

Performance ratings

This analysis helps HR teams detect:

Gender-based pay gaps

Roles with inconsistent compensation

Underpaid employees

Experience vs salary mismatches

Performance reward fairness

🧠 Key Questions Answered

Are men and women paid equally for the same job?

Which job roles show the widest salary variation?

Are top performers rewarded fairly compared to low performers?

Does higher experience correlate with higher compensation?

Who are the employees earning below the fair pay benchmark?

📂 Datasets Used
1. employees
| Column              | Description                |
| ------------------- | -------------------------- |
| employee_id         | Unique employee identifier |
| full_name           | Employee name              |
| gender              | Male / Female / Other      |
| department          | Business unit              |
| job_role            | Employee role              |
| years_of_experience | Total work experience      |
2. salaries
| Column       | Description               |
| ------------ | ------------------------- |
| employee_id  | FK to employees           |
| base_salary  | Annual base salary        |
| bonus        | Annual bonus amount       |
| daily_salary | Salary ÷ 260 working days |
3. performance
| Column             | Description        |
| ------------------ | ------------------ |
| employee_id        | FK to employees    |
| performance_rating | Rating scale (1–5) |
🧮 Key Metrics Calculated
🔹 1. Total Compensation
total_compensation = base_salary + bonus
🔹 2. Role Median Salary

Used as a benchmark to determine fair compensation.

🔹 3. Gender Pay Gap %
gender_pay_gap = (median_male_salary - median_female_salary) / median_male_salary
🔹 4. Pay Equity Score
pay_equity_score = total_compensation / median_role_salary
🔹 5. Experience-Adjusted Salary Index

Evaluates whether salary aligns with employee experience level.
🛠 SQL Logic Summary

The SQL script performs the following:

Join employees, salaries, and performance datasets

Calculate total compensation

Find the median salary per job role

Compare male vs female compensation by role

Calculate pay equity score (fair / underpaid)

Analyze performance vs compensation alignment

Generate a final dataset for Power BI visualization

📈 Final Output Structure

The final summary table includes:

Employee details

Total compensation

Role median salary

Pay equity score

Gender pay gap indicators

Experience vs compensation insights

Compensation fairness tag: “Fairly Paid” or “Underpaid”

This dataset will be used to build:

📊 Power BI dashboards

📑 HR reports

📉 Pay gap insights

🧮 Compensation fairness models

📊 Expected Power BI Visuals

Salary distribution by gender

Median salary by job role

Experience vs salary scatter plot

Performance rating vs compensation chart

Pay equity score heatmap

Underpaid employees list

Gender pay gap KPI cards

🏁 Outcome

This project delivers a complete compensation equity analysis framework, enabling HR teams to:

Ensure fairness

Improve pay transparency

Support bias-free decision-making

Strengthen employee trust
