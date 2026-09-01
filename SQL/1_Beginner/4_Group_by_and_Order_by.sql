-- GROUP By
-- This is going to group together rows that have the same values in a specified column or columns 
-- that we are actually grouping. 
-- After grouping these rows together we can run AGGREGATE function on those rows.

SELECT *
FROM employee_demographics;

SELECT gender
FROM employee_demographics
GROUP BY gender
;

# SELECT firstname --> there is no aggregate function, select and group by statement has to match
SELECT gender
FROM employee_demographics
GROUP BY gender
;

# AVG is an aggregate function, this is not need to go group by 
SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender
;

SELECT occupation, salary
FROM employee_salary
GROUP BY occupation, salary
;

-- ORDER BY
SELECT *
FROM employee_demographics
# ORDER BY first_name 
ORDER BY first_name DESC
;

SELECT *
FROM employee_demographics
# ORDER BY age ASC
ORDER BY age DESC
;

SELECT *
FROM employee_demographics
ORDER BY gender, age
# ORDER BY 5, 4 -- but this is not recommended to use the position for querying. If a column get removed than the column position number will be changed.
# ORDER BY gender, age DESC
# ORDER BY age, gender # Here gender will not be used. But age will sort (unique value. thats why placing the order of the order by is pretty important.
;