# This helps avoid bugs caused by old objects hanging around
rm(list = ls())

# Load libraries that will be used throughout the analysis
library(tidyverse)
library(psych)
library(ggplot2)
library(car)
library(GGally)

# Load the HR dataset
hr <- read.csv("HR_Employee_Attrition.csv")

# Check of what the data looks like
str(hr)
head(hr)

# Keep only the variables that are relevant for this analysis
hr_sel <- hr %>%
  select(
    Age,
    Gender,
    Department,
    JobRole,
    MonthlyIncome,
    YearsAtCompany,
    OverTime,
    JobSatisfaction,
    Attrition
  )

# Check if there are any missing values
colSums(is.na(hr_sel))

# Convert categorical variables to factors
hr_sel$Gender <- as.factor(hr_sel$Gender)
hr_sel$Department <- as.factor(hr_sel$Department)
hr_sel$JobRole <- as.factor(hr_sel$JobRole)
hr_sel$OverTime <- as.factor(hr_sel$OverTime)
hr_sel$Attrition <- as.factor(hr_sel$Attrition)

# Basic descriptive statistics for key numerical variables
describe(
  hr_sel %>%
    select(Age, MonthlyIncome, YearsAtCompany, JobSatisfaction)
)

# Histogram of job satisfaction
ggplot(hr_sel, aes(x = JobSatisfaction)) +
  geom_histogram(binwidth = 1) +
  labs(
    title = "Distribution of Job Satisfaction",
    x = "Job Satisfaction",
    y = "Frequency"
  )

# Job satisfaction across departments
ggplot(hr_sel, aes(x = Department, y = JobSatisfaction)) +
  geom_boxplot() +
  labs(
    title = "Job Satisfaction by Department",
    x = "Department",
    y = "Job Satisfaction"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Simple bar chart showing employee attrition
ggplot(hr_sel, aes(x = Attrition)) +
  geom_bar() +
  labs(
    title = "Employee Attrition",
    x = "Attrition",
    y = "Count"
  )

# Two-sample t-test
# Checks whether job satisfaction differs between employees who left and those who stayed
t.test(JobSatisfaction ~ Attrition, data = hr_sel)

# One-way ANOVA
# Tests if average job satisfaction differs across departments
anova_model <- aov(JobSatisfaction ~ Department, data = hr_sel)
summary(anova_model)

# Correlation matrix for numerical variables
# Helps identify simple linear relationships
cor(
  hr_sel %>%
    select(Age, MonthlyIncome, YearsAtCompany, JobSatisfaction)
)

# Scatterplot matrix with correlations
ggpairs(
  hr_sel %>%
    select(Age, MonthlyIncome, YearsAtCompany, JobSatisfaction)
)

# Multiple linear regression model: job satisfaction explained by income, tenure, age and overtime
model <- lm(
  JobSatisfaction ~ MonthlyIncome + YearsAtCompany + Age + OverTime,
  data = hr_sel
)

# Model summary with coefficients and significance levels
summary(model)

# Save the fitted model so it can be reused later if needed
saveRDS(model, "job_satisfaction_model.rds")

# Save plots that will be used in the report

p1 <- ggplot(hr_sel, aes(x = JobSatisfaction)) +
  geom_histogram(binwidth = 1) +
  labs(
    title = "Distribution of Job Satisfaction",
    x = "Job Satisfaction",
    y = "Frequency"
  )
ggsave("figure1_job_satisfaction_distribution.png", p1, width = 6, height = 4)

p2 <- ggplot(hr_sel, aes(x = Department, y = JobSatisfaction)) +
  geom_boxplot() +
  labs(
    title = "Job Satisfaction by Department",
    x = "Department",
    y = "Job Satisfaction"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
ggsave("figure2_job_satisfaction_department.png", p2, width = 6, height = 4)

p3 <- ggplot(hr_sel, aes(x = Attrition)) +
  geom_bar() +
  labs(
    title = "Employee Attrition",
    x = "Attrition",
    y = "Count"
  )
ggsave("figure3_employee_attrition.png", p3, width = 5, height = 4)

p4 <- ggplot(hr_sel, aes(x = MonthlyIncome, y = JobSatisfaction)) +
  geom_point(alpha = 0.4) +
  labs(
    title = "Monthly Income and Job Satisfaction",
    x = "Monthly Income",
    y = "Job Satisfaction"
  )
ggsave("figure4_income_job_satisfaction.png", p4, width = 6, height = 4)

# Save correlation plot separately
png("figure5_correlation_matrix.png", width = 700, height = 600)
ggpairs(
  hr_sel %>%
    select(Age, MonthlyIncome, YearsAtCompany, JobSatisfaction)
)
dev.off()
