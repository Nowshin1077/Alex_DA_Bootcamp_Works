-- Window Functions --
# These functions are really powerful and somewhat like a GROUP BY function, except they don't roll
# everything up into one row when grouping. Window functions allow us to look at partition or a group, 
# but they each keep their unique rows in the output.


# We are comparing gender with salary "GROUP BY"
SELECT gender, AVG(salary) AS avg_salary 
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
;


SELECT dem.first_name, dem.last_name, gender, AVG(salary) AS avg_salary 
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY dem.first_name, dem.last_name, gender
;

# We are comparing gender with salary "Window Function"
SELECT dem.first_name, dem.last_name, gender, 
AVG(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id) AS Rolling_Total
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;


SELECT dem.first_name, dem.last_name, gender, 
SUM(salary) OVER(PARTITION BY gender) AS Sum_Salary
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;


# Rolling Total will start at a specific value and add on values from subsequent rows based off 
# your partition.
# People in Finance do this a lot

SELECT dem.first_name, dem.last_name, gender, salary,
SUM(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id) AS Rolling_Total
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;

# ROW_NUMBER, RANK, DENSE_RANK - they are like aggregate function
SELECT dem.employee_id, dem.first_name, dem.last_name, gender, salary,
-- it will give unique number for each row. No duplicates.
# ROW_NUMBER() OVER() 
-- it will do the partition work based on gender. It will not have duplicate row number
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num,
-- It will have duplicate number. And the next number will not be the next number numerically
-- It will have next number positionally
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_num,
-- It will have duplicate number. And it will have next number numerically
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS dense_rank_num

FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;