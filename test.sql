--liquibase formatted sql
--changeset project1:test1:1 labels:STORE_ACTVT_MART context:"DEV_FLASH_MART.STORE_ACTVT_MART, QA_PAYROLL_MART.STORE_ACTVT_MART, UAT_PAYROLL_MART.STORE_ACTVT_MART, PROD_PAYROLL_MART.STORE_ACTVT_MART" runOnChange:true
--comment: create view

create or replace view VW_MDL_MMX_DETAIL_CICD_TEST1(
  SITE_KEY,
  SURVEY_DT,
  SURVEY_TIME,
  SURVEY_TIME_OF_DAY,
	VISIT_DT,
	VISIT_TIME,
	VISIT_TIME_OF_DAY,
	REG_NUM,
	STR_OSAT,
	STR_ASSOC_FRIENDLINESS,
	STR_AVAILBLTY_OF_ASSISTANCE,
	STR_DRESSING_FITTING_ROOMS_CLEANLINESS,
	STR_CASHIER_FRIENDLINESS,
	STR_SPEED_OF_CHKOUT,
	STR_EASE_OF_LOCATING_MDSE,
	STR_EASE_OF_MOVING_THROUGH_AISLES,
	STR_CLEANLINESS_OF_STR,
	STR_STY_SELTNS,
	STR_BRAND_SELTNS,
	STR_PDCT_QLTY,
	STR_VAL_FOR_PR_PAID,
	STR_COMFORT_AND_SFTY,
  column1,
	STR_CASHIER_ASKED_OFFERED_TJX_REWARDS_CR_CARD,
	REFRESH_DATE
) as 
/*
1. Purpose : Support Power BI Marmaxx Medallia survey data report
2. Summary : HGS Medallia detail data view
3. Version history
    - version 1 April 18, 2023 created by Jacob Whiteman: DSSTEAM-1835
	- version 2 May 26, 2023 Updated the script to include Surver Data: DSSTEAM-1910
    - version 3 November 8th, 2023 modified by Jacob Whiteman: removed SMG data, removed hard-coded start date for Medallia data
*/
SELECT 
  s.STR_KEY::varchar(20) as SITE_KEY, 
  RESP_DT::date as SURVEY_DT, 
  LEFT(RESP_TM,5)::varchar(8) as SURVEY_TIME, 
  CASE WHEN LEFT(RESP_TM, 5) BETWEEN to_time('12:00 AM') and to_time('11:59 AM') THEN 'Morning'  
       WHEN LEFT(RESP_TM, 5) BETWEEN to_time('12:00 PM') and to_time('04:59 PM') THEN 'Afternoon'  
       WHEN LEFT(RESP_TM, 5) BETWEEN to_time('05:00 PM') and to_time('11:59 PM') THEN 'Evening'  
    END::varchar(10) as SURVEY_TIME_OF_DAY, 
  TRX_DT::date as VISIT_DT, 
  TRX_TM::varchar(10) as VISIT_TIME, 
  CASE WHEN TRX_TM BETWEEN to_time('12:00 AM') and to_time('11:59 AM') THEN 'Morning'  
       WHEN TRX_TM BETWEEN to_time('12:00 PM') and to_time('04:59 PM') THEN 'Afternoon'  
       WHEN TRX_TM BETWEEN to_time('05:00 PM') and to_time('11:59 PM') THEN 'Evening'  
    END::varchar(10) as VISIT_TIME_OF_DAY, 
  REGIS_CD::varchar(10) as REG_NUM, 
  STR_OSAT::number(2) as STR_OSAT,
  STR_ASSOC_FRIENDLINESS::number(2) as STR_ASSOC_FRIENDLINESS, 
  STR_AVAILBLTY_OF_ASSISTANCE::number(2) as STR_AVAILBLTY_OF_ASSISTANCE,   
  STR_DRESSING_FITTING_ROOMS_CLEANLINESS::number(2) as STR_DRESSING_FITTING_ROOMS_CLEANLINESS,   
  STR_CASHIER_FRIENDLINESS::number(2) as STR_CASHIER_FRIENDLINESS, 
  STR_SPEED_OF_CHKOUT::number(2) as STR_SPEED_OF_CHKOUT,    
  STR_EASE_OF_LOCATING_MDSE::number(2) as STR_EASE_OF_LOCATING_MDSE,    
  STR_EASE_OF_MOVING_THROUGH_AISLES::number(2) as STR_EASE_OF_MOVING_THROUGH_AISLES,    
  STR_CLEANLINESS_OF_STR::number(2) as STR_CLEANLINESS_OF_STR,    
  STR_STY_SELTNS::number(2) as STR_STY_SELTNS,    
  STR_BRAND_SELTNS::number(2) as STR_BRAND_SELTNS,    
  STR_PDCT_QLTY::number(2) as STR_PDCT_QLTY,    
  STR_VAL_FOR_PR_PAID::number(2) as STR_VAL_FOR_PR_PAID,    
  STR_COMFORT_AND_SFTY::number(2) as STR_COMFORT_AND_SFTY,    
  STR_CASHIER_ASKED_OFFERED_TJX_REWARDS_CR_CARD::varchar(10) as STR_CASHIER_ASKED_OFFERED_TJX_REWARDS_CR_CARD,    
  current_timestamp()::timestamp_ntz AS REFRESH_DATE,
FROM ${SDS}.MDA.MD_CORP_CAL c 
INNER JOIN ${CDS_ENHD}.COM.T_MDL_CUST_SITE_SURVEY s 
  ON s.RESP_DT = c.CAL_DT
WHERE c.FISC_YY_NUM >= (select FISC_YY_NUM -2 from ${SDS}.MDA.MD_CORP_CAL where CAL_DT = current_date) and s.BAN_NUM in ('0008','0010')
;

--rollback empty;
