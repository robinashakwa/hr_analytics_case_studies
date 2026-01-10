# ⚡ Project 05: Workforce Productivity Analysis

## 🎯 Objective
This project measures how productive employees are by analyzing:
- Tasks completed  
- Hours worked  
- Productivity per hour  
- Monthly productivity trends  
- Department performance  

The goal is to identify:
- High performers  
- Low performers  
- Departments needing improvement  
- Productivity patterns over time  

---

## 🧠 Key Questions Answered
1. Which employees are most productive?
2. Who needs performance improvement?
3. Which departments perform better or worse?
4. How does productivity change month by month?
5. What is the average productivity per hour?

---

## 📂 Datasets Used

### **employees**
- employee_id  
- full_name  
- department  

### **productivity**
- employee_id  
- work_date  
- tasks_completed  
- hours_worked  

---

## 📊 Key Metrics Calculated
- Productivity per hour  
- Monthly productivity score  
- Department average productivity  
- Low productivity employees  
- Top 10% performers  

---

## 🛠 SQL Summary
The SQL script calculates:

### ✔ Daily Productivity  
`tasks_completed / hours_worked`

### ✔ Monthly Productivity  
Sum of tasks and hours grouped by month

### ✔ Department Productivity  
Average productivity per department

### ✔ Low Performers  
Employees below 1 task per hour

### ✔ Top Performers  
Employees in top 10% percentile

---

## 📈 Final Output Includes
- Employee productivity level  
- Monthly performance trend  
- Department productivity ranking  
- List of low performers  
- List of top performers  

This will be used to build:
- Excel dataset  
- Power BI dashboard  

---

