-- CTEs - Common Table Expression
# It allow us to define a subquery block that you can then reference within the main query.
# The purpose of CTE is to be able to perform more advance calculations. Something you can't easily do
# or can't do at all within just one query. 
# Another reason to use CTE is readability. Experienced professionals prefer CTEs over Subqueries
# WHITH - keyword to define CTE

-- CTEs Vs Temp Table --
# This is basically like a temporary table almost, but then you're just using it to query off of it.
# You are not saving it. You are not storing it on memory. It's just like writing a regular query.
# We can only write it immediately after creating the CTE. We can't write it down below and reuse it.


WITH CTE_Example AS
# IF we write query like this then this will be the default. This will overwrite the column 
# names that you have in your actual CTE expression or the query that you have within your CTE.
# WITH CTE_Example (Gender, AVG_Sal, MAX_Sal, MIN_Sal, COUNT_Sal) AS 
(
SELECT gender, AVG(salary) avg_sal, MAX(salary) max_sal, MIN(salary) min_sal, COUNT(salary) count_sal
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
SELECT AVG(avg_sal)
# SELECT *
FROM CTE_Example
;


SELECT AVG(avg_sal)
FROM (SELECT gender, AVG(salary) avg_sal, MAX(salary) max_sal, MIN(salary) min_sal, COUNT(salary) count_sal
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
example_subquery
;

# We can only write it immediately after creating the CTE. We can't write it down below and reuse it.
SELECT AVG(avg_sal)
FROM CTE_Example
;


# Creating multiple CTEs within just one. For doing more complex query and joining complex query together
WITH CTE_Example AS
(
SELECT employee_id, gender, birth_date
FROM employee_demographics 
WHERE birth_date > '1985-01-01'
),
CTE_Example2 AS
(
SELECT employee_id, salary
FROM employee_salary
WHERE salary > 50000
)
SELECT *
FROM CTE_Example
JOIN CTE_Example2
	ON CTE_Example.employee_id = CTE_Example2.employee_id
;