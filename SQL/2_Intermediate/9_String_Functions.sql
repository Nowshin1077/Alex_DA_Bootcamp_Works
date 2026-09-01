-- String Functions --
# these are builtin functions in MYSQL that will help us use strings and work 
# with strings differently.

SELECT LENGTH('skyfall');

SELECT first_name, LENGTH(first_name) AS first_name
FROM employee_demographics
ORDER BY 2
; 

# Standardization
SELECT UPPER('sky');
SELECT LOWER('SKY');

SELECT first_name, UPPER(first_name)
FROM employee_demographics;

# TRIM. It will get rid off white space.
SELECT ('            sky           ');
SELECT TRIM('            sky           ');
SELECT LTRIM('            sky           ');
SELECT RTRIM('            sky           ');

-- Substring --
# Chooing some char from string.
# SUBSTRING (column_name, position, character)

SELECT 
    birth_date, first_name,
    LEFT(first_name, 4),
    RIGHT(first_name, 4),
    SUBSTRING(first_name,3,2), # First value - position, Second value - character
    SUBSTRING(birth_date, 6,2)  AS birth_month 
FROM
    employee_demographics;

-- Replace --
# Replacing one character with another,
# Replace function - REPLACE(Column name, char want to rep, char to add)

SELECT first_name, REPLACE(first_name, 'a', 'z')
FROM employee_demographics;


-- Locate --
# Looking for something from a charcter from a word. 
# LOCATE(char, word)

SELECT LOCATE('x','Alexander');

SELECT first_name, LOCATE('An',first_name)
FROM employee_demographics;

-- Concatination --
# Combining two or more columns into one single column 
SELECT first_name, last_name,
CONCAT(first_name,'  ',last_name) AS full_name
FROM employee_demographics;
