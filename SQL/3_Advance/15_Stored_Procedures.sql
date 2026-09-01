-- Stored Procedures --
# It's a way to save our SQL code that we can reuse over and over again.
# After saving we call that stored procedure, and it will execute all the code 
# that we wrote within our stored procedure
# It's really helpful to store complex queries, simplifying repetitive code, and just enhancing performance overall.


SELECT *
FROM employee_salary
WHERE salary >= 50000
;



CREATE PROCEDURE large_salaries()
SELECT *
FROM employee_salary
WHERE salary >= 50000;
CALL large_salaries();


# DELIMITER - In SQL, a delimiter is a specific character or sequence of characters used to signal the end of a command to the SQL client interpreter
# By default, the standard statement delimiter across almost all SQL dialects is the semicolon (;).
# Problems arise when you need to write complex, multi-line blocks of code—such as stored procedures, functions, or database triggers. 
# To solve this, database clients allow you to change the delimiter to an alternate sequence (such as $$ or //) using the DELIMITER command.

DELIMITER $$ 
CREATE PROCEDURE large_salaries3()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 50000; 
	SELECT *
	FROM employee_salary
	WHERE salary >= 10000;
END $$
DELIMITER ;

CALL large_salaries3();


# Parameter - they are the variables that are passed as in input into a store procedure.
# And it allow the store procedure to accept an input value and place it into your code.
 
 
DELIMITER $$ 
CREATE PROCEDURE large_salaries4(par_employee_id INT)
BEGIN
	SELECT salary
	FROM employee_salary
    WHERE employee_id = par_employee_id
    ; 
END $$
DELIMITER ;

CALL large_salaries4(1)