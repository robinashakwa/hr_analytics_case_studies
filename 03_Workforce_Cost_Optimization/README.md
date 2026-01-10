# 📊 Project 03: Workforce Cost Optimization

## 🎯 Objective
The goal of this project is to understand **how much each employee costs the company** by analyzing:
- Salary cost  
- Overtime cost  
- Absenteeism cost  
- Training cost  
- Hiring cost  

This helps HR identify:
- High-cost departments  
- Employees with excessive overtime  
- Areas where cost reduction is possible  
- Budget forecasting opportunities  

---

## 🧠 Key Questions Answered
1. How much does each employee cost the company per year?
2. Which departments have the highest workforce expenses?
3. How much money is lost due to absenteeism?
4. How much overtime is paid, and to whom?
5. What are the top contributors to workforce cost?
6. Where can HR reduce cost without affecting productivity?

---

## 🗂️ Dataset Used
This project uses the following tables:

### **1. employees**
- employee_id  
- full_name  
- department  
- job_role  
- hire_date  
- termination_date  
- employment_type  

### **2. salaries**
- employee_id  
- base_salary  
- bonus  
- daily_salary  

### **3. overtime**
- employee_id  
- overtime_hours  
- overtime_rate  

### **4. absenteeism**
- employee_id  
- absence_date  
- absent_days  

### **5. training**
- employee_id  
- training_program  
- training_cost  

### **6. hiring**
- employee_id  
- recruitment_cost  
- onboarding_cost  

---

## 🧮 Key Metrics Calculated
### ✔ Salary Cost  
### ✔ Overtime Cost  
### ✔ Absenteeism Cost  
### ✔ Training Cost  
### ✔ Hiring Cost  
### ✔ Total Employee Cost  

---

## 🛠️ SQL Logic Summary
The SQL script calculates:
- Salary + Bonus  
- Overtime = hours × rate  
- Absenteeism = absent days × daily salary  
- Hiring = recruitment + onboarding  
- Final Cost = Salary + Overtime + Absenteeism + Training + Hiring  

---

## 📈 Final Output: Workforce Cost Summary
Your final table includes:
- Employee details  
- Salary cost  
- Overtime cost  
- Absenteeism cost  
- Training cost  
- Hiring cost  
- Total workforce cost per employee  

This data will be used for:
- Excel dataset  
- Power BI Dashboard  

---

## 📄 Files in This Folder
