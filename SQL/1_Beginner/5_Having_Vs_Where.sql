-- Having vs Where
-- Having is only gonna work for aggregated functions after the group by actually runs. 
-- 'Having' can not run without GROUP BY execution. So, it will come later after GROUP BY is done.
-- 'Where' can run without GROUP BY execution. Whrere is likely to  use a lot more.
-- But to perform flter on those aggregated function columns, you have to use HAVING


SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40
;

SELECT occupation, AVG(salary)
FROM employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY occupation
HAVING AVG(salary) > 75000
;

SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40;
