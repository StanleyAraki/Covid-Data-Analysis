-- Look at data known to be null
SELECT * 
FROM 
    COVID_Death_Counts_US
WHERE 
    Deaths_involving_COVID_19 IS NULL;

-- See if there is a county with exactly 0 deaths
SELECT * 
FROM
	COVID_Death_Counts_US
WHERE
	Deaths_involving_COVID_19 = 0;

-- Look at number of data with NULL death count
SELECT 
    COUNT(*) 
FROM 
    COVID_Death_Counts_US deaths 
WHERE 
    Deaths_involving_COVID_19 IS NULL;

-- Alter data type of footnote in COVID_Death_Counts_US to varchar(100) from varcahr(50)
ALTER TABLE 
    COVID_Death_Counts_US 
ALTER COLUMN 
	Footnote TYPE varchar(100);

--Add more information to 'confidential' in Footnote Data
UPDATE
	COVID_Death_Counts_US
SET
	Footnote = 'Counts between 1-9 surpressed acc. NCHS confidentiality standarads'
WHERE
	DEaths_involving_COVID_19 IS NULL;

-- Set NULL data to 0 to make visualization easier later
UPDATE 
	COVID_Death_Counts_US
SET
	Deaths_involving_COVID_19 = 0
WHERE
	Deaths_involving_COVID_19 IS NULL;
	
-- See changes
SELECT *
FROM 
	COVID_Death_Counts_US;
	
-- Check if there is NULL data in deaths_from_all_causes column
SELECT 
	*
FROM 
	COVID_Death_Counts_US
WHERE
	Deaths_from_all_causes IS NULL;

-- Keya Paha county is only county with Null in Deaths_from_all_causes. 
-- Population of county is 760 in 2019. Records not obtained so put to 0
UPDATE 
	COVID_Death_Counts_US
SET
	Deaths_from_all_causes = 0
WHERE fips_county_code = 31103;

-- Create index
-- Column most often used is Deaths_involving_COVID_19
CREATE INDEX death_count ON COVID_Death_Counts_US(Deaths_involving_COVID_19);

-- See highest number of deaths(need to see max digit length)
SELECT
	*
FROM 
	COVID_Death_Counts_US
ORDER BY 
	Deaths_involving_COVID_19 DESC;

-- See highest number of deaths from all causes(need to see max digit length)
SELECT
	*
FROM 
	COVID_Death_Counts_US
ORDER BY Deaths_From_All_Causes DESC;

-- Get percentage of COVID deaths out of total deaths per county
SELECT 
    *,
    CAST(CAST(Deaths_involving_COVID_19 AS DECIMAL(7,2))/CAST(Deaths_from_All_Causes AS DECIMAL(8,2))*100.0 AS DECIMAL(5,2)) AS COVID_Death_Percentage
FROM
    COVID_Death_Counts_US;

-- County with the largest number of COVID deaths per state

SELECT 
    d1.State,
    d1.County_name,
    d1.Deaths_involving_COVID_19
FROM
    COVID_Death_Counts_US d1
    INNER JOIN 
    (
        SELECT 
            State, 
            MAX(Deaths_involving_COVID_19) AS Max_Deaths
        FROM   
            COVID_Death_Counts_US 
        GROUP BY 
            State
    ) d2
    ON d1.State = d2.State AND d1.Deaths_involving_COVID_19 = d2.Max_Deaths
ORDER BY 
    State;



