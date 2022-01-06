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
	
