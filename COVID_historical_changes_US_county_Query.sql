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


