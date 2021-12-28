-- Look at data known to be NULL 
SELECT * 
FROM 
    COVID_Death_Counts_US deaths 
WHERE 
    Deaths_involving_COVID_19 IS NULL;

-- See if there is a county with exactly 0 deaths
SELECT * 
FROM 
    Covid_Death_Counts_US 
WHERE 
    Deaths_involving_COVID_19 = 0;  -- result: None

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
ALTER 
    COLUMN Footnote varchar(100);

-- Add more information to 'confidential' in Footnote Data
UPDATE 
    COVID_Death_Counts_US 
SET 
    Footnote = 'Counts between 1-9 surpressed acc. NCHS confidentiality standards' 
WHERE 
    Deaths_involving_COVID_19 IS NULL;

-- Set NULL data to 0 to make visualization easier later
UPDATE 
    COVID_Death_Counts_US 
SET 
    Deaths_involving_COVID_19 = 0 
WHERE 
    Deaths_involving_COVID_19 IS NULL; -- Will have to explain in visual later that 0 indicates confidential records

-- See changes
SELECT * 
FROM 
    Covid_Death_Counts_US;

-- See highest number of deaths
SELECT 
    * 
FROM 
    COVID_Death_Counts_US
ORDER BY 
    Deaths_involving_COVID_19 DESC;

-- See highest number of deaths from all causes
SELECT
    *
FROM 
    COVID_Death_Counts_US
ORDER BY 
    Deaths_from_All_Causes DESC;


-- Get percentage of COVID Deaths out of total deaths per county
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

SELECT DISTINCT(State) FROM COVID_Death_Counts_US GROUP BY State ORDER BY State;