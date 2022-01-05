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

