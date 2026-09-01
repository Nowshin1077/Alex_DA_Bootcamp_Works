-- Joins - inner, outer, self  --
# Joins allow us to combine two tables or more together if they have a common column.
# Not necessarily column name has to be same. But data in that column should be same so that we can use.

SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;


-- Inner Joins --
# Return rows that are the same in the both columns from both tables.
# By default join represents inner join.
## Usecase: when you need to select data from multiple tables where there is a match in the specified columns

# SELECT *
# Selecting the necessary columns without having all the informations from both tables.
# And if there are columns that are similar in both tables, we have to denote that.
SELECT dem.employee_id, age, occupation
FROM employee_demographics AS dem     # alias
INNER JOIN employee_salary AS sal     # alias
	ON dem.employee_id = sal.employee_id
;


-- Outer Joins --
# Left outer join  - returns all rows from the left table. And matching rows from right table.
# Right outer join - returns all rows from the right table. And matching rows from left table.

## Usecase:  Merging data: When you need to combine data from two tables into a single result set while preserving all records.
## Handling missing data: In scenarios where data might be missing or incomplete in one or both tables

SELECT *
FROM employee_demographics AS dem
LEFT OUTER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id;


SELECT *
FROM employee_demographics AS dem    
RIGHT JOIN employee_salary AS sal     # it still populated the null row as it will return everything.
	ON dem.employee_id = sal.employee_id
;


-- Self Joins --
# A type of join operation where a table is joined with itself
# Usecase: It's useful for working with hierarchical data

# In a office before Chrismas day they decided to make employees their sceret Shanta. For this they decided that employee ID 1 will be ID 2's Secret Shanta, 
# ID 2 will be ID 3's secret shanta and so on. 


# SELECT *
SELECT emp1.employee_id As emp_santa,
emp1.first_name AS first_name_santa,
emp1.last_name As last_name_santa,
emp2.employee_id As emp_name,
emp2.first_name AS first_name_emp,
emp2.last_name As last_name_emp
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id + 1= emp2.employee_id
;


-- Joining multiple tables together -- 
# Joning more than two tables together

SELECT *
FROM employee_demographics AS dem     # alias
INNER JOIN employee_salary AS sal     # alias
	ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments pd
	ON sal.dept_id = pd.department_id
;

# Reference table (parks_departments) - cause from that table data might not change frequently or no change at all. Also there is no repeating.
# Table like employee_demographics, employee_id - data will change frequently here

SELECT *
FROM parks_departments;