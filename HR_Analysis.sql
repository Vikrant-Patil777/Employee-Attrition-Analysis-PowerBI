create database hr_analytics;
use hr_analytics;
select database();

CREATE TABLE employees (
    Age INT,
    Attrition VARCHAR(10),
    BusinessTravel VARCHAR(30),
    DailyRate INT,
    Department VARCHAR(50),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(50),
    EmployeeNumber INT PRIMARY KEY,
    EnvironmentSatisfaction INT,
    Gender VARCHAR(20),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(50),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(20),
    MonthlyIncome INT,
    MonthlyRate INT,
    NumCompaniesWorked INT,
    OverTime VARCHAR(10),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
);

describe employees;
#Basic HR Analysis 
select count(*) as total_emp from employees;
select Department, count(*) as Emp_count from employees group by Department order by Emp_count desc;
select Gender, count(*) as Emp_count from  employees group by Gender order by Emp_count desc;
select Attrition, count(*) as Emp_count from employees group by Attrition;


#Total Attrition Rate
SELECT
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS attrition_rate
FROM employees;


#Total Left Employee
select Department, count(*) as Emp_count,
sum(case when Attrition="Yes" then 1 else 0 end) as employee_left
from employees
group by Department;


#Total Left Employee Rate
select Department, count(*) as Emp_count,
sum(case when Attrition="Yes" then 1 else 0 end) as employee_left,
round(
sum(case when Attrition="Yes" then 1 else 0 end)* 100/ count(*),2
)as attrition_rate
from employees
group by Department
order by attrition_rate;


#Total JobRole Attrition
select JobRole, count(*)as emp_count,
sum(case when Attrition="Yes" then 1 else 0 end)as emp_left,
round(
sum(case when Attrition="Yes" then 1 else 0 end)* 100/ count(*),2
)as attrition_rate
from employees
group by JobRole
order by attrition_rate desc;


#Total Age_Group Attrition
select 
	case 
		when age <25 then 'Under 25'
		when age between 25 and 35 then '25-35'
		when age between 35 and 45 then '35-45'
		when age between 45 and 55 then '45-55'
    else '55+'
    end as age_group,
    count(*) as total_employees,
    sum(case when Attrition="Yes" then 1 else 0 end)as emp_left,
    round(
		sum(case when Attrition="Yes" then 1 else 0 end)*100 / count(*),
        2
    )as attrition_rate
from employees
group by age_group
order by attrition_rate;


#Total Gender Attrition    
select Gender, count(*) as emp_count,
sum(case when Attrition="Yes" then 1 else 0 end)as emp_left,
round(
sum(case when Attrition="Yes" then 1 else 0 end)* 100/ count(*),
2
)as Attrition_rate
from employees
group by Gender
order by Attrition_rate desc;


#Total JobSatisfaction Attrition
select
    JobSatisfaction,
    count(*) AS total_employees,
    sum(case when Attrition = 'Yes' then 1 else 0 end) as employees_left,
    round(
        sum(case when Attrition = 'Yes' then 1 else 0 end) * 100.0
        / count(*),
        2
    ) as attrition_rate
from employees
group by JobSatisfaction
order by JobSatisfaction;


#Total MonthlyIncome Attrition 
select
    case
        when MonthlyIncome < 3000 then 'Low Income'
        when MonthlyIncome between 3000 and 6000 then 'Medium Income'
        when MonthlyIncome between 6001 and 10000 then 'High Income'
        else 'Very High Income'
    end as income_group,
    count(*) as total_employees,
    sum(case when Attrition = 'Yes' then 1 else 0 end) as employees_left,
    round(
        sum(case when Attrition = 'Yes' then 1 else 0 end) * 100.0
        / count(*),
        2
    ) as attrition_rate
from employees
group by income_group
order by attrition_rate desc;


#Total OverTime Attrition
select
    OverTime,
    count(*) as total_employees,
    sum(case when Attrition = 'Yes' then 1 else 0 end) as employees_left,
    round(
        sum(case when Attrition = 'Yes' then 1 else 0 end) * 100.0
        / count(*),
        2
    ) as attrition_rate
from employees
group by OverTime
order by attrition_rate desc;


