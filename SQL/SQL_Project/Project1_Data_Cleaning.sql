-- Project 1: SQL Data Cleaning Walkthrough --

# Data Cleaning - Making the data in a more usable format. Fixing a lot of issues
# in the raw data that when start creating visualization or start using it in your products
# that the data is actually useful and there aren't a lot of issues with it. So, that's
# really what data cleaning is.

-- 1. Remove Duplicates
-- 2. Standardized the Data
-- 3. Null Values or Blank Values
-- 4. Remove any columns or rows if necessary


SELECT *
FROM layoffs;

# We need to create another table to work on rather than the raw data. It's more professional
CREATE TABLE layoffs_staging
LIKE layoffs; 

SELECT *
FROM layoffs_staging;

# Inserting the data into the new table
INSERT layoffs_staging
SELECT *
FROM layoffs;


-- 1. Remove Duplicates

SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`) as row_num  # date is a keyword in MYSQL that's why we need to use backtick
FROM layoffs_staging;

# We are filtering here to see if there is any duplicates. If it's 2 or above that means there are duplicates. 
# CTE creation
WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, 
total_laid_off, percentage_laid_off, `date`, 
stage, country, funds_raised_millions) as row_num  # date is a keyword in MYSQL that's why we need to use backtick
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

SELECT *
FROM layoffs_staging
#WHERE company = 'Oda';
WHERE company = 'Casper';

###################
WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, 
total_laid_off, percentage_laid_off, `date`, 
stage, country, funds_raised_millions) as row_num  # date is a keyword in MYSQL that's why we need to use backtick
FROM layoffs_staging
)
DELETE  
FROM duplicate_cte
WHERE row_num > 1;

# In MySQL we cann't update a CTE cause here a DELETE statement is like an update statement. So, we can't do like this.
# To delete the duplicate columns we need to create another stagging database (stagging 2 database) 
# and then it will delete the columns.
# Creating another table that has just extra row and those row is equal to 2.

####################

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, 
total_laid_off, percentage_laid_off, `date`, 
stage, country, funds_raised_millions) as row_num  # date is a keyword in MYSQL that's why we need to use backtick
FROM layoffs_staging;

DELETE
FROM layoffs_staging2
WHERE row_num > 1;

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

SELECT *
FROM layoffs_staging2;


-- 2. Standardized the Data
# Finding issues in your data and then fixing it

SELECT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);
 
SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%'
;

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

# SELECT *
SELECT DISTINCT industry
FROM layoffs_staging2
;

# It's good to look at most of the column and fix the issues. There can be small tiny issues that you never saw.
# SELECT DISTINCT location

SELECT country
FROM layoffs_staging2
;

SELECT DISTINCT country
FROM layoffs_staging2
#ORDER BY 1
WHERE country LIKE 'United States%'
;

# Just doing the TRIM will not fix "United States." this kind of issue.
# We need to use TRAILING, it means coming at the end.
# This is a bit advanced.
SELECT DISTINCT country, TRIM(TRAILING '.' FROM country) AS trail_ing
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

# If we do time series exploratory data analysis, time series visualization
# then `date` data will need to be changed. Right now it's text.

# Formating date as well as as converting it to actual date column
SELECT `date`, 
# STR_TO_DATE(`date`, '%M/%d/%y')
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

SELECT `date`
FROM layoffs_staging2;

# Trying to convert it into a date column will give us an error. So, we need to change the
# format of the date column
# We should do ALTER on the staging table rather than on the raw table

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

SELECT *
FROM layoffs_staging2;


-- 3. Working with Nulls

 SELECT *
 FROM layoffs_staging2
 WHERE total_laid_off IS NULL  
 # WHERE total_laid_off = NULL # It will not give anyn results.
 AND percentage_laid_off IS NULL
 ;
 
SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = ''
;
 
# From the NULL values We need to see if any of these have one that's populate
# Then we need to populate the data that's possible to populate 
# Looking at Airbnb
 SELECT *
 FROM layoffs_staging2
 WHERE company = 'Airbnb';
 
 # We will do a join here to populate some data.
 # Doing Self-Join, we will update table values with non-blank repeated values
 SELECT t1.industry, t2.industry
 FROM layoffs_staging2 AS t1 
 JOIN layoffs_staging2  AS t2
	ON t1.company = t2.company
   # AND t1.location = t2.location
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

 UPDATE layoffs_staging2
 SET industry = NULL
 WHERE industry = '';
 
 
 UPDATE layoffs_staging2 t1
 JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
# WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

# Like other company with null and blank values this company data we don't have another populated 
# row which is not null to populate the null rows here. 
# That's why it did not changed
 SELECT *
 FROM layoffs_staging2 
 WHERE company LIKE 'Bally%'
 ;
 
 # Here, data from total_laid_off, percentage_laid_off, funds_raised_millions. We cann't populate them
 # If we had company_total_laid_off data before total_laid_off, percentage_laid_off then we might be able to populate
 # some of these data
 # For funds raised we might be able to scrape some data from the website and populate this. But that's different
 # not part of this project.
 
 
  -- 4. Removing Columns or Rows as Needed
 # Removing columns and rows that we need to
 # What we are trying to do with data in the near future is we're not just trying to 
 # identify a company or location that had layoffs or maybe we are.
 # We can get rid of these NULL values by deleting them.

 # To delete data we need to be confident about the data (should we use them later or not before deleting)
 
 SELECT *
 FROM layoffs_staging2
 WHERE total_laid_off IS NULL  
 AND percentage_laid_off IS NULL
 ;
 
 DELETE 
 FROM layoffs_staging2
 WHERE total_laid_off IS NULL  
 AND percentage_laid_off IS NULL
 ;
 
 
SELECT *
FROM layoffs_staging2;
 
# We are deleting the row_num column
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

 
 
 
 
 
 
 
 
 