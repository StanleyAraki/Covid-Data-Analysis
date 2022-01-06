CREATE TABLE COVID_Vaccination_Count_US_County
	(
		Date Date, -- A
		FIPS varchar(50), -- B
		Recip_County varchar(50), -- C
		Recip_State varchar(4), -- D
		Series_Complete_Pop_Pct decimal(5,2), -- E
		Series_Complete_Yes int, -- F
		Series_Complete_12Plus int, -- G
		Series_Complete_12PlusPop_Pct decimal(5,2), -- H
		Series_Complete_18Plus int, -- I
		Series_Complete_18PlusPop_Pct decimal(5,2), -- J
		Series_Complete_65Plus int, -- K
		Series_Complete_65PlusPop_Pct decimal(5,2), -- L
		Completeness_pct decimal(5,2), -- M
		Administered_Dose1_Recip int, -- N
		Administered_Dose1_Pop_Pct decimal(5,2), -- O
		Administered_Dose1_Recip_12Plus int, -- P
		Administered_Dose1_Recip_12PlusPop_Pct decimal(5,2), -- Q
		Administered_Dose1_Recip_18Plus int, -- R
		Administered_Dose1_Recip_18PlusPop_Pct decimal(5,2), -- S
		Administered_Dose1_Recip_65Plus int, -- T
		Administered_Dose1_Recip_65PlusPop_Pct decimal(5,2), -- U
		SVI_CTGY varchar(3), -- V
		Series_Complete_Pop_Pct_SVI smallint, -- W
		Series_Complete_12PlusPop_Pct_SVI smallint, -- X
		Series_Complete_18PlusPop_Pct_SVI smallint, -- Y
		Series_Complete_65PlusPop_Pct_SVI smallint, -- Z
		Metro_status varchar(50), -- AA
		Administered_Dose1_Recip_5Plus int, -- AB
		Administered_Dose1_Recip_5PlusPop_Pct decimal(5,2), -- AC
		Series_Complete_5Plus int, -- AD
		Series_Complete_5PlusPop_Pct decimal(5,2) -- AE
	);

-- Drop Table COVID_Vaccination_Count_US_County;

-- Some of the Counties do not have valid FIPS values(are labeled UNK)

SELECT 
	*
FROM 
	COVID_vaccination_Count_US_County
WHERE
	FIPS = 'UNK'
ORDER BY 
	Date DESC;
	
SELECT
	Date,
	COUNT(*) as Num_UNK_County
FROM 
	COVID_Vaccination_Count_US_County
WHERE
	FIPS = 'UNK'
GROUP BY
	Date
ORDER BY 
	Date DESC;

-- According to query results, number of unknown counties is 34 on 2/19/21, and is 58 from 2/20 to 10/22
-- After that, is 59. That means there exists at least one state with more than one unknown county
-- Since some counties are unknown from the beginning, we can't match them with previous data from same table

SELECT 
	date, 
	COUNT(*) 
FROM 
	COVID_Vaccination_Count_US_County 
GROUP BY 
	date 
ORDER BY 
	date;
	
-- We can see from the result of the above query that the number data entries on 2021-02-19 was significantly
-- lower than that of 2021-02-20. 

-- Check to see if the number of known counties is different on the first day of data vs second day of data
	
SELECT
	c1.date, 
	c1.fips, 
	c1.recip_county, 
	c1.recip_state
FROM 
	COVID_Vaccination_Count_US_County c1
WHERE
	c1.FIPS NOT IN (
						SELECT
							FIPS
						FROM
							COVID_Vaccination_Count_US_County
						WHERE
							FIPS != 'UNK'
					)
	AND 
	c1.date = '2021-02-19'
ORDER BY 
	recip_state;

-- The above query tells us that there is no row that was not labeled 'UNK' on 2021-02-19 but was labeled 'UNK' on 2021-02-20

-- Get trends in historic change in data for vaccine series completion for overall population, and different age groups

SELECT 
	date,
	recip_county,
	recip_state,
	series_complete_pop_pct,
	series_complete_12pluspop_pct,
	series_complete_18pluspop_pct,
	series_complete_65pluspop_pct
FROM
	COVID_Vaccination_Count_US_County

-- Get counts of counties per state on most recent date to match with Census data to see which, if any, counties are missing
SELECT
	recip_state,
	COUNT(*) as Num_Counties
FROM
	COVID_Vaccination_Count_US_County
WHERE
	date = '2021-12-20'
GROUP BY recip_state

