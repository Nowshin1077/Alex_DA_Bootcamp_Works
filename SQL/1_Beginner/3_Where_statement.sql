-- WHERE Clause

SELECT *
FROM parks_and_recreation.employee_salary;

SELECT *
FROM employee_salary
WHERE first_name = 'April';

SELECT *
FROM employee_salary
WHERE first_name = 'Leslie'
;

SELECT *
FROM employee_salary
WHERE first_name = employee_salary;

# Operatopr in 'WHERE' clause
SELECT *
FROM employee_salary
WHERE salary > 50000
;

SELECT *
FROM employee_salary
WHERE salary < 50000
;

SELECT *
FROM employee_salary
WHERE salary >= 50000
;

SELECT *
FROM employee_salary
WHERE salary <= 50000
;

SELECT *
FROM employee_demographics
WHERE gender != 'Female'
;

SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
;

# Logical operatopr in WHERE clause
-- 'AND, OR, NOT' -- this adds additional conditional statement
-- It will also follow PEDMAS

SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
AND gender = 'male'
;


SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
OR gender = 'male'
;

SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
OR NOT gender = 'male'
;

SELECT *
FROM employee_demographics
WHERE (first_name = 'Leslie' AND age = '44') OR age > 55
;


-- 'LIKE' statements. It's super unique. We can look for specific patterns/sequence in a column that we search for. 
-- We will not necessarily look for exact match.
-- Special characters: % (character in first,last) and _ (character count)

SELECT *
FROM employee_demographics
# WHERE first_name = 'Jer'
# WHERE first_name LIKE 'Jer%'
# WHERE first_name LIKE 'er%'
# WHERE first_name LIKE '%er%'
# WHERE first_name LIKE 'a%'
# WHERE first_name LIKE 'a___%'
WHERE birth_date LIKE '1989%'
;
