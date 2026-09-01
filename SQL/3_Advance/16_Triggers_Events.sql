-- Triggers and Events
# Triggers - a block of code that execute automatically when an event takes place on a specific table
# For example, we want to add new employee in employee_salary table and this data should also add into employee_demographics

SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;

# Triggers going to get activated for each row that is inserted. So, if we had an insert statement that inserted 4 different people that we just hired, that means this trigger is going to get activated 4 times.
# Microsoft SQL Server have things like batch triggers or table level triggers that'll only once for all four of them.
DELIMITER $$
CREATE TRIGGER employee_insert
	AFTER INSERT ON employee_salary # BEFORE INSERT ON employee_salary (for update or delete)
	FOR EACH ROW 
BEGIN
	INSERT INTO employee_demographics (employee_id, first_name, last_name)
    VALUES (NEW.employee_id,NEW.first_name, NEW.last_name); # VALUES (OLD.employee_id...  # values that we deleted or updated
END $$
DELIMITER ;

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES(13, 'Jean-Ralphio', 'Saperstein', 'Exntertainment 720 CEO', 100000, NULL);


-- Events --
# This is kind of similar to a trigger. A trigger happens when an event takes place. Whereas an event takes place when it's scheduled. So, this is more of a schedule autmator rather than a trigger that happens when an event takes place.
# These can be fantastic for a lot of things like when you're importing data. You can pull data from a specific path on a schedule. You can build reports that are exported to a file on a schedule.
# You can do it daily, weekly, monthly and yearly. It's super helpful for automation in general.

## Pawne Council comes up with some new legislation. They needs to save some mmoney, 
# especially in the parks and reck department. Now, they want to retire people who are over the age of 60 immediately
# and give them liftime pay.
## So, we want to create an event that checks it, every month or every day. And then if they're over a specific age, we are
# then going to delete them from the table and they will be retired. 

SELECT *
FROM employee_demographics;

DELIMITER $$
CREATE EVENT delete_retirees_row
ON SCHEDULE EVERY 30 SECOND   # ON SCHEDULE EVERY 1 MONTH 
DO
BEGIN
	DELETE
	FROM employee_demographics
    WHERE age >= 60;
END $$
DELIMITER ;


# If it did not work, you couldn't create an event at all. 
SHOW VARIABLES;
SHOW VARIABLES LIKE 'event%';