#Total YearsAtCompany Attrition
select
    case
        when YearsAtCompany < 2 then 'Less than 2 Years'
        when YearsAtCompany between 2 and 5 then '2-5 Years'
        when YearsAtCompany between 6 and 10 then '6-10 Years'
        else 'More than 10 Years'
    end as experience_group,
    count(*) as total_employees,
    sum(case when Attrition = 'Yes' then 1 else 0 end) as employees_left,
    round(
        sum(case when Attrition = 'Yes' then 1 else 0 end) * 100.0
        / count(*),
        2
    ) as attrition_rate
from employees
group by experience_group
order by attrition_rate desc;


#Total BusinessTravel Attrition
select
    BusinessTravel,
    count(*) as total_employees,
    sum(case when Attrition = 'Yes' then 1 else 0 end) as employees_left,
    round(
        sum(case when Attrition = 'Yes' then 1 else 0 end) * 100.0
        / count(*),
        2
    ) as attrition_rate
from employees
group by BusinessTravel
order by attrition_rate desc;


#Total DistanceFromHome Attrition
select
    case
        when DistanceFromHome <= 5 then 'Near'
        when DistanceFromHome between 6 and 15 then 'Medium'
        else 'Far'
    end as distance_group,
    count(*) as total_employees,
    sum(case when Attrition = 'Yes' then 1 else 0 end) as employees_left,
    round(
        sum(case when Attrition = 'Yes' then 1 else 0 end) * 100.0
        / count(*),
        2
    ) as attrition_rate
from employees
group by distance_group
order by attrition_rate desc;


#Total WorkLifeBalance Attrition
select
    WorkLifeBalance,
    count(*) as total_employees,
    sum(case when Attrition = 'Yes' then 1 else 0 end) as employees_left,
    round(
        sum(case when Attrition = 'Yes' then 1 else 0 end) * 100.0
        / count(*),
        2
    ) as attrition_rate
from employees
group by WorkLifeBalance
order by WorkLifeBalance;


#Total EnvironmentSatisfaction Attrition
select
    EnvironmentSatisfaction,
    count(*) AS total_employees,
    sum(case when Attrition = 'Yes' then 1 else 0 end) as employees_left,
    round(
        sum(case when Attrition = 'Yes' then 1 else 0 end) * 100.0
        / count(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY EnvironmentSatisfaction
ORDER BY EnvironmentSatisfaction;

#Total JobLevel Attrition
select
    JobLevel,
    count(*) as total_employees,
    SUM(case when Attrition = 'Yes' then 1 else 0 end) as employees_left,
    ROUND(
        SUM(case Attrition = 'Yes' then 1 else 0 end) * 100.0
        / count(*),
        2
    ) as attrition_ratefro
from employees
group by JobLevel
order by JobLevel;


#Total JobInvolvement Attrition
select
    JobInvolvement,
    count(*) as total_employees,
    sum(case when Attrition = 'Yes' then 1 else 0 end) as employees_left,
    round(
        sum(case when Attrition = 'Yes' then 1 else 0 end) * 100.0
        / count(*),
        2
    ) as attrition_rate
from employees
group by JobInvolvement
order by JobInvolvement;


#Total RelationshipSatisfaction Attrition
select
    RelationshipSatisfaction,
    count(*) as total_employees,
    sum(case when Attrition = 'Yes' then 1 else 0 end) as employees_left,
    round(
        sum(case when Attrition = 'Yes' then 1 else 0 end) * 100.0
        / count(*),
        2
    ) as attrition_rate
from employees
group by RelationshipSatisfaction
order by RelationshipSatisfaction;

#Total YearsSinceLastPromotion Attrition
select
    case
        when YearsSinceLastPromotion = 0 then '0 Years'
        when YearsSinceLastPromotion between 1 and 2 then '1-2 Years'
        when YearsSinceLastPromotion between 3 AND 5 then '3-5 Years'
        else 'More than 5 Years'
    end as promotion_group,
    count(*) as total_employees,
    sum(case when Attrition = 'Yes' then 1 else 0 end) as employees_left,
    round(
        sum(case when Attrition = 'Yes' then 1 else 0 end) * 100.0
        / count(*),
        2
    ) as attrition_rate
from employees
group by promotion_group
order by attrition_rate desc;
