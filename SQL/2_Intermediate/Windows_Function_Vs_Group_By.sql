CREATE TABLE baby_names(
Gender VARCHAR(10),
Name VARCHAR(20),
Total INT
);

INSERT INTO baby_names(Gender, Name, Total) VALUES
('Girl','Ava',95),
('Girl','Emma', 106),
('Boy', 'Ethan',115),
('Girl', 'Isabella', 100),
('Boy', 'Jacob', 101),
('Boy', 'Liam', 84),
('Boy', 'Logan', 73),
('Boy', 'Noah', 120),
('Girl', 'Olivia', 100),
('Girl', 'Sophia', 88);

-- 1. view the table
SELECT *
FROM baby_names;

-- 2. order by popularity
SELECT *
FROM baby_names
ORDER BY Total DESC;  

-- 3. add a popularity column
SELECT Gender, Name, Total,
	ROW_NUMBER() OVER(ORDER BY Total DESC) AS Popularity  
FROM baby_names;

-- 4. try different functions
SELECT Gender, Name, Total,
	ROW_NUMBER() OVER(ORDER BY Total DESC) AS Popularity,
	RANK() OVER(ORDER BY Total DESC) AS Populrity_R,  
	DENSE_RANK() OVER(ORDER BY Total DESC) AS Popularity_DR 
FROM baby_names;

-- 5. try different windows
SELECT Gender, Name, Total,
	ROW_NUMBER() OVER(PARTITION BY Gender ORDER BY Total DESC) AS Popularity  
FROM baby_names;

-- 6. what are the top 3 most popular neames for each gender?
SELECT * FROM 
(SELECT Gender, Name, Total,
	ROW_NUMBER() OVER(PARTITION BY Gender ORDER BY Total DESC) AS Popularity  
FROM baby_names) AS Popularity

WHERE Popularity <= 3;

