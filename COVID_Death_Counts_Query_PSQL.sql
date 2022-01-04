SELECT * 
FROM 
    COVID_Death_Counts_US
WHERE 
    Deaths_involving_COVID_19 IS NULL;
	
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