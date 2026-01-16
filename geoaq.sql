
## BIOSAND NATIONAL PROJECT DATASETS ##

# -------- Select Project Schema / Database --------
USE geoaq;

#### CDC_PLACES (county_health part 1) ####
# =================================================-

SELECT * FROM cdc_places; -- view full table 

-- Preliminary data Quality Check of Potential Key Health Outcomes 

-- BPHIGH_AdjPrev = age-adjusted prevalence of high blood pressure among adults aged >=18
SELECT COUNT(BPHIGH_AdjPrev),  -- number / count of observations
AVG(BPHIGH_AdjPrev),           -- avg 
STD(BPHIGH_AdjPrev),		   -- standard dev
MIN(BPHIGH_AdjPrev),           -- min 
MAX(BPHIGH_AdjPrev)            -- max 
FROM cdc_places;        

-- CHD_AdjPrev = age-adjusted prevalence of coronary heart disease among adults aged >=18
SELECT COUNT(CHD_AdjPrev),     -- number / count of observations
AVG(CHD_AdjPrev),              -- avg 
STD(CHD_AdjPrev),			   -- standard dev
MIN(CHD_AdjPrev),              -- min 
MAX(CHD_AdjPrev)               -- max 
FROM cdc_places;              

-- STROKE_AdjPrev = age-adujusted prevalence of stroke among adults aged >=18
SELECT COUNT(STROKE_AdjPrev),  -- number / count of observations
AVG(STROKE_AdjPrev),           -- avg 
STD(STROKE_AdjPrev),		   -- standard dev
MIN(STROKE_AdjPrev),           -- min 
MAX(STROKE_AdjPrev)            -- max 
FROM cdc_places;       

SELECT 
	COUNT(*) AS total_rows,
    SUM(CASE WHEN BPHIGH_AdjPrev IS NULL THEN 1 ELSE 0 END) AS highbp_missing,
    SUM(CASE WHEN CHD_AdjPrev IS NULL THEN 1 ELSE 0 END) AS highbp_missing,
    SUM(CASE WHEN STROKE_AdjPrev IS NULL THEN 1 ELSE 0 END) AS highbp_missing
FROM cdc_places;

SELECT * FROM INFORMATION_SCHEMA.COLUMNS              -- query which columns are adjusted,
WHERE COLUMN_NAME LIKE '%AdjPrev%';                   -- leave out 'Crude' and 'CI' columns

CREATE VIEW cdc_places_adjvalues AS                   -- create view for better reproducibility
SELECT CountyFIPS AS FIPS, StateDesc AS STATE_NAME,   -- alias column name where necessary
CountyName AS COUNTY, StateAbbr AS STATE_ABBR, 
ACCESS2_AdjPrev,                   -- add queried Adjusted Columns
ARTHRITIS_AdjPrev, 
BINGE_AdjPrev,    
BPHIGH_AdjPrev, 
BPMED_AdjPrev, 
CANCER_AdjPrev,
CASTHMA_AdjPrev, 
CERVICAL_AdjPrev, 
CHD_AdjPrev,
CHECKUP_AdjPrev, 
CHOLSCREEN_AdjPrev, 
COLON_SCREEN_AdjPrev,
COPD_AdjPrev, 
COREM_AdjPrev, 
COREW_AdjPrev,
CSMOKING_AdjPrev, 
DENTAL_AdjPrev, 
DEPRESSION_AdjPrev,
DIABETES_AdjPrev, 
GHLTH_AdjPrev,
HIGHCHOL_AdjPrev,
KIDNEY_AdjPrev, 
LPA_AdjPrev, 
MAMMOUSE_AdjPrev,
MHLTH_AdjPrev, 
OBESITY_AdjPrev, 
PHLTH_AdjPrev,
SLEEP_AdjPrev, 
STROKE_AdjPrev, 
TEETHLOST_AdjPrev,
HEARING_AdjPrev, 
VISION_AdjPrev, 
COGNITION_AdjPrev,
MOBILITY_AdjPrev, 
SELFCARE_AdjPrev, 
INDEPLIVE_AdjPrev,
DISABILITY_AdjPrev
FROM cdc_places;  


SELECT * FROM cdc_places_adjvalues    -- select created view             
WHERE STATE_ABBR NOT IN ('HI', 'AK')  -- filter for contiguous United States
ORDER BY FIPS;   


#### COUNTY ROADMAP AND RANKING - CHRR (county_health part 2) ####
# =================================================-

-- view full county roadmap and ranking (chrr) datasets 

select * from chrr_2022;         
select * from chrr_2023;
select * from chrr_2024;

SELECT CONCAT('c22.',column_name,',')  -- make list of all colums with table name  
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'chrr_2022';        -- copy and paste results into final query

