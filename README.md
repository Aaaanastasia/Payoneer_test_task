# Payoneer Risk & Compliance Test Task

This repository contains my solution for the Senior Data Analyst – Risk & Compliance test task at **Payoneer**.

---

## 📌 Task Overview

The task included three main parts:

1. **Bot Detection**  
   Identify suspected bot registrations based on form step timing.

2. **Summary for Compliance Manager**  
   Communicate insights and visualizations from bot detection analysis.

3. **EDD Policy Violation**  
   Detect customers who crossed the $1000 threshold before Enhanced Due Diligence (EDD) was completed.

---

## 🛠️ Tools Used

- Python (Pandas, Matplotlib, Seaborn)
- SQL (Window Functions, Aggregations)
- Jupyter Notebook
- Excel
- Git/GitHub

---

## 📁 Folder Structure

- `data/` — Source files used for the analysis  
- `notebooks/` — Python Jupyter Notebook with full analysis and visualizations  
- `graphs/` — Exported images for key plots  
- `sql/` — SQL queries used in the task  
- `presentation/` — Final summary deck (if submitted)

---

## 🔍 Highlights

### Bot Detection Criteria
- ⏱️ Average time between steps < 2 sec  
- 🔁 Very low standard deviation (almost identical timings)  
- 🔍 Users with 3 steps completed in under 1 second intervals

### Results
- 4 users flagged as suspected bots (see `graphs/`)

### EDD Violation Check
- Detected 2 customers who passed $1000 balance before EDD
- SQL logic used cumulative sum and timestamp comparison

### Visualizations
- 📊 Histogram: Avg step time per user
- 🔬 Scatter plot: Avg vs Std Dev with bot threshold
