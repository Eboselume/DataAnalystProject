-- World Life Expectancy Project (Data Cleaning)

SELECT * 
FROM world_life_expectancy;

-- Removing duplicates 
SELECT Country, Year, CONCAT(country, Year), COUNT(CONCAT(country, Year))
FROM world_life_expectancy
GROUP BY Country, Year, CONCAT(Country, Year)
HAVING COUNT(CONCAT(country, Year)) > 1
;

SELECT *
FROM (SELECT Row_ID,
CONCAT(country, Year),
ROW_NUMBER() OVER(PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) as Row_Num 
FROM world_life_expectancy
) AS Row_table 
WHERE Row_Num > 1
;

DELETE FROM world_life_expectancy
WHERE 
	Row_ID IN (
    SELECT Row_ID
FROM (SELECT Row_ID,
CONCAT(country, Year),
ROW_NUMBER() OVER(PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) as Row_Num 
FROM world_life_expectancy
) AS Row_table 
WHERE Row_Num > 1
)
;

-- Update/Fill up the blank spaces in Status Column 
SELECT *
FROM world_life_expectancy
WHERE Status = ''
;

SELECT DISTINCT(Status)
FROM world_life_expectancy
WHERE Status <> ''
;

SELECT DISTINCT(Country)
FROM world_life_expectancy
WHERE Status = 'Developing'
;

-- Update/Fill blank for developing countries(Status)
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developing'
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2.Status = 'Developing'
;

-- Another way of looking at the querying status 
/*
UPDATE world_life_expectancy 
SET Status = 'Developing'
WHERE Country IN(SELECT DISTINCT(country)
				FROM world_life_expectancy
				WHERE Status = 'Developing');
*/

-- Update/Fill blank for developed countries(Status)
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developed'
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2.Status = 'Developed'
;

-- Update/Fill blank spaces for Life expectancy columns 
SELECT *
FROM world_life_expectancy
WHERE `Life expectancy` = ''
;

-- updating based on the averages of the years (before and after)
SELECT t1.Country, t1.Year,t1.`Life expectancy`, 
t2.Country, t2.Year, t2.`Life expectancy`,
t3.Country, t3.Year, t3.`Life expectancy`,
ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country 
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country 
    AND t1.Year = t3.Year + 1
WHERE t1.`Life expectancy` = ''
;

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country 
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country 
    AND t1.Year = t3.Year + 1
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
WHERE t1.`Life expectancy` = ''
;


