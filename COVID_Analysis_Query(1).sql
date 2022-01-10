SELECT
	*
FROM 
	COVID_Historical_Changes_US_County
ORDER BY 
	Date DESC;

SELECT
	* 
FROM 
	US_County_Population

-- Goal: Match data in COVID_Historical_Changes_US_County with US_County_Population

-- First Step: determine if there is difference in # of counties in both tables

SELECT
	COUNT(*) AS Num_Counties
FROM
	COVID_historical_Changes_US_County
WHERE
	Date = '2022-01-04' -- 3222

SELECT
	COUNT(*) AS Num_Counties
FROM
	US_County_Population; -- 3193
	
-- Attempt 1: Match data based on state name and county names

SELECT 
	state_name,
	county_name,
	fips_code,
	date,
	cases_per_100k_7_day_count_change,
	percent_test_results_reported_positive_last_7_days,
	d2.stname,
	d2.ctyname,
	d2.popestimate072020
FROM
	COVID_Historical_Changes_US_County
	LEFT JOIN 
		(
			SELECT
				stname,
				ctyname,
				popestimate072020
			FROM 
				US_County_Population
		)
		d2
	ON
		state_name = d2.stname 
		AND
		county_name = d2.ctyname
WHERE
	date = '2020-12-31'
	AND state_name != 'Puerto Rico'
ORDER BY 
	state_name,
	county_name
-- Successful

-- Look at data where merge was not successful(ctyname or stname is null) and determine validity of those data
SELECT 
	state_name,
	county_name,
	fips_code,
	d2.stname,
	d2.ctyname
FROM
	COVID_Historical_changes_US_County
	LEFT JOIN
		(
			SELECT
				stname,
				ctyname
			FROM
				US_County_population
		)
		d2
	ON
		state_name = d2.stname
		AND
		county_name = d2.ctyname
WHERE
	date = '2020-12-31'
	AND 
	(stname IS NULL 
	OR
	ctyname IS NULL)
	AND
	state_name != 'Puerto Rico'
ORDER BY 
	state_name,
	county_name
	
-- In census county data, independent cities and counties/cities in Puerto Rico are not included.
-- We will exclude independent cities in data that use county population data, and include in all others.

SELECT * FROM COVID_Vaccination_Count_US_County;

SELECT 
	d1.recip_county, 
	d1.recip_state,
	d1.fips, 
	d2.state_name,
	d2.county_name
FROM
	COVID_Vaccination_Count_US_County d1
		LEFT JOIN
			(
				SELECT 
					state_name,
					county_name,
					fips_code
				FROM
					COVID_Historical_Changes_US_County
				WHERE
					date = '2021-12-01'
			)
			d2
		ON
			d1.fips = d2.fips_code -- Not work because FIPS is 'UNK' for some values. switch and do right join
WHERE
	d1.date = '2021-12-01';


