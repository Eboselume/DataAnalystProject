# US Household Income Data Cleaning 

SELECT * 
FROM US_Project.USHouseholdIncome;

SELECT * 
FROM US_Project.ushouseholdincome_statistics;

SELECT COUNT(id) 
FROM US_Project.USHouseholdIncome;

SELECT COUNT(id)  
FROM US_Project.ushouseholdincome_statistics;

-- Checking duplicates from id column from USHouseholdIncome table 
SELECT id, COUNT(id) 
FROM US_Project.USHouseholdIncome
GROUP BY id
HAVING COUNT(id) > 1
;

-- Removing duplicates from id column from USHouseholdIncome table 

DELETE FROM US_Project.USHouseholdIncome
WHERE row_id IN (
	SELECT row_id 
	FROM (
		SELECT row_id, 
		id,
		ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num 
		FROM US_Project.USHouseholdIncome
		) duplicates 
	WHERE row_num > 1)
;

-- Checking for duplicates in ushouseholdincome_statistics tables 
SELECT id, COUNT(id) 
FROM US_Project.ushouseholdincome_statistics
GROUP BY id
HAVING COUNT(id) > 1
;

-- Update the values in State_Name column (SpellCheck) in US_Project.USHouseholdIncome table 
SELECT DISTINCT State_Name
FROM US_Project.USHouseholdIncome
ORDER BY 1
;

UPDATE US_Project.USHouseholdIncome
SET State_Name = 'Georgia'
WHERE State_Name = 'georgia';

UPDATE US_Project.USHouseholdIncome
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama';

-- Filling blank spaces in Place column in US_Project.USHouseholdIncome table 
SELECT *
FROM US_Project.USHouseholdIncome
WHERE Place = ''
ORDER BY 1
;

SELECT *
FROM US_Project.USHouseholdIncome
WHERE County = 'Autauga County'
ORDER BY 1
;

UPDATE US_Project.USHouseholdIncome
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont'
;

-- Update the values in Type column (SpellCheck) in US_Project.USHouseholdIncome table 
SELECT Type, COUNT(Type)
FROM US_Project.USHouseholdIncome
GROUP BY Type
;

UPDATE US_Project.USHouseholdIncome
SET Type = 'Borough'
WHERE Type = 'Boroughs'
;

-- Checking to see where there are 0,blank or null values in ALand and AWater columns 
SELECT ALand, AWater
FROM US_Project.USHouseholdIncome
WHERE (ALand = 0 OR ALand = '' OR ALand IS NULL)
-- WHERE (AWater = 0 OR AWater = '' OR AWater IS NULL
;