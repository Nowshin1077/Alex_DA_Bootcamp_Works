-- Temporary Tables --
# These tables are only visible to the session that they're created in
# It use to store intermediate results for complex queries, somewhat like a CTE, 
# but also for using it to manipulate data before we insert it into a permanent table
# It lives on the memory and will go away after a while. But we can use this temp table over and over


# First way to create a TEMP Table

CREATE TEMPORARY TABLE temp_table
(first_name varchar(50),
last_name varchar(50),
favourite_movie varchar(100)
);

SELECT *
FROM temp_table;

INSERT INTO temp_table
VALUES('Alex', 'Freberg', 'Lord of the Rings: The Two Towers'),
('April', 'Onial', 'Sherlock Holmes');

SELECT *
FROM temp_table;


# Second way to create a TEMP Table. It' the most used way. Where wer take data from a existing table to 
# work with TEMP table

SELECT *
FROM employee_salary;
# We want to have a sunsection of this data where salary > 50000

CREATE TEMPORARY TABLE salary_over_50k  
# Make a table name that make sense, cause naming convention is pretty important as professionals work with 1000s or even more tables.
SELECT *
FROM employee_salary
WHERE salary >= 50000;

SELECT *
FROM salary_over_50k;

-- CTEs Vs TEMP TABLE
# TEMP TABLE: Temp tables use for more advanced things. Use these in store procedures when you need to manipulate data and you are 
# doing a lot more complex queries overall and often times you may need to use multiple temp tables and joining these tables
# together, when you do a lot of advance work. That's also lasts within the session.
# CTEs: With CTEs, it's typically more simple things because you can't make as advance CTEs or complex CTEs.
# Base CTE/base subquery/query the change it and do one level of advance thing on top of that query.
# CTE does not lasts.

