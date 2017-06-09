
SELECT * FROM SPONSOR_TERM_TYPE;
SELECT * FROM SPONSOR_TERM;
SELECT * FROM AWARD_SPONSOR_TERM;
SELECT * FROM AWARD_TEMPLATE_TERMS;

SELECT (@terms:= COUNT(*)) as COUNT 
FROM award_template_Terms ;

START TRANSACTION;

INSERT sponsor_term_type(VER_NBR, SPONSOR_TERM_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
VALUES
(1,	100,	'Common Prior Approval Terms (Not All Inclusive)',	NOW(),	'admin',	UUID()),
(1,	110,	'No-Cost Extension Terms',	NOW(),	'admin',	UUID()),
(1,	120,	'Travel Restrictions Terms',	NOW(),	'admin',	UUID()),
(1,	130,	'Subaward/Subcontract Approval Terms',	NOW(),	'admin',	UUID()),
(1,	140,	'Equipment Approval Terms',	NOW(),	'admin',	UUID()),
(1,	150,	'Equipment Title Terms',	NOW(),	'admin',	UUID()),
(1,	160,	'Rights In Data Terms',	NOW(),	'admin',	UUID()),
(1,	170,	'Invention Terms',	NOW(),	'admin',	UUID()),
(1,	180,	'Publication Terms',	NOW(),	'admin',	UUID()),
(1,	190,	'Miscellaneous Terms',	NOW(),	'admin',	UUID());

INSERT sponsor_term(VER_NBR, SPONSOR_TERM_ID, SPONSOR_TERM_CODE, SPONSOR_TERM_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
values
(1,	1000,	1,	100,'Migrated from CMM - Information not available in Kuali',	NOW(),'admin',	UUID()),
(1,	1010,	2,	100,'No clause(s)',	NOW(),'admin',	UUID()),
(1,	1020,	3,	100,'Unusual requirement(s) - see award',	NOW(),'admin',	UUID()),
(1,	1030,	3,	100,'Change in the scope or objective of the project/program requires prior sponsor approval',	NOW(),'admin',	UUID()),
(1,	1040,	3,	100,'Change of key person(s) identified in the award requires prior sponsor approval',	NOW(),'admin',	UUID()),
(1,	1050,	3,	100,'Prior approval required for alteration and/or renovation costs',	NOW(),'admin',	UUID()),
(1,	1060,	3,	100,'Disengagement from the project for more than 3 months or a 25% reduction in time devoted to the projected by the approved project director or PI requires prior sponsor approval',	NOW(),'admin',	UUID()),
(1,	1070,	3,	100,'Prior approval required for transfer of award to another institution',	NOW(),'admin',	UUID()),
(1,	1080,	3,	100,'Prior approval required for transfers between budget items when the cumulative amount of such transfers exceeds a specific percentage of the total budget - see award',	NOW(),'admin',	UUID()),
(1,	1090,	3,	100,'Sponsor approval is required for the inclusion, unless otherwise waived by the sponsor, of costs that require prior approval in accordance with 2 CFR 200 Subpart E',	NOW(),'admin',	UUID()),
(1,	1100,	3,	100,'Transfer of funds budgeted for participant support costs to other categories of expense require prior sponsor approval',	NOW(),'admin',	UUID()),
(1,	1110,	3,	100,'Changes in the approved cost-sharing or matching require prior sponsor approval',	NOW(),'admin',	UUID()),
(1,	1120,	1,	110,'Migrated from CMM - Information not available in Kuali',	NOW(),'admin',	UUID()),
(1,	1130,	2,	110,'No clause',	NOW(),'admin',	UUID()),
(1,	1140,	3,	110,'Unusual requirement - see award',	NOW(),'admin',	UUID()),
(1,	1150,	3,	110,'No cost extensions are not allowed',	NOW(),'admin',	UUID()),
(1,	1160,	3,	110,'Sponsor must approve all no-cost extensions - no specific time frame identified',	NOW(),'admin',	UUID()),
(1,	1170,	3,	110,'Sponsor must approve all no-cost extensions - see award for required time frame',	NOW(),'admin',	UUID()),
(1,	1180,	3,	110,'Sponsor must be notified at least 10 days prior to award expiration of exercise of the first no-cost extension',	NOW(),'admin',	UUID()),
(1,	1190,	3,	110,'Sponsor must be notified at least 30 days prior to award expiration of exercise of the first no-cost extension',	NOW(),'admin',	UUID()),
(1,	1200,	3,	110,'Sponsor must be notified at least 45 days prior to award expiration of exercise of the first no-cost extension',	NOW(),'admin',	UUID()),
(1,	1210,	3,	110,'Sponsor must be notified in advance prior to award expiration of exercise of the first no-cost extension - see award for required time frame',	NOW(),'admin',	UUID()),
(1,	1220,	3,	110,'Sponsor approval must be requested at least 30 days prior to award expiration for no-cost extensions subsequent to the first no-cost extension',	NOW(),'admin',	UUID()),
(1,	1230,	3,	110,'Sponsor approval must be requested at least 45 days prior to award expiration for no-cost extensions subsequent to the first no-cost extension',	NOW(),'admin',	UUID()),
(1,	1240,	3,	110,'Sponsor approval must be requested prior to award expiration for no-cost extensions subsequent to the first no-cost extension - see award for required time frame',	NOW(),'admin',	UUID()),
(1,	1250,	1,	120,'Migrated from CMM - Information may not be complete in Kuali',	NOW(),'admin',	UUID()),
(1,	1260,	2,	120,'No clause',	NOW(),'admin',	UUID()),
(1,	1270,	3,	120,'Unusual requirement - see award',	NOW(),'admin',	UUID()),
(1,	1280,	3,	120,'No travel restrictions',	NOW(),'admin',	UUID()),
(1,	1290,	3,	120,'No travel is allowed',	NOW(),'admin',	UUID()),
(1,	1300,	3,	120,'No foreign travel is allowed',	NOW(),'admin',	UUID()),
(1,	1310,	3,	120,'All travel requires prior approval, whether or not in the approved budget',	NOW(),'admin',	UUID()),
(1,	1320,	3,	120,'All travel not in the approved budget requires prior approval',	NOW(),'admin',	UUID()),
(1,	1330,	3,	120,'Each foreign trip requires prior approval, whether or not in the approved budget',	NOW(),'admin',	UUID()),
(1,	1340,	3,	120,'Travel costs not in UCAR\'s budget; sponsor will reimburse or pay for travel separately',	NOW(),'admin',	UUID()),
(1,	1350,	3,	120,'Federal Travel Regulations (FTR) apply',	NOW(),'admin',	UUID()),
(1,	1360,	3,	120,'Restrictive travel regulations (other than FTR) apply - see award',	NOW(),'admin',	UUID()),
(1,	1370,	3,	120,'Prior approval is required for use of a foreign air carrier (i.e., not a U.S. flag carrier)',	NOW(),'admin',	UUID()),
(1,	1380,	1,	130,'Migrated from CMM - Information not available in Kuali',	NOW(),'admin',	UUID()),
(1,	1390,	2,	130,'No clause',	NOW(),'admin',	UUID()),
(1,	1400,	3,	130,'Unusual requirement - see award',	NOW(),'admin',	UUID()),
(1,	1410,	3,	130,'No subawarding/subcontracting restrictions',	NOW(),'admin',	UUID()),
(1,	1420,	3,	130,'Subawards/subcontracts not identified in the approved budget require prior sponsor approval',	NOW(),'admin',	UUID()),
(1,	1430,	3,	130,'All subawards/subcontracts require prior approval, whether or not in the approved budget',	NOW(),'admin',	UUID()),
(1,	1440,	3,	130,'Sole source subawards/subcontracts in excess of a specific dollar amount require prior sponsor approval - see award terms for dollar amount',	NOW(),'admin',	UUID()),
(1,	1450,	1,	140,'Migrated from CMM - Information not available in Kuali',	NOW(),'admin',	UUID()),
(1,	1460,	2,	140,'No clause',	NOW(),'admin',	UUID()),
(1,	1470,	3,	140,'Unusual requirement - see award',	NOW(),'admin',	UUID()),
(1,	1480,	3,	140,'No equipment purchases are allowed',	NOW(),'admin',	UUID()),
(1,	1490,	3,	140,'No equipment purchase restrictions from sponsor',	NOW(),'admin',	UUID()),
(1,	1500,	3,	140,'Equipment identified in budget may be purchased',	NOW(),'admin',	UUID()),
(1,	1510,	3,	140,'Equipment not identified in budget requires prior approval from sponsor',	NOW(),'admin',	UUID()),
(1,	1520,	3,	140,'All equipment purchases requires prior approval from sponsor, whether or not in budget',	NOW(),'admin',	UUID()),
(1,	1530,	3,	140,'Equipment restrictions include materials/supplies - see award',	NOW(),'admin',	UUID()),
(1,	1540,	1,	150,'Migrated from CMM - Information may not be complete in Kuali',	NOW(),'admin',	UUID()),
(1,	1550,	3,	150,'NOPROP - No equipment in budget',	NOW(),'admin',	UUID()),
(1,	1560,	3,	150,'UCAROR - Title to purchased equipment vests in UCAR',	NOW(),'admin',	UUID()),
(1,	1570,	3,	150,'OTHGOVT - Title vests in a U.S. federal sponsor other than NSF',	NOW(),'admin',	UUID()),
(1,	1580,	3,	150,'NONGOVT - Title vests in sponsor; sponsor is not a U.S. federal agency',	NOW(),'admin',	UUID()),
(1,	1590,	3,	150,'NSF - Title vests in NSF',	NOW(),'admin',	UUID()),
(1,	1600,	3,	150,'UCARCD - Title vests in UCAR, but conditions exist',	NOW(),'admin',	UUID()),
(1,	1610,	3,	150,'U.S. government furnished equipment (GFE) is being provided to UCAR',	NOW(),'admin',	UUID()),
(1,	1620,	3,	150,'Sponsor furnished equipment is being provided to UCAR; sponsor is not a U.S. federal agency',	NOW(),'admin',	UUID()),
(1,	1630,	1,	160,'Migrated from CMM - Information not available in Kuali',	NOW(),'admin',	UUID()),
(1,	1640,	2,	160,'No clause',	NOW(),'admin',	UUID()),
(1,	1650,	3,	160,'Unusual requirement - see award',	NOW(),'admin',	UUID()),
(1,	1660,	3,	160,'FAR 52.227-14, Rights in Data General: Title to UCAR for scientific publications; Nonexclusive paid-up license to the U.S. Government; Sponsor approval required to copyright other data',	NOW(),'admin',	UUID()),
(1,	1670,	3,	160,'FAR 52-227-14, Alt IV, Rights in Data General: Title to UCAR for all data produced; Nonexclusive, paid-up license to the U.S. Government',	NOW(),'admin',	UUID()),
(1,	1680,	3,	160,'Additional rights in data clause(s) apply - see award',	NOW(),'admin',	UUID()),
(1,	1690,	3,	160,'Title to UCAR; Nonexclusive, royalty-free license to the U.S. Government',	NOW(),'admin',	UUID()),
(1,	1700,	3,	160,'Title to UCAR; Nonexclusive, royalty-free license to sponsor (may include restrictions)',	NOW(),'admin',	UUID()),
(1,	1710,	3,	160,'Title to sponsor to deliverables that are data/intellectual property',	NOW(),'admin',	UUID()),
(1,	1720,	1,	170,'Migrated from CMM - Information not available in Kuali',	NOW(),'admin',	UUID()),
(1,	1730,	2,	170,'No clause',	NOW(),'admin',	UUID()),
(1,	1740,	3,	170,'Unusual requirement - see award',	NOW(),'admin',	UUID()),
(1,	1750,	3,	170,'Title to inventions will vest in UCAR',	NOW(),'admin',	UUID()),
(1,	1760,	3,	170,'Title to joint inventions will vest jointly',	NOW(),'admin',	UUID()),
(1,	1770,	1,	180,'Migrated from CMM - Information not available in Kuali',	NOW(),'admin',	UUID()),
(1,	1780,	2,	180,'No clause',	NOW(),'admin',	UUID()),
(1,	1790,	3,	180,'Unusual requirement - see award',	NOW(),'admin',	UUID()),
(1,	1800,	3,	180,'No publication restrictions',	NOW(),'admin',	UUID()),
(1,	1810,	3,	180,'Publications require sponsor approval',	NOW(),'admin',	UUID()),
(1,	1820,	3,	180,'Publications require sponsor review',	NOW(),'admin',	UUID()),
(1,	1830,	1,	190,'Migrated from CMM - Information may not be complete in Kuali',	NOW(),'admin',	UUID()),
(1,	1840,	2,	190,'No clause',	NOW(),'admin',	UUID()),
(1,	1850,	3,	190,'Reduced indirect cost rate',	NOW(),'admin',	UUID()),
(1,	1860,	3,	190,'Indirect costs are capped at a specified dollar level - see award',	NOW(),'admin',	UUID()),
(1,	1870,	3,	190,'Reduced benefit rate',	NOW(),'admin',	UUID()),
(1,	1880,	3,	190,'Carrying over funds requires sponsor approval',	NOW(),'admin',	UUID()),
(1,	1890,	3,	190,'Award is subject to FISMA',	NOW(),'admin',	UUID()),
(1,	1900,	3,	190,'Award is subject to cybersecurity requirements other than FISMA',	NOW(),'admin',	UUID()),
(1,	1910,	3,	190,'Cost sharing is required',	NOW(),'admin',	UUID()),
(1,	1920,	3,	190,'UCAR Management Fee is not allowed',	NOW(),'admin',	UUID()),
(1,	1930,	3,	190,'Fee billing restrictions',	NOW(),'admin',	UUID()),
(1,	1940,	3,	190,'Notification must be sent to sponsor when costs are projected to reach a specific percentage of the authorized funding within a given time frame (see Custom Data tab for details)',	NOW(),'admin',	UUID()),
(1,	1950,	3,	190,'Cost Accounting Standards or Modified Cost Accounting Standards apply',	NOW(),'admin',	UUID());


SELECT (@variable:= SPONSOR_TERM_ID) as Variable 
FROM SPONSOR_TERM 
WHERE SPONSOR_TERM_CODE = 2 
AND SPONSOR_TERM_TYPE_CODE = 100;

UPDATE award_sponsor_term
SET sponsor_term_id = @Variable,
SEQUENCE_NUMBER = 2;

DELETE FROM SPONSOR_TERM 
WHERE SPONSOR_TERM_TYPE_CODE < 100;

DELETE FROM sponsor_term_type 
WHERE SPONSOR_TERM_TYPE_CODE < 100;

COMMIT;



