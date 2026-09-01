-- Exploratory Data Analysis-EDA 
--  From the clean data we will find trends, patterns and run complex queries

SELECT *
FROM layoffs_staging2;


SELECT MAX(total_laid_off), MAX(percentage_laid_off) # Here 1 represents 100%
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC
;

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC # Here 2 is the column number
;


SELECT MIN(`date`) AS Start_Date, MAX(`date`) AS End_Date
FROM layoffs_staging2
;

SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC # Here 2 is the column number
;

SELECT *
FROM layoffs_staging2
;

SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC # Here 2 is the column number
;

SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 2 DESC 
;
 

SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC 
;

# Percentage refer to the percent of the company
# SELECT company, SUM(percentage_laid_off)
SELECT company, AVG(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC 
;


# Looking at the progression of lay_offs. It's called Rolling Sum.
# Start at the very earliest of layoffs and do a rolling sum untill the very 
# end of these layoffs.

# Rolling total layoffs based on the month for date column
# Rolling total = Month by month progression of layoffs all the way to the end 
# Rolling total is really great for visualization

SELECT SUBSTRING(`date`, 1,7) As `MONTH`, 
SUM(total_laid_off) AS Total_laid_off
FROM layoffs_staging2
WHERE SUBSTRING(`date`, 1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
;

WITH Rolling_Total AS
(
SELECT SUBSTRING(`date`, 1,7) As `MONTH`, 
SUM(total_laid_off) AS Total_off
FROM layoffs_staging2
WHERE SUBSTRING(`date`, 1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`, Total_off,
SUM(Total_off) OVER(ORDER BY `MONTH`) AS Rolling_Total
FROM Rolling_Total 
;

SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
# ORDER BY company ASC
ORDER BY 3 DESC
;

# Ranking based on the layoffs
# Partition by Years

# CTE
WITH Company_Year (company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
), Company_Year_Rank AS
(SELECT *,
DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE years IS NOT NULL
# ORDER BY Ranking ASC
)
SELECT *
FROM Company_Year_Rank
WHERE Ranking <=5
;

# We can change this to industry, month or anything else as per needed


 