SELECT CONCAT('c23.',column_name,',')  -- make list of all colums with table name 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'chrr_2023';        -- copy and paste results into final query

SELECT CONCAT('c24.',column_name,',')  -- make list of all colums with table name -
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'chrr_2024';        -- copy and paste results into final query


CREATE VIEW chrr AS    				   -- create view for easier reproducilbility
SELECT c22.FIPS,      				   -- selecting attributes from list generated above
c22.STATE_ABBR,
c22.county AS COUNTY_NAME,
c22.SchoolSegregation,
c22.ChildcareCostBurden,
c23.Dentists,
c23.HighSchoolCompletion,
c23.SomeCollege,
c23.Unemployment,
c23.ChildrenInPoverty,
c23.IncomeInequality,
c23.ChildrenSingleParentHH,
c23.AirPollution_2019_23,
c23.DrinkingWaterViolations,
c23.DrivingAloneToWork,
c23.LongCommute,
c23.DisconnectedYouth, 
c23.GenderPayGap,
c23.MedianHHIncome,
c23.ChildrenFreeReducedPriceLunch,
c23.ResidentialSegregation,
c23.Homeownership,
c23.SevereHousingCostBurden,
c23.BroadbandAccess,
c23.Population,
c23.AgeBelow18,
c23.Age65Older,
c23.Black,
c23.AmericanIndianAlaskaNative,
c23.Asian,
c23.NativeHawaiianOtherPacificIslander,
c23.Hispanic,
c23.White,
c23.NotProficientEnglish,
c23.Female,
c24.PrematureDeath,
c24.PoorFairHealth,
c24.PoorPhysicalHealthDays,
c24.PoorMentalHealthDays,
c24.LowBirthweight,
c24.AdultSmoking,
c24.AdultObesity,
c24.FoodEnvironmentIndex,
c24.PhysicalInactivity,
c24.AccesstoExerciseOpportunities,
c24.ExcessiveDrinking,
c24.AlcoholImpairedDrivingDeaths,
c24.STI,
c24.TeenBirths,
c24.Uninsured,
c24.PrimaryCarePhysicians,
c24.PreventableHospitalStays,
c24.MammographyScreening,
c24.FluVaccinations,
c24.SocialAssociations,
c24.InjuryDeaths,
c24.AirPollution_2019,
c24.HHighHousingCosts,
c24.HHwOvercrowding,
c24.HHwLackKitchenPlumbingFacilities,
c24.LifeExpectancy,
c24.PrematureAgeAdjustedMortality,
c24.ChildMortality,
c24.InfantMortality,
c24.FrequentPhysicalDistress,
c24.DiabetesPrevalence,
c24.HIVPrevalence,
c24.FoodInsecurity,
c24.DrugOverdoseDeaths,
c24.UninsuredAdults,
c24.UninsuredChildren,
c24.HighSchoolGraduation,
c24.ChildrenEligibleFreeReducedLunch,
c24.Residential,
c24.ChildCareCenters,
c24.Homicides,
c24.Suicides,
c24.FirearmFatalities,
c24.MotorVehicleCrashDeaths,
c24.JuvenileArrests,
c24.FormalJuvenileDelinquencyCases,
c24.InformalJuvenileDelinquencyCases,
c24.Rural
FROM chrr_2022 AS c22, chrr_2023 AS c23,    -- aliased tables
chrr_2024 AS c24                         		
WHERE c22.FIPS = c23.FIPS                   -- join FIPS of chrr_2022 and chrr_2023
AND c23.FIPS = c24.FIPS;				    -- join FIPS of chrr_2023 and chrr_2024

SELECT * FROM chrr                          -- select created view             
WHERE STATE_ABBR NOT IN ('HI', 'AK')        -- filter for contiguous United States
ORDER BY FIPS;   

#=================================================-
#### AIR QUALITY (county_airquality)  ####

SELECT * FROM county_airquality; -- view full table

-- Preliminary data Quality Check of Key Environmental Factor 

-- MEAN = yearly county-level means of PM2.5 Concentration in ug/m3 LC 
-- generated from all Air Quality Monitors in the contingous US recognized by the EPA

SELECT COUNT(MEAN),  -- number / count of observations
AVG(MEAN),           -- avg 
STD(MEAN),		     -- standard dev
MIN(MEAN),           -- min 
MAX(MEAN)            -- max 
FROM county_airquality;

SELECT FIPS,          -- Select county_airquality table 
NAME AS COUNTY_NAME,  -- with altered alias where necessary
STATE_NAME, 
STATE_ABBR,
MEAN AS  AIRQUALTY_MEAN
FROM county_airquality
WHERE STATE_ABBR NOT IN ('HI', 'AK')   -- filter for contiguous United States
ORDER BY AIRQUALTY_MEAN
DESC;
