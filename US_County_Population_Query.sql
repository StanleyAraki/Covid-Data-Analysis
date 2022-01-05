-- Check to see if columns of interest(POPESTIMATE042020 and POPESTIMATE072020) contains NULL
SELECT
    *
FROM 
    US_County_Population
WHERE 
    POPESTIMATE042020 IS NULL
    OR
    POPESTIMATE072020 IS NULL; -- None of it is NULL

-- See number of counties per State
SELECT 
    STName, 
    COUNT(County) AS County_Count
FROM 
    US_County_Population
GROUP BY 
    STName 
ORDER BY STName;

-- District of Columbia shows up in the list of States. We will keep that for now since it is a valid location with residents in the US

-- See population per state based off of county population numbers in 07/2020
SELECT 
    STName,
    SUM(POPESTIMATE072020) as Population_Count
FROM 
    US_County_Population
GROUP BY 
    STName 
ORDER BY STName; -- Will match this data with separate census data later

SELECT * FROM US_County_population;