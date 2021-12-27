-- Look at data known to be NULL 
SELECT * FROM COVID_Death_Counts_US deaths WHERE 
Deaths_involving_COVID_19 IS NULL;

-- See if there is a county with exactly 0 deaths
SELECT * FROM Covid_Death_Counts_US WHERE 
Deaths_involving_COVID_19 = 0;  -- result: None

-- Look at number of data with NULL death count
SELECT COUNT(*) FROM COVID_Death_Counts_US deaths WHERE 
Deaths_involving_COVID_19 IS NULL;

-- Alter data type of footnote in COVID_Death_Counts_US to varchar(100) from varcahr(50)
ALTER TABLE COVID_Death_Counts_US  ALTER COLUMN Footnote varchar(100);

-- Add more information to 'confidential' in Footnote Data
UPDATE COVID_Death_Counts_US SET Footnote = 'Counts between 1-9 surpressed acc. NCHS confidentiality standards';

-- Set NULL data to 0 to make visualization easier later
UPDATE COVID_Death_Counts_US SET Deaths_involving_COVID_19 = 0 WHERE Deaths_involving_COVID_19 IS NULL; -- Will have to explain in visual later that 0 indicates confidential records

-- See changes
SELECT * FROM Covid_Death_Counts_US;

