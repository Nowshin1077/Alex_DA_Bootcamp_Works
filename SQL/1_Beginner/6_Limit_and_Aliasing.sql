-- Limit & Aliasing 
-- Only using LIMIT is pretty straightforward. But using it with ORDER BY can make it powerful.

SELECT *
FROM employee_demographics
LIMIT 3
;


SELECT *
FROM employee_demographics
ORDER BY age DESC
# LIMIT 3
LIMIT 2, 1
;

-- Alaising
-- It's just a way to change the name of the column for the most part.
-- It can also work with joins.

# SELECT gender, AVG(age) As avg_age
SELECT gender, AVG(age) avg_age  # query can execute without writing 'AS'
FROM employee_demographics
GROUP BY gender
HAVING avg_age > 35
;

