# What Drives Job Satisfaction?

## Project Overview
This project investigates the key factors influencing employee job satisfaction using real-world HR data.
The analysis is based on the IBM HR Analytics dataset and focuses on demographic, organizational, and job-related variables.

The project was completed as a **final assignment for the _Data Analysis in R_ course (JEB157)** at the
Faculty of Social Sciences, Charles University.

## Research Goal
The main objective of this project is to identify which factors are most strongly associated with employee
job satisfaction and how these factors differ across departments and job roles.

## Data
- **Dataset:** IBM HR Analytics Employee Attrition & Performance  
- **Source:** Kaggle  
- **Observations:** 1,470 employees  
- **Type:** Employee-level HR data


### Key Variables
- Age  
- Gender  
- Department  
- Job Role  
- Monthly Income  
- Years at Company  
- Overtime  
- Job Satisfaction  
- Attrition  

## Methodology
The analysis was conducted entirely in **R** and includes:
- Data cleaning and variable selection  
- Descriptive statistics  
- Data visualization using `ggplot2`  
- Correlation analysis  
- Multiple linear regression to model job satisfaction  

## Files in This Repository
- `project.R` – main R script containing data preparation, analysis, and visualizations  
- `Final_report.pdf` – final written report with methodology, results, and discussion  
- `HR_Employee_Attrition.csv` – dataset used in the analysis  

## Libraries Used
- tidyverse  
- psych  
- ggplot2  
- car  
- GGally  

## Key Findings
The results show that job satisfaction varies significantly across employees and is influenced by both
economic factors (such as income) and organizational factors (such as overtime and job role).
The analysis highlights the importance of data-driven decision-making in human resource management.

## License
This project was created for educational purposes only.
