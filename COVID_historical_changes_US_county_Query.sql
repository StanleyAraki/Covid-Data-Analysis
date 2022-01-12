CREATE TABLE COVID_Historical_Changes_US_County
	(
		state_name varchar(50),
		county_name varchar(50),
		fips_code int,
		date date,
		cases_per_100k_7_day_count_change varchar(50), -- some data is 'suppressed'
		percent_test_results_reported_positive_last_7_days varchar(50),
		community_transmission_level varchar(50)
	);
	
SELECT 
	* 
FROM 
	COVID_Historical_Changes_US_County
ORDER BY 
	date;

-- Add primary key to table
ALTER TABLE COVID_Historical_changes_US_County ADD PRIMARY KEY (date, fips_code);

-- According to CDC, suppressed indicates cells with frequency low enough to identify people(0 < case count < 10)
-- An entry with 0 or "NULL" indicate different things, so we will keep the 'suppressed' data

-- Get better understanding of percent_test_results_reported_positive_last_7_days

SELECT 
	* 
FROM 
	COVID_Historical_Changes_US_County
WHERE 
	percent_test_results_reported_positive_last_7_days IS NOT NULL
	AND 
	date > '2021-01-01' -- When it was at its worst
ORDER BY 
	date;
	
SELECT 
	*
FROM 
	COVID_Historical_changes_US_County
WHERE 
	percent_test_results_reported_positive_last_7_days IS NOT NULL
	AND
	date > '2021-01-01'
	AND
	fips_code = '09001'
ORDER BY date;

-- According to data, cases_per_100k_7_day_count_change updates every day with 7-day calculations starting at that day.

-- UPDATE: Having cases_per_100k_7_day_count_change and percent_test_results_reported_positive_last_7_days as varchar(50) makes querying
-- unnecessarily difficult. Thus, we will choose to represent suppressed data as '-1', and convert the columns to be in format decimal(8,3). 
-- Max data is decimal(7,3) but in the future it could increase and go to decimal(8,3).

SELECT
	* 
FROM 
	COVID_Historical_changes_US_County 
WHERE 
	cases_per_100k_7_day_count_change = 'suppressed'
ORDER BY
	date DESC;

-- Set suppressed cases in cases_per_100k_7_day_count_change to '-1' to indicate suppressed and allow data type conversion

UPDATE 
	COVID_Historical_changes_US_County
SET
	cases_per_100k_7_day_count_change = -1
WHERE
	cases_per_100k_7_day_count_change = 'suppressed';

-- Before we can do a conversion, we have to remove the ',' in characters

UPDATE
	COVID_Historical_changes_US_County
SET
	cases_per_100k_7_day_count_change = replace(cases_per_100k_7_day_count_change, ',', '');

-- Check data
SELECT * FROM COVID_Historical_Changes_US_County ORDER BY date DESC;

-- Convert column 'cases_per_100k_7_day_count_change' from varchar(50) to deicmal(8, 3) 
ALTER TABLE 
	COVID_Historical_Changes_US_County
ALTER COLUMN
	cases_per_100k_7_day_count_change 
TYPE 
	DECIMAL(8, 3)
USING 
	(cases_per_100k_7_day_count_change::decimal(8,3));


