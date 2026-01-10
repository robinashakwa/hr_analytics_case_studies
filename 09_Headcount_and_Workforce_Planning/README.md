# 👥 Project 09: Headcount & Workforce Planning

## 🎯 Objective
This project helps HR understand:
- How many employees the company has  
- Who is joining and who is leaving  
- Which departments are growing or shrinking  
- Monthly workforce changes  
- Hiring needs  
- Future headcount forecast  

This supports strategic workforce planning and budgeting.

---

## 🧠 Key Questions Answered
1. What is the total employee headcount today?
2. How many employees joined each month?
3. How many employees left each month?
4. Which departments lost or gained people?
5. What is the net headcount change monthly?
6. How many employees will we have next month?
7. Which roles require hiring based on budget?

---

## 📂 Datasets Used

### **employees**
- employee_id  
- full_name  
- department  
- hire_date  
- termination_date  
- job_role  

### **role_budget**
- job_role  
- budgeted_headcount  

---

## 📊 Key Metrics Calculated
- Current headcount  
- Department-wise headcount  
- Monthly joiners  
- Monthly separations  
- Net headcount change  
- Hiring needs (per role)  
- Forecasted headcount  

---

## 🛠 SQL Summary

### ✔ Current Headcount  
All active employees (termination_date IS NULL).

### ✔ Monthly Trends  
Joiners vs Separations per month.

### ✔ Net Change  
`joiners - separations`

### ✔ Forecasting  
Uses average joiners & separations to predict future headcount.

### ✔ Hiring Need  
Compares actual headcount vs budgeted headcount.

---

## 📈 Final Outputs
- Employee movement analysis  
- Departmental staffing trends  
- Forecasted staffing levels  
- Roles with hiring gaps  
- HR strategic workforce dashboard inputs  

---

