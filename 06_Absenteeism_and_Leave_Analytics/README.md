# 🚫 Project 06: Absenteeism & Leave Analytics

## 🎯 Objective
This project analyzes employee absenteeism to understand:
- Who takes the most leaves  
- How absenteeism impacts cost  
- Which departments are affected  
- Monthly absence trends  
- Employees with high absenteeism risk  

This helps HR identify:
- Productivity loss  
- Attendance issues  
- Training or intervention needs  
- Policy improvements  

---

## 🧠 Key Questions Answered
1. Which employees have the highest absenteeism?
2. How much does absenteeism cost the company?
3. Which departments face heavy absence patterns?
4. What is the month-by-month leave trend?
5. What is the absenteeism rate per employee?

---

## 📂 Datasets Used

### **employees**
- employee_id  
- full_name  
- department  

### **salaries**
- employee_id  
- daily_salary  

### **absenteeism**
- employee_id  
- absence_date  
- absent_days  

---

## 📊 Key Metrics Calculated
- Total absent days per employee  
- Absenteeism cost (days × daily salary)  
- Monthly absenteeism trend  
- High absenteeism employees  
- Absenteeism rate (%)  

---

## 🛠 SQL Summary

### ✔ Total Absence  
Sum of absent days per employee.

### ✔ Absenteeism Cost  
`absent_days × daily_salary`

### ✔ Monthly Trend  
Absences grouped by month & department.

### ✔ High Absenteeism  
Employees with more than 10 days absent.

### ✔ Absenteeism Rate  
`(total absent days / 260 working days) × 100`

---

## 📈 Final Output Includes
- Employee absence summary  
- Absenteeism cost per employee  
- Department-level absence patterns  
- Absenteeism rate  
- High absence flag  

Will be used to build:
- Excel dataset  
- Power BI visualizations  

---
