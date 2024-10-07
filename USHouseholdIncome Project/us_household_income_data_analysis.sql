# US Household Income Exploratory Data Analysis 

SELECT *
FROM US_Project.USHouseholdIncome
;

SELECT *
FROM US_Project.ushouseholdincome_statistics
;

-- Analysis of the Area of the Land and Water of States 
SELECT State_Name, SUM(ALand), SUM(AWater) 
FROM US_Project.USHouseholdIncome
GROUP BY State_Name
ORDER BY 2 DESC
LIMIT 10
;

SELECT State_Name, SUM(ALand), SUM(AWater) 
FROM US_Project.USHouseholdIncome
GROUP BY State_Name
ORDER BY 3 DESC
LIMIT 10
;

-- Found some missing data/ unreported data in the Mean column 
SELECT *
FROM US_Project.USHouseholdIncome u
JOIN US_Project.ushouseholdincome_statistics us
	ON u.id = us.id
WHERE Mean <> 0
;

SELECT u.State_Name, County, Type, `Primary`, Mean, Median 
FROM US_Project.USHouseholdIncome u
JOIN US_Project.ushouseholdincome_statistics us
	ON u.id = us.id
WHERE Mean <> 0;

-- Analysis of states that have the highest income 
SELECT u.State_Name, ROUND(AVG(Mean),1),ROUND(AVG(Median),1)
FROM US_Project.USHouseholdIncome u
INNER JOIN US_Project.ushouseholdincome_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 2 DESC
LIMIT 10
;

-- Analysis of states that have the lowest income 
SELECT u.State_Name, ROUND(AVG(Mean),1),ROUND(AVG(Median),1)
FROM US_Project.USHouseholdIncome u
INNER JOIN US_Project.ushouseholdincome_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 3 ASC
LIMIT 10
;

SELECT Type, COUNT(TYPE), ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM US_Project.USHouseholdIncome u
INNER JOIN US_Project.ushouseholdincome_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY Type
ORDER BY 2 DESC
LIMIT 20
;

SELECT Type, COUNT(Type), ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM US_Project.USHouseholdIncome u
INNER JOIN US_Project.ushouseholdincome_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY 1
HAVING COUNT(Type) > 100
ORDER BY 3 DESC
LIMIT 20
;

SElECT *
FROM USHouseholdIncome
WHERE Type = 'Community';

SELECT u.State_Name, City, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM US_Project.USHouseholdIncome u
INNER JOIN US_Project.ushouseholdincome_statistics us
	ON u.id = us.id
GROUP BY u.State_Name, City
ORDER BY ROUND(AVG(Mean),1) DESC
;