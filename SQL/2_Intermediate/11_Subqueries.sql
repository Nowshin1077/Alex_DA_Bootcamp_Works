-- Subqueries --
# Query within another query

SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;


# Subquery in WHERE clause
# We want to select the employees who worked in the Parks and Rec Dept.
# Operator (IN) needs to contain 1 column 
SELECT *
FROM employee_demographics
WHERE employee_id IN  # Operator (IN) needs to contain 1 column. We cann't add more column here.  
				(SELECT employee_id
					FROM employee_salary
					WHERE dept_id = 1)
;

# Subquery in SELECT statement

SELECT first_name, salary, 
(SELECT AVG(salary)
FROM employee_salary) AS Average_Salary
FROM employee_salary
GROUP BY first_name, salary
;


# Subquery in  FROM statement

SELECT gender, AVG(age), MIN(age), MAX(age), COUNT(age)
FROM employee_demographics
GROUP BY gender
;

SELECT gender, AVG(`MAX(age)`)
FROM
(SELECT gender, AVG(age), MIN(age), MAX(age), COUNT(age)
FROM employee_demographics
GROUP BY gender) AS Agg_Table
GROUP BY gender;


SELECT AVG(max_age)
FROM
(SELECT gender, 
AVG(age) AS avg_age, 
MIN(age) AS min_age, 
MAX(age) AS max_age, 
COUNT(age) AS count_age
FROM employee_demographics
GROUP BY gender) AS Agg_Table
;
