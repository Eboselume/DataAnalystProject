# Wordl Life Expectancy Project (Exploratory Data Analysis)

SELECT *
FROM world_life_expectancy
;

-- Analysis Life expectancy for each Country comparing the maxium to minimum for each country 
SELECT Country, 
MIN(`Life expectancy`), 
MAX(`Life expectancy`),
ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`),1) AS Life_Increase_15_Years
FROM world_life_expectancy
GROUP BY Country
ORDER BY Life_Increase_15_Years ASC
;

-- Analysis of average Life expectancy for each year globally
SELECT Year, ROUND(AVG(`Life expectancy`),2)
FROM world_life_expectancy
WHERE `Life expectancy` <> 0
AND `Life expectancy` <> 0
GROUP BY Year 
ORDER BY Year 
;

-- Analysis of Life expecntancy vs GDP for each country 
SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp, ROUND(AVG(GDP),1) AS GDP
FROM world_life_expectancy
GROUP BY Country 
HAVING Life_Exp > 0
AND GDP > 0
ORDER BY GDP ASC 
;

-- Analysis for GDP vs Life expectancy globally 
SELECT 
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_Count,
AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END) High_GDP_Life_Expectancy,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) Low_GDP_Count,
AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy` ELSE NULL END) Low_GDP_Life_Expectancy
FROM world_life_expectancy
;

-- Analysis for Status vs Life expectancy
SELECT Status, ROUND(AVG(`Life expectancy`),1)
FROM world_life_expectancy
GROUP BY Status
;

-- Analysis for Status vs Life expectancy for each country (Based How many countries are developing and developed)
SELECT Status, COUNT(DISTINCT Country),ROUND(AVG(`Life expectancy`),1)
FROM world_life_expectancy
GROUP BY Status
;

-- Analysis for Life expectancy vs BMI for each country  
SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp, ROUND(AVG(BMI),1) AS BMI
FROM world_life_expectancy
GROUP BY Country 
HAVING Life_Exp > 0
AND BMI > 0
ORDER BY BMI ASC 
;

-- Analysis for Adult Mortality for each country or specific country  
-- checking how many people are dying each year comparing to their life expectancy 
SELECT Country, 
Year,
`Life expectancy`,
`AdultMortality`,
SUM(`AdultMortality`) OVER(PARTITION BY Country ORDER BY Year) AS Rolling_Total 
FROM world_life_expectancy
WHERE Country LIKE '%United%'
;
