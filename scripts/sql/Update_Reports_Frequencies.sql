-- this is related to jira ticket #622

-- report class 

START TRANSACTION;

SELECT * FROM award_report_terms;
SELECT * FROM report_class;
select * from report;
select * from frequency;
select * from frequency_base;
select * from distribution;
SELECT * FROM award_template_report_terms;
select * from valid_frequency_base;
select * from valid_class_report_freq;
select * from award;
select * from closeout_report_type;
select * from award_closeout;
select * from krcr_parm_t;
select * from report_status;
select * from award_payment_schedule;

-- Report Status

--  updating existing values
 
UPDATE REPORT_STATUS
SET Description = 'Approved Internally'
WHERE REPORT_STATUS_CODE = 1 ;

UPDATE REPORT_STATUS
SET Description = 'Due'
WHERE REPORT_STATUS_CODE = 2 ;

UPDATE REPORT_STATUS
SET Description = 'Pending'
WHERE REPORT_STATUS_CODE = 3 ;

UPDATE REPORT_STATUS
SET Description = 'Received'
WHERE REPORT_STATUS_CODE = 4 ;

-- adding in new values

INSERT report_status (REPORT_STATUS_CODE, DESCRIPTION, ACTIVE_FLAG, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
VALUES(5,	'Revised',	'Y',	NOW(),	'admin',	1,	UUID()),
(6,	'Submitted for Internal Approval',	'Y',	NOW(),	'admin',	1,	UUID()),
(7,	'Submitted to Sponsor',	'Y',	NOW(),	'admin',	1,	UUID());


-- Insert and update report_class

INSERT REPORT_CLASS(VER_NBR, REPORT_CLASS_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, GENERATE_REPORT_REQUIREMENTS, OBJ_ID, ACTIVE_FLAG)
VALUES
(1,	100,	'Contracts',	NOW(),	'admin',	'Y',	UUID(),	'Y'),
(1,	110,	'Financial',	NOW(),	'admin',	'Y',	UUID(),	'Y'),
(1,	120,	'Intellectual Property', NOW(),	'admin',	'Y',	UUID(),	'Y'),
(1,	130,	'Legal',	NOW(),	'admin',	'Y',	UUID(),	'Y'),
(1,	140,	'NCAR Operations',	NOW(),	'admin',	'Y',	UUID(),	'Y'),
(1,	150,	'Payment/Invoice',	NOW(),	'admin',	'Y',	UUID(),'Y'),
(1,	160,	'Procurement',	NOW(),	'admin',	'Y',	UUID(),	'Y'),
(1,	170,	'Property',	NOW(),	'admin',	'N',	UUID(),	'Y'),
(1,	180,	'Technical/Management',	NOW(),	'admin',	'Y',	UUID(),	'Y');

-- update the parameter table to make sure the classes are correctly configured.
UPDATE krcr_parm_t
SET VAL = '150'
WHERE OBJ_ID = '90e784fe-b043-11e6-90ab-23170aee8aea';

UPDATE krcr_parm_t
SET VAL = '150'
WHERE OBJ_ID = '90e76ad2-b043-11e6-90ab-23170aee8aea';

UPDATE krcr_parm_t
SET VAL = '100,110,120, 130,140,160,170,180'
WHERE OBJ_ID = '90e794da-b043-11e6-90ab-23170aee8aea';

-- updating a relational table that is affected by the report class code
UPDATE AWARD_REPORT_TERMS
	SET REPORT_CLASS_CODE = CASE 	
								WHEN REPORT_CLASS_CODE = 1 THEN 110 
								WHEN REPORT_CLASS_CODE = 2 THEN 170
								WHEN REPORT_CLASS_CODE = 3 THEN 120 
								WHEN REPORT_CLASS_CODE = 4 THEN 180
								WHEN REPORT_CLASS_CODE = 5 THEN 160 
								WHEN REPORT_CLASS_CODE = 6 THEN 150 
								WHEN REPORT_CLASS_CODE = 7 THEN 100 
							END;
                            

-- truncating the valid class report frequency table so that relating tables can be updated
TRUNCATE TABLE valid_class_report_freq;

-- updating a relational table so that report classes can be deleted.
UPDATE Award_Template_Report_Terms
	SET REPORT_CLASS_CODE = CASE 	
								WHEN REPORT_CLASS_CODE = 1 THEN 110 
								WHEN REPORT_CLASS_CODE = 2 THEN 170
								WHEN REPORT_CLASS_CODE = 3 THEN 120 
								WHEN REPORT_CLASS_CODE = 4 THEN 180
								WHEN REPORT_CLASS_CODE = 5 THEN 160 
								WHEN REPORT_CLASS_CODE = 6 THEN 150 
								WHEN REPORT_CLASS_CODE = 7 THEN 100 
							END;

DELETE FROM REPORT_CLASS
WHERE REPORT_CLASS_CODE < 100;

-- insert frequency with a couple new values

INSERT frequency (VER_NBR, FREQUENCY_CODE, DESCRIPTION, NUMBER_OF_DAYS, NUMBER_OF_MONTHS, REPEAT_FLAG, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID, ACTIVE_FLAG)
value(1, 61, '30 Days After Each Semi-annual', 30, 6, 'Y', NOW(), 'admin', UUID(), 'Y'),
(1, 62, '30 Days After Each Quarter', 30, 3, 'Y', NOW(), 'admin', UUID(), 'Y');

-- insert closeout report type

INSERT closeout_report_type(CLOSEOUT_REPORT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
VALUES
(100,	'Contracts',	NOW(),	'admin',	1,	UUID()),
(110,	'Financial',	NOW(),	'admin',	1,	UUID()),
(120,	'Intellectual Property',	NOW(),	'admin',	1,	UUID()),
(130,	'Legal',	NOW(),	'admin',	1,	UUID()),
(140,	'NCAR Operations',	NOW(),	'admin',	1,	UUID()),
(150,	'Payment/Invoice',	NOW(),	'admin',	1,	UUID()),
(160,	'Procurement',	NOW(),	'admin',	1,	UUID()),
(170,	'Property',	NOW(),	'admin',	1,	UUID()),
(180,	'Technical/Management',	NOW(),	'admin',	1,	UUID());

-- reassigning values in the relational table for closeout report type, so the old values can be deleted.
UPDATE award_closeout
SET CLOSEOUT_REPORT_CODE = CASE
								WHEN CLOSEOUT_REPORT_CODE = 1 THEN 110
                                WHEN CLOSEOUT_REPORT_CODE = 2 THEN 170
                                WHEN CLOSEOUT_REPORT_CODE = 3 THEN 130
                                WHEN CLOSEOUT_REPORT_CODE = 4 THEN 180
                                WHEN CLOSEOUT_REPORT_CODE = 6 THEN 150
                                WHEN CLOSEOUT_REPORT_CODE = 'UD' THEN 140
                                
							END;
                            
-- more parameter table updates so the system understands the new configurations
UPDATE krcr_parm_t
SET VAL = '110',
PARM_DESC_TXT = 'This system parameter maps the CloseoutReportType Technical(closeoutReportTypeCode=110) with ReportClass Technical Management(reportClassCode=110). If this system parameter is changed - the corresponding values in CloseoutReportType and ReportClass tables should be updated as well.'
WHERE OBJ_ID = '90e73c42-b043-11e6-90ab-23170aee8aea';

UPDATE krcr_parm_t
SET VAL = '170',
PARM_DESC_TXT = 'This system parameter maps the CloseoutReportType Technical(closeoutReportTypeCode=170) with ReportClass Technical Management(reportClassCode=170). If this system parameter is changed - the corresponding values in CloseoutReportType and ReportClass tables should be updated as well.'
WHERE OBJ_ID = '90e74c14-b043-11e6-90ab-23170aee8aea';

UPDATE krcr_parm_t
SET VAL = '130',
PARM_DESC_TXT = 'This system parameter maps the CloseoutReportType Technical(closeoutReportTypeCode=130) with ReportClass Technical Management(reportClassCode=130). If this system parameter is changed - the corresponding values in CloseoutReportType and ReportClass tables should be updated as well.',
PARM_NM = 'closeoutReportTypeLegal'
WHERE OBJ_ID = '90e7452a-b043-11e6-90ab-23170aee8aea';

UPDATE krcr_parm_t
SET VAL = '180',
PARM_DESC_TXT = 'This system parameter maps the CloseoutReportType Technical(closeoutReportTypeCode=180) with ReportClass Technical Management(reportClassCode=180). If this system parameter is changed - the corresponding values in CloseoutReportType and ReportClass tables should be updated as well.'
WHERE OBJ_ID = '90e75042-b043-11e6-90ab-23170aee8aea';

UPDATE krcr_parm_t
SET VAL = '150',
PARM_DESC_TXT = 'This system parameter maps the CloseoutReportType Technical(closeoutReportTypeCode=150) with ReportClass Technical Management(reportClassCode=150). If this system parameter is changed - the corresponding values in CloseoutReportType and ReportClass tables should be updated as well.'
WHERE OBJ_ID = 'a22bfeca-b043-11e6-90ab-23170aee8aea';
                           
UPDATE krcr_parm_t
SET VAL = '140',
PARM_DESC_TXT = 'This system parameter maps the CloseoutReportType Technical(closeoutReportTypeCode=140) with ReportClass Technical Management(reportClassCode=140). If this system parameter is changed - the corresponding values in CloseoutReportType and ReportClass tables should be updated as well.'
WHERE OBJ_ID = '90e75434-b043-11e6-90ab-23170aee8aea';


-- because there are more values now, more records are created in the parameter table.

INSERT krcr_parm_t(NMSPC_CD, CMPNT_CD, PARM_NM, OBJ_ID, VER_NBR, PARM_TYP_CD, VAL, PARM_DESC_TXT, EVAL_OPRTR_CD, APPL_ID)
VALUES
('KC-AWARD', 
'Document', 
'closeoutReportTypeContracts', 
UUID(), 
1, 
'CONFG',
100,
'This system parameter maps the CloseoutReportType Technical(closeoutReportTypeCode=100) with ReportClass Technical Management(reportClassCode=100). If this system parameter is changed - the corresponding values in CloseoutReportType and ReportClass tables should be updated as well.' ,                       
 'A',
 'KC'),
 
 ('KC-AWARD', 
'Document', 
'closeoutReportTypeIntellectualProperty', 
UUID(), 
1, 
'CONFG',
120,
'This system parameter maps the CloseoutReportType Technical(closeoutReportTypeCode=120) with ReportClass Technical Management(reportClassCode=120). If this system parameter is changed - the corresponding values in CloseoutReportType and ReportClass tables should be updated as well.' ,                       
 'A',
 'KC'),
 
 ('KC-AWARD', 
'Document', 
'closeoutReportTypeProcurement', 
UUID(), 
1, 
'CONFG',
160,
'This system parameter maps the CloseoutReportType Technical(closeoutReportTypeCode=160) with ReportClass Technical Management(reportClassCode=160). If this system parameter is changed - the corresponding values in CloseoutReportType and ReportClass tables should be updated as well.' ,                       
 'A',
 'KC');
 
 -- delete older report types
 
 DELETE FROM closeout_report_type
 WHERE CLOSEOUT_REPORT_CODE < 100;
 
 -- delete old values and insert new ones for the valid frequency base table.
 
 TRUNCATE valid_frequency_base;

INSERT valid_frequency_base(VALID_FREQUENCY_BASE_ID, FREQUENCY_BASE_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID,  FREQUENCY_CODE)
VALUES 
(1, 3, NOW(), 'admin', 1, UUID(),35), -- 120 days prior to expiration
(2, 4, NOW(), 'admin', 1, UUID(),35), -- 120 days prior to expiration
(3, 4, NOW(), 'admin', 1, UUID(),58),  -- 15 days after expiration
(4, 2, NOW(), 'admin', 1, UUID(),38), -- 30 days after award effective date
(5, 2, NOW(), 'admin', 1, UUID(),27), -- 30 days after effective date
(6, 3, NOW(), 'admin', 1, UUID(),10), -- 30 days after expiration
(7, 4, NOW(), 'admin', 1, UUID(),10), -- 30 days after expiration
(8, 3, NOW(), 'admin', 1, UUID(),15), -- 30 days prior to expiration date
(9, 3, NOW(), 'admin', 1, UUID(),15), -- 30 days prior to expiration date
(10, 3, NOW(), 'admin', 1, UUID(),33), -- 45 days after expiration
(11, 4, NOW(), 'admin', 1, UUID(),33), -- 45 days after expiration
(12, 5, NOW(), 'admin', 1, UUID(),36), -- 45 days prior to expiration
(13, 4, NOW(), 'admin', 1, UUID(),36), -- 45 days prior to expiration
(14, 2, NOW(), 'admin', 1, UUID(),39), -- 6 months after award effective date
(15, 3, NOW(), 'admin', 1, UUID(),30), -- 6 months after expiration date
(16, 3, NOW(), 'admin', 1, UUID(),20), -- 6 months prior to expiration date
(17, 4, NOW(), 'admin', 1, UUID(),20), -- 6 months prior to expiration date
(18, 2, NOW(), 'admin', 1, UUID(),45), -- 60 days after effective date
(19, 3, NOW(), 'admin', 1, UUID(),11), -- 60 days after expiration
(20, 4, NOW(), 'admin', 1, UUID(),11), -- 60 days after expiration
(21, 6, NOW(), 'admin', 1, UUID(),59), -- 60 days prior to anniversary date
(22, 4, NOW(), 'admin', 1, UUID(),59), -- 60 days prior to anniversary date
(23, 3, NOW(), 'admin', 1, UUID(),16), -- 60 days prior to expiration date
(24, 4, NOW(), 'admin', 1, UUID(),16), -- 60 days prior to expiration date
(25, 2, NOW(), 'admin', 1, UUID(),44), -- 90 days after effective date
(26, 3, NOW(), 'admin', 1, UUID(),12), -- 90 days after expiration
(27, 4, NOW(), 'admin', 1, UUID(),12), -- 90 days after expiration
(28, 3, NOW(), 'admin', 1, UUID(),17), -- 90 days prior to expiration date
(29, 4, NOW(), 'admin', 1, UUID(),17), -- 90 days prior to expiration date
(30, 2, NOW(), 'admin', 1, UUID(),17), -- 90 days prior to expiration date
(31, 6, NOW(), 'admin', 1, UUID(),14), -- As required
(32, 3, NOW(), 'admin', 1, UUID(),14), -- As required
(33, 4, NOW(), 'admin', 1, UUID(),14), -- As required
(34, 2, NOW(), 'admin', 1, UUID(),14), -- As required
(35, 3, NOW(), 'admin', 1, UUID(),13), -- At expiration
(36, 4, NOW(), 'admin', 1, UUID(),13), -- At expiration
(37, 4, NOW(), 'admin', 1, UUID(),5),  -- One in advance
(38, 6, NOW(), 'admin', 1, UUID(),56), -- 15 Days After Each Quarter
(39, 1, NOW(), 'admin', 1, UUID(),32), -- 30 days after annual anniversary
(40, 5, NOW(), 'admin', 1, UUID(),32), -- 30 days after annual anniversary
(41, 4, NOW(), 'admin', 1, UUID(),32), -- 30 days after annual anniversary
(42, 2, NOW(), 'admin', 1, UUID(),32), -- 30 days after annual anniversary
(43, 6, NOW(), 'admin', 1, UUID(),62), -- 30 Days After Each Quarter
(44, 6, NOW(), 'admin', 1, UUID(),61), -- 30 Days After Each Semi-annual
(45, 1, NOW(), 'admin', 1, UUID(),31), -- 60 days after annual anniversary
(46, 5, NOW(), 'admin', 1, UUID(),31), -- 60 days after annual anniversary
(47, 2, NOW(), 'admin', 1, UUID(),31), -- 60 days after annual anniversary
(48, 2, NOW(), 'admin', 1, UUID(),55), -- 90 days prior to anniversaries
(49, 6, NOW(), 'admin', 1, UUID(),7),  -- Annual
(50, 1, NOW(), 'admin', 1, UUID(),7),  -- Annual
(51, 3, NOW(), 'admin', 1, UUID(),7),  -- Annual
(52, 5, NOW(), 'admin', 1, UUID(),7),  -- Annual
(53, 4, NOW(), 'admin', 1, UUID(),7),  -- Annual
(54, 2, NOW(), 'admin', 1, UUID(),7),  -- Annual
(55, 3, NOW(), 'admin', 1, UUID(),49), -- Annual - one month in advance
(56, 2, NOW(), 'admin', 1, UUID(),50), -- Annual - two months in advance
(57, 2, NOW(), 'admin', 1, UUID(),9),  -- Bi-monthly
(58, 6, NOW(), 'admin', 1, UUID(),2),  -- Monthly
(59, 1, NOW(), 'admin', 1, UUID(),2),  -- Monthly
(60, 2, NOW(), 'admin', 1, UUID(),2),  -- Monthly
(61, 6, NOW(), 'admin', 1, UUID(),3),  -- Quarterly 
(62, 3, NOW(), 'admin', 1, UUID(),3),  -- Quarterly 
(63, 5, NOW(), 'admin', 1, UUID(),3),  -- Quarterly 
(64, 4, NOW(), 'admin', 1, UUID(),3),  -- Quarterly 
(65, 2, NOW(), 'admin', 1, UUID(),3),  -- Quarterly 
(66, 6, NOW(), 'admin', 1, UUID(),6),  -- Semi-annual
(67, 2, NOW(), 'admin', 1, UUID(),6),  -- Semi-annual
(68, 2, NOW(), 'admin', 1, UUID(),52); -- Semi-annual - one month in advance

--  make changes to existing data and reassign values, so we can change the report tables.

UPDATE award_report_terms
SET REPORT_CODE = CASE 
					WHEN REPORT_CODE < 100 THEN 1
				  ELSE REPORT_CODE
                  END;
                  
UPDATE report
SET DESCRIPTION = 'Migrated Award-None' 
WHERE REPORT_CODE = 1;

TRUNCATE TABLE valid_class_report_freq;

INSERT REPORT(VER_NBR, REPORT_CODE, DESCRIPTION, FINAL_REPORT_FLAG, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID, ACTIVE_FLAG)
VALUES 
(1,	100,	'Financial Report',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	110,	'Final Financial Report-Final',	'Y',	NOW(),	'admin',	UUID(),	'Y'),
(1,	120,	'Federal Financial Report (SF 425)',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	130,	'Federal Financial Report (SF 425)-Final',	'Y',	NOW(),	'admin',	UUID(),	'Y'),
(1,	140,	'NASA Monthly Contract Financial Management Report (NASA 533M)',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	150,	'Invoice',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	160,	'Invoice - Final',	'Y',	NOW(),	'admin',	UUID(),	'Y'),
(1,	170,	'Invoice with Supporting Documentation',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	180,	'Invoice with Supporting Documentation-Final',	'Y',	NOW(),	'admin',	UUID(),	'Y'),
(1,	190,	'Invoice-Signature ',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	200,	'Invoice-Signature Final',	'Y',	NOW(),	'admin',	UUID(),	'Y'),
(1,	210,	'Invoice-Signature with Supporting Documentation',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	220,	'Invoice-Signature with Supporting Documentation-Final',	'Y',	NOW(),	'admin',	UUID(),	'Y'),
(1,	230,	'Invoice-Sponsor Form',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	240,	'Invoice-Sponsor Form-Final',	'Y',	NOW(),	'admin',	UUID(),	'Y'),
(1,	250,	'Online Request for Payment',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	260,	'Public Voucher for Purchases and Services (SF1034)',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	270,	'Public Voucher for Purchases-Continuation Sheet (SF1035)',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	280,	'Request for Advance or Reimbursement (SF270)',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	290,	'Request for Advance or Reimbursement (SF270)-Final',	'Y',	NOW(),	'admin',	UUID(),	'Y'),
(1,	300,	'Property Report',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	310,	'Property Report-Final',	'Y',	NOW(),	'admin',	UUID(),	'Y'),
(1,	320,	'Property -Sponsor Form',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	330,	'Property -Sponsor Form Final',	'Y',	NOW(),	'admin',	UUID(),	'Y'),
(1,	340,	'Contractor Report of Government Property-DOT (F 4220.43)',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	350,	'Inventory Disposal Schedule (SF 1428)-Final',	'Y',	NOW(),	'admin',	UUID(),	'Y'),
(1,	360,	'Property in the Custody of Contractors-NASA (SF 1018)',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	370,	'Property in the Custody of Contractors-NASA (SF 1018)-Final',	'Y',	NOW(),	'admin',	UUID(),	'Y'),
(1,	380,	'Tangible Personal Property Report-DOE (SF 428-B) Final',	'Y',	NOW(),	'admin',	UUID(),	'Y'),
(1,	390,	'Intellectual Property -Sponsor Form',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	400,	'Intellectual Property -Sponsor Form Final',	'Y',	NOW(),	'admin',	UUID(),	'Y'),
(1,	410,	'Intellectual Property Report',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	420,	'Intellectual Property Report-Final',	'Y',	NOW(),	'admin',	UUID(),	'Y'),
(1,	430,	'Patent Certification (DOE F 2050.11)',	'Y',	NOW(),	'admin',	UUID(),	'Y'),
(1,	440,	'Patent Documentation',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	450,	'Report of Inventions and Subcontracts (DD 882)',	'Y',	NOW(),	'admin',	UUID(),	'Y'),
(1,	460,	'Administrative Financial Report',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	470,	'Administrative Financial Report - Final',	'Y',	NOW(),	'admin',	UUID(),	'Y'),
(1,	480,	'Administrative Report',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	490,	'Administrative Report - Final',	'Y',	NOW(),	'admin',	UUID(),	'Y'),
(1,	500,	'Data Management Plan',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	510,	'Data Management Plan Final',	'Y',	NOW(),	'admin',	UUID(),	'Y'),
(1,	520,	'Deliverable Documentation',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	530,	'Management Plan',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	540,	'Milestone Deliverable Documentation',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	550,	'Milestone Report',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	560,	'Online Technical Report',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	570,	'Online Technical Report Final',	'Y',	NOW(),	'admin',	UUID(),	'Y'),
(1,	580,	'Presentation',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	590,	'Proceedings',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	600,	'Publication',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	610,	'Report Documentation Page (SF 298)',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	620,	'Technical Report',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	630,	'Technical Report-Final','Y',	NOW(),	'admin',	UUID(),	'Y'),
(1,	640,	'Technical Report-Sponsor Form',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	650,	'Technical Report-Sponsor Form Final',	'Y',	NOW(),	'admin',	UUID(),	'Y'),
(1,	660,	'Individual Summary Subcontract Report (ISR)',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	670,	'Individual Summary Subcontract Report (ISR)-Final',	'Y',	NOW(),	'admin',	UUID(),	'Y'),
(1,	680,	'Summary Subcontract Report (SSR)',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(0,	690,	'Summary Subcontract Report (SSR)-Final',	'Y',	NOW(),	'admin',	UUID(),	'Y'),
(1,	700,	'UCAR Subrecipient Closeout Form',	'Y',	NOW(),	'admin',	UUID(),	'Y'),
(0,	710,	'Annual Certification',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	720,	'Annual Manpower See Contract 417F7001',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	730,	'Annual Rate Letter ',	'N',	NOW(),	'admin',	UUID(),	'N'),
(1,	740,	'Assignment of Refunds, Rebates and Credits',	'Y',	NOW(),	'admin',	UUID(),	'Y'),
(1,	750,	'Audit Report 2 CFR 200.515',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	760,	'Closeout Summary Report',	'Y',	NOW(),	'admin',	UUID(),	'Y'),
(1,	770,	'Contractors Release',	'Y',	NOW(),	'admin',	UUID(),	'Y'),
(1,	780,	'Contractors Release and Assignment',	'Y',	NOW(),	'admin',	UUID(),	'Y'),
(1,	790,	'Internal Review Board (IRB) Approval',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	800,	'Property-Inventions-Patents-Royalties (PIPR)',	'Y',	NOW(),	'admin',	UUID(),	'Y'),
(1,	810,	'Service Contract Act Reporting',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	820,	'Invention Disclosures',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	830,	'Patent Applications',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	840,	'Energy/Sustainability Report',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	850,	'NCAR Program Operating Plan (POP)',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	860,	'NCAR Program Operating Plan Progress Report (POPPR)',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	870,	'GAU (Now Core-Hours) and SUR Funding Sources and Usage',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	880,	'UCAR Management Information Report',	'N',	NOW(),	'admin',	UUID(),	'Y');

UPDATE award_template_report_terms
SET REPORT_CODE = 1 
WHERE REPORT_CODE BETWEEN 2 AND 99;

DELETE FROM REPORT 
WHERE REPORT_CODE BETWEEN 2 AND 99;

--  update the sort order of frequency.  This is the because the frequencies are alpha sorted.
-- two spaces in front of the description puts the values to the very top, one space will put it directly below the two spaces
-- an underscore in the beginning of the description field will send the values to the bottom for the alpha sort.
/*
Update Frequency
Set Description = '  1 year after expiration',
Active_flag = 'N'
where Frequency_code = 42;

Update Frequency
Set Description = '  4 months after expiration date',
Active_flag = 'N'
where Frequency_code = 28;

Update Frequency
Set Description = '  4 months prior to expiration date',
Active_flag = 'N'
where Frequency_code = 18;

Update Frequency
Set Description = ' 10 months after effective date',
Active_flag = 'N'
where Frequency_code = 57;

Update Frequency
Set Description = ' 10 months prior to expiration date',
Active_flag = 'N'
where Frequency_code = 34;

Update Frequency
Set Description = '  5 months after expiration date',
Active_flag = 'N'
where Frequency_code = 29;

Update Frequency
Set Description = '  5 months prior to expiration date',
Active_flag = 'N'
where Frequency_code = 19;

Update Frequency
Set Description = '  6 months after award effective date'
where Frequency_code = 39;

Update Frequency
Set Description = '  6 months after expiration date'
where Frequency_code = 30;

Update Frequency
Set Description = '  6 months prior to expiration date'
where Frequency_code = 20;

Update Frequency
Set Description = '  7 months prior to expiration date',
Active_flag = 'N'
where Frequency_code = 21;

Update Frequency
Set Description = '  8 months prior to expiration date',
Active_flag = 'N'
where Frequency_code = 22;

Update Frequency
Set Description = '  9 months after award effective date',
Active_flag = 'N'
where Frequency_code = 40;

Update Frequency
Set Description = '  9 months prior to expiration date',
Active_flag = 'N'
where Frequency_code = 23;

Update Frequency
Set Description = ' 15 days after each quarter'
where Frequency_code =56 ;

Update Frequency
Set Description = ' 15 days after expiration'
where Frequency_code =58 ;

Update Frequency
Set Description = ' 30 days after each quarter'
where Frequency_code = 62;

Update Frequency
Set Description = ' 30 days after each semi-annual'
where Frequency_code =61 ;

Update Frequency
Set Description = ' 30 days after annual anniversary'
where Frequency_code = 32;

Update Frequency
Set Description = ' 30 days after award effective date'
where Frequency_code =38 ;

Update Frequency
Set Description = ' 30 days after effective date'
where Frequency_code =27 ;

Update Frequency
Set Description = ' 30 days after expiration'
where Frequency_code = 10;

Update Frequency
Set Description = ' 30 days prior to expiration date'
where Frequency_code =15 ;

Update Frequency
Set Description = ' 45 days after expiration'
where Frequency_code =33 ;

Update Frequency
Set Description = ' 45 days prior to expiration'
where Frequency_code =36 ;

Update Frequency
Set Description = ' 60 days after annual anniversary'
where Frequency_code = 31;

Update Frequency
Set Description = ' 60 days after effective date'
where Frequency_code =45 ;

Update Frequency
Set Description = ' 60 days after expiration'
where Frequency_code =11 ;

Update Frequency
Set Description = ' 60 days prior to anniversary date'
where Frequency_code =59 ;

Update Frequency
Set Description = ' 60 days prior to expiration date'
where Frequency_code = 16;

Update Frequency
Set Description = ' 75 days after expiration'
where Frequency_code = 43;

Update Frequency
Set Description = ' 75 days prior to expiration date'
where Frequency_code = 37;

Update Frequency
Set Description = ' 90 days after effective date'
where Frequency_code = 44;

Update Frequency
Set Description = ' 90 days after expiration'
where Frequency_code =12 ;

Update Frequency
Set Description = ' 90 days prior to anniversaries'
where Frequency_code = 55;

Update Frequency
Set Description = ' 90 days prior to expiration date'
where Frequency_code =17 ;

*/

INSERT DISTRIBUTION(VER_NBR, OSP_DISTRIBUTION_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID, ACTIVE_FLAG)
VALUES(1,5,	'Not Applicable', NOW(), 'admin',	UUID(), 'Y');

UPDATE award_report_terms
SET OSP_DISTRIBUTION_CODE = 5
WHERE OSP_DISTRIBUTION_CODE < 5;

UPDATE award_template_report_terms
SET OSP_DISTRIBUTION_CODE = 5
WHERE OSP_DISTRIBUTION_CODE < 5;

DELETE FROM DISTRIBUTION 
WHERE OSP_DISTRIBUTION_CODE < 5;

Truncate Table valid_class_report_freq;

select * from valid_class_report_freq;

INSERT valid_class_report_freq(VALID_CLASS_REPORT_FREQ_ID, REPORT_CLASS_CODE, REPORT_CODE, FREQUENCY_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
VALUES 
-- Financial
(100,	110	, 100,	56	, NOW(),	'admin',	1, UUID()),  --  Financial Report, 15 Days After Each Quarter
(101,	110	, 100,	32	, NOW(),	'admin',	1, UUID()),  --  Financial Report, 30 days after annual anniversary
(102,	110	, 100,	62	, NOW(),	'admin',	1, UUID()),  --  Financial Report, 30 Days After Each Quarter
(103,	110	, 100,	61	, NOW(),	'admin',	1, UUID()),  --  Financial Report, 30 Days After Each Semi-annual
(104,	110	, 100,	31	, NOW(),	'admin',	1, UUID()),  --  Financial Report, 60 days after annual anniversary
(105,	110	, 100,	55	, NOW(),	'admin',	1, UUID()),  --  Financial Report, 90 days prior to anniversaries
(106,	110	, 100,	49	, NOW(),	'admin',	1, UUID()),  --  Financial Report, Annual
(108,	110	, 100,	50	, NOW(),	'admin',	1, UUID()),  --  Financial Report, Annual - one month in advance
(109,	110	, 100,	9	, NOW(),	'admin',	1, UUID()),  --  Financial Report, Annual - two months in advance
(110,	110	, 100,	2	, NOW(),	'admin',	1, UUID()),  --  Financial Report, Bi-monthly
(111,	110	, 100,	3	, NOW(),	'admin',	1, UUID()),  --  Financial Report, Monthly
(112,	110 , 100,  7	, NOW(),	'admin',	1, UUID()),  --  Financial Report, Quarterly
(115,	110	, 100,	6	, NOW(),	'admin',	1, UUID()),  --  Financial Report, Semi-annual
(116,	110	, 100,	52	, NOW(),	'admin',	1, UUID()),  --  Financial Report, Semi-annual - one month in advance
(200,	110	, 110,	35	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final , 120 days prior to expiration
(201,	110	, 110,	58	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final , 15 days after expiration
(202,	110	, 110,	38	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final , 30 days after award effective date
(203,	110	, 110,	27	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final , 30 days after effective date
(204,	110	, 110,	10	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final , 30 days after expiration
(205,	110	, 110,	15	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final , 30 days prior to expiration date
(206,	110	, 110,	33	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final , 45 days after expiration
(207,	110	, 110,	36	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final , 45 days prior to expiration
(208,	110	, 110,	39	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final , 6 months after award effective date
(209,	110	, 110,	30	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final , 6 months after expiration date
(210,	110	, 110,	20	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final , 6 months prior to expiration date
(211,	110	, 110,	45	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final , 60 days after effective date
(212,	110	, 110,	11	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final , 60 days after expiration
(213,	110	, 110,	59	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final , 60 days prior to anniversary date
(214,	110	, 110,	16	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final , 60 days prior to expiration date
(215,	110	, 110,	44	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final , 90 days after effective date
(216,	110	, 110,	12	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final , 90 days after expiration
(217,	110	, 110,	17	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final , 90 days prior to expiration date
(218,	110	, 110,	14	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final , As required
(219,	110	, 110,	13	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final , At expiration
(220,	110	, 110,	5	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final, One in advance
(300,	110	, 120,	56	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)
(301,	110	, 120,	32	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)
(302,	110	, 120,	62	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)
(303,	110	, 120,	61	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)
(304,	110	, 120,	31	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)
(305,	110	, 120,	55	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)
(306,	110	, 120,	49	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)
(308,	110	, 120,	50	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)
(309,	110	, 120,	9	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)
(310,	110	, 120,	2	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)
(311,	110	, 120,	3	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)
(312,	110 , 120,  7	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)
(315,	110	, 120,	6	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)
(316,	110	, 120,	52	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)
(400,	110	, 130,	35	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final , 120 days prior to expiration
(401,	110	, 130,	58	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final , 15 days after expiration
(402,	110	, 130,	38	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final , 30 days after award effective date
(403,	110	, 130,	27	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final , 30 days after effective date
(404,	110	, 130,	10	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final , 30 days after expiration
(405,	110	, 130,	15	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final , 30 days prior to expiration date
(406,	110	, 130,	33	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final , 45 days after expiration
(407,	110	, 130,	36	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final , 45 days prior to expiration
(408,	110	, 130,	39	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final, 6 months after award effective date
(409,	110	, 130,	30	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final , 6 months after expiration date
(410,	110	, 130,	20	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final , 6 months prior to expiration date
(411,	110	, 130,	45	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final , 60 days after effective date
(412,	110	, 130,	11	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final , 60 days after expiration
(413,	110	, 130,	59	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final , 60 days prior to anniversary date
(414,	110	, 130,	16	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final , 60 days prior to expiration date
(415,	110	, 130,	44	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final , 90 days after effective date
(416,	110	, 130,	12	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final , 90 days after expiration
(417,	110	, 130,	17	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final , 90 days prior to expiration date
(418,	110	, 130,	14	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final , As required
(419,	110	, 130,	13	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final , At expiration
(420,	110	, 130,	5	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final, One in advance
(500,	110	, 140,	56	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M)
(501,	110	, 140,	32	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M)
(502,	110	, 140,	62	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M)
(503,	110	, 140,	61	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M)
(504,	110	, 140,	31	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M)
(505,	110	, 140,	55	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M)
(506,	110	, 140,	49	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M)
(508,	110	, 140,	50	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M)
(509,	110	, 140,	9	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M)
(510,	110	, 140,	2	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M)
(511,	110	, 140,	3	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M)
(512,	110 , 140,  7	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M)
(515,	110	, 140,	6	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M)
(516,	110	, 140,	52	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M)

-- Payments and Invoices
(600,	150	, 150,	56	, NOW(),	'admin',	1, UUID()),  --  Invoice
(601,	150	, 150,	32	, NOW(),	'admin',	1, UUID()),  --  Invoice
(602,	150	, 150,	62	, NOW(),	'admin',	1, UUID()),  --  Invoice
(603,	150	, 150,	61	, NOW(),	'admin',	1, UUID()),  --  Invoice
(604,	150	, 150,	31	, NOW(),	'admin',	1, UUID()),  --  Invoice
(605,	150	, 150,	55	, NOW(),	'admin',	1, UUID()),  --  Invoice
(606,	150	, 150,	49	, NOW(),	'admin',	1, UUID()),  --  Invoice
(608,	150	, 150,	50	, NOW(),	'admin',	1, UUID()),  --  Invoice
(609,	150	, 150,	9	, NOW(),	'admin',	1, UUID()),  --  Invoice
(610,	150	, 150,	2	, NOW(),	'admin',	1, UUID()),  --  Invoice
(611,	150	, 150,	3	, NOW(),	'admin',	1, UUID()),  --  Invoice
(612,	150 , 150,  7	, NOW(),	'admin',	1, UUID()),  --  Invoice
(615,	150	, 150,	6	, NOW(),	'admin',	1, UUID()),  --  Invoice
(616,	150	, 150,	52	, NOW(),	'admin',	1, UUID()),  --  Invoice
(700,	150	, 160,	35	, NOW(),	'admin',	1, UUID()),  --  Invoice - Final  , 120 days prior to expiration
(701,	150	, 160,	58	, NOW(),	'admin',	1, UUID()),  --  Invoice - Final  , 15 days after expiration
(702,	150	, 160,	38	, NOW(),	'admin',	1, UUID()),  --  Invoice - Final  , 30 days after award effective date
(703,	150	, 160,	27	, NOW(),	'admin',	1, UUID()),  --  Invoice - Final  , 30 days after effective date
(704,	150	, 160,	10	, NOW(),	'admin',	1, UUID()),  --  Invoice - Final  , 30 days after expiration
(705,	150	, 160,	15	, NOW(),	'admin',	1, UUID()),  --  Invoice - Final  , 30 days prior to expiration date
(706,	150	, 160,	33	, NOW(),	'admin',	1, UUID()),  --  Invoice - Final  , 45 days after expiration
(707,	150	, 160,	36	, NOW(),	'admin',	1, UUID()),  --  Invoice - Final  , 45 days prior to expiration
(708,	150	, 160,	39	, NOW(),	'admin',	1, UUID()),  --  Invoice - Final , 6 months after award effective date
(709,	150	, 160,	30	, NOW(),	'admin',	1, UUID()),  --  Invoice - Final  , 6 months after expiration date
(710,	150	, 160,	20	, NOW(),	'admin',	1, UUID()),  --  Invoice - Final  , 6 months prior to expiration date
(711,	150	, 160,	45	, NOW(),	'admin',	1, UUID()),  --  Invoice - Final  , 60 days after effective date
(712,	150	, 160,	11	, NOW(),	'admin',	1, UUID()),  --  Invoice - Final  , 60 days after expiration
(713,	150	, 160,	59	, NOW(),	'admin',	1, UUID()),  --  Invoice - Final  , 60 days prior to anniversary date
(714,	150	, 160,	16	, NOW(),	'admin',	1, UUID()),  --  Invoice - Final  , 60 days prior to expiration date
(715,	150	, 160,	44	, NOW(),	'admin',	1, UUID()),  --  Invoice - Final  , 90 days after effective date
(716,	150	, 160,	12	, NOW(),	'admin',	1, UUID()),  --  Invoice - Final  , 90 days after expiration
(717,	150	, 160,	17	, NOW(),	'admin',	1, UUID()),  --  Invoice - Final  , 90 days prior to expiration date
(718,	150	, 160,	14	, NOW(),	'admin',	1, UUID()),  --  Invoice - Final  , As required
(719,	150	, 160,	13	, NOW(),	'admin',	1, UUID()),  --  Invoice - Final  , At expiration
(720,	150	, 160,	5	, NOW(),	'admin',	1, UUID()),  --  Invoice - Final , One in advance
(800,	150	, 170,	56	, NOW(),	'admin',	1, UUID()),  -- Invoice with Supporting Documentation
(801,	150	, 170,	32	, NOW(),	'admin',	1, UUID()),  -- Invoice with Supporting Documentation
(802,	150	, 170,	62	, NOW(),	'admin',	1, UUID()),  -- Invoice with Supporting Documentation
(803,	150	, 170,	61	, NOW(),	'admin',	1, UUID()),  -- Invoice with Supporting Documentation
(804,	150	, 170,	31	, NOW(),	'admin',	1, UUID()),  -- Invoice with Supporting Documentation
(805,	150	, 170,	55	, NOW(),	'admin',	1, UUID()),  -- Invoice with Supporting Documentation
(806,	150	, 170,	49	, NOW(),	'admin',	1, UUID()),  -- Invoice with Supporting Documentation
(808,	150	, 170,	50	, NOW(),	'admin',	1, UUID()),  -- Invoice with Supporting Documentation
(809,	150	, 170,	9	, NOW(),	'admin',	1, UUID()),  -- Invoice with Supporting Documentation
(810,	150	, 170,	2	, NOW(),	'admin',	1, UUID()),  -- Invoice with Supporting Documentation
(811,	150	, 170,	3	, NOW(),	'admin',	1, UUID()),  -- Invoice with Supporting Documentation
(812,	150 , 170,  7	, NOW(),	'admin',	1, UUID()),  -- Invoice with Supporting Documentation
(815,	150	, 170,	6	, NOW(),	'admin',	1, UUID()),  -- Invoice with Supporting Documentation
(816,	150	, 170,	52	, NOW(),	'admin',	1, UUID()),  -- Invoice with Supporting Documentation
(900,	150	, 180,	35	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final   , 120 days prior to expiration
(901,	150	, 180,	58	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final   , 15 days after expiration
(902,	150	, 180,	38	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final   , 30 days after award effective date
(903,	150	, 180,	27	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final   , 30 days after effective date
(904,	150	, 180,	10	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final   , 30 days after expiration
(905,	150	, 180,	15	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final   , 30 days prior to expiration date
(906,	150	, 180,	33	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final   , 45 days after expiration
(907,	150	, 180,	36	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final   , 45 days prior to expiration
(908,	150	, 180,	39	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final  , 6 months after award effective date
(909,	150	, 180,	30	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final   , 6 months after expiration date
(910,	150	, 180,	20	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final   , 6 months prior to expiration date
(911,	150	, 180,	45	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final   , 60 days after effective date
(912,	150	, 180,	11	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final   , 60 days after expiration
(913,	150	, 180,	59	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final   , 60 days prior to anniversary date
(914,	150	, 180,	16	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final   , 60 days prior to expiration date
(915,	150	, 180,	44	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final   , 90 days after effective date
(916,	150	, 180,	12	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final   , 90 days after expiration
(917,	150	, 180,	17	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final   , 90 days prior to expiration date
(918,	150	, 180,	14	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final   , As required
(919,	150	, 180,	13	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final   , At expiration
(920,	150	, 180,	5	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final  , One in advance
(1000,	150	, 190,	56	, NOW(),	'admin',	1, UUID()),  -- Invoice-Signature 
(1001,	150	, 190,	32	, NOW(),	'admin',	1, UUID()),  -- Invoice-Signature 
(1002,	150	, 190,	62	, NOW(),	'admin',	1, UUID()),  -- Invoice-Signature 
(1003,	150	, 190,	61	, NOW(),	'admin',	1, UUID()),  -- Invoice-Signature 
(1004,	150	, 190,	31	, NOW(),	'admin',	1, UUID()),  -- Invoice-Signature 
(1005,	150	, 190,	55	, NOW(),	'admin',	1, UUID()),  -- Invoice-Signature 
(1006,	150	, 190,	49	, NOW(),	'admin',	1, UUID()),  -- Invoice-Signature 
(1008,	150	, 190,	50	, NOW(),	'admin',	1, UUID()),  -- Invoice-Signature 
(1009,	150	, 190,	9	, NOW(),	'admin',	1, UUID()),  -- Invoice-Signature 
(1010,	150	, 190,	2	, NOW(),	'admin',	1, UUID()),  -- Invoice-Signature 
(1011,	150	, 190,	3	, NOW(),	'admin',	1, UUID()),  -- Invoice-Signature 
(1012,	150 , 190,  7	, NOW(),	'admin',	1, UUID()),  -- Invoice-Signature 
(1015,	150	, 190,	6	, NOW(),	'admin',	1, UUID()),  -- Invoice-Signature 
(1016,	150	, 190,	52	, NOW(),	'admin',	1, UUID()),  -- Invoice-Signature 
(1100,	150	, 200,	35	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature Final   , 120 days prior to expiration
(1101,	150	, 200,	58	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature Final   , 15 days after expiration
(1102,	150	, 200,	38	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature Final   , 30 days after award effective date
(1103,	150	, 200,	27	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature Final   , 30 days after effective date
(1104,	150	, 200,	10	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature Final   , 30 days after expiration
(1105,	150	, 200,	15	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature Final   , 30 days prior to expiration date
(1106,	150	, 200,	33	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature Final   , 45 days after expiration
(1107,	150	, 200,	36	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature Final   , 45 days prior to expiration
(1108,	150	, 200,	39	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature Final  , 6 months after award effective date
(1109,	150	, 200,	30	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature Final   , 6 months after expiration date
(1110,	150	, 200,	20	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature Final   , 6 months prior to expiration date
(1111,	150	, 200,	45	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature Final   , 60 days after effective date
(1112,	150	, 200,	11	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature Final   , 60 days after expiration
(1113,	150	, 200,	59	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature Final   , 60 days prior to anniversary date
(1114,	150	, 200,	16	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature Final   , 60 days prior to expiration date
(1115,	150	, 200,	44	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature Final   , 90 days after effective date
(1116,	150	, 200,	12	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature Final   , 90 days after expiration
(1117,	150	, 200,	17	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature Final   , 90 days prior to expiration date
(1118,	150	, 200,	14	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature Final   , As required
(1119,	150	, 200,	13	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature Final   , At expiration
(1120,	150	, 200,	5	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature Final  , One in advance
(1200,	150	, 210,	56	, NOW(),	'admin',	1, UUID()),  -- Invoice-Signature with Supporting Documentation
(1201,	150	, 210,	32	, NOW(),	'admin',	1, UUID()),  -- Invoice-Signature with Supporting Documentation
(1202,	150	, 210,	62	, NOW(),	'admin',	1, UUID()),  -- Invoice-Signature with Supporting Documentation
(1203,	150	, 210,	61	, NOW(),	'admin',	1, UUID()),  -- Invoice-Signature with Supporting Documentation
(1204,	150	, 210,	31	, NOW(),	'admin',	1, UUID()),  -- Invoice-Signature with Supporting Documentation
(1205,	150	, 210,	55	, NOW(),	'admin',	1, UUID()),  -- Invoice-Signature with Supporting Documentation
(1206,	150	, 210,	49	, NOW(),	'admin',	1, UUID()),  -- Invoice-Signature with Supporting Documentation
(1208,	150	, 210,	50	, NOW(),	'admin',	1, UUID()),  -- Invoice-Signature with Supporting Documentation
(1209,	150	, 210,	9	, NOW(),	'admin',	1, UUID()),  -- Invoice-Signature with Supporting Documentation
(1210,	150	, 210,	2	, NOW(),	'admin',	1, UUID()),  -- Invoice-Signature with Supporting Documentation
(1211,	150	, 210,	3	, NOW(),	'admin',	1, UUID()),  -- Invoice-Signature with Supporting Documentation
(1212,	150 , 210,  7	, NOW(),	'admin',	1, UUID()),  -- Invoice-Signature with Supporting Documentation 
(1215,	150	, 210,	6	, NOW(),	'admin',	1, UUID()),  -- Invoice-Signature with Supporting Documentation
(1216,	150	, 210,	52	, NOW(),	'admin',	1, UUID()),  -- Invoice-Signature with Supporting Documentation
(1300,	150	, 220,	35	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation-Final   , 120 days prior to expiration
(1301,	150	, 220,	58	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation-Final   , 15 days after expiration
(1302,	150	, 220,	38	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation-Final   , 30 days after award effective date
(1303,	150	, 220,	27	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation-Final   , 30 days after effective date
(1304,	150	, 220,	10	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation-Final   , 30 days after expiration
(1305,	150	, 220,	15	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation-Final   , 30 days prior to expiration date
(1306,	150	, 220,	33	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation-Final   , 45 days after expiration
(1307,	150	, 220,	36	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation-Final   , 45 days prior to expiration
(1308,	150	, 220,	39	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation-Final  , 6 months after award effective date
(1309,	150	, 220,	30	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation-Final   , 6 months after expiration date
(1310,	150	, 220,	20	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation-Final   , 6 months prior to expiration date
(1311,	150	, 220,	45	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation-Final   , 60 days after effective date
(1312,	150	, 220,	11	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation-Final   , 60 days after expiration
(1313,	150	, 220,	59	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation-Final   , 60 days prior to anniversary date
(1314,	150	, 220,	16	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation-Final   , 60 days prior to expiration date
(1315,	150	, 220,	44	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation-Final   , 90 days after effective date
(1316,	150	, 220,	12	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation-Final   , 90 days after expiration
(1317,	150	, 220,	17	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation-Final   , 90 days prior to expiration date
(1318,	150	, 220,	14	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation-Final   , As required
(1319,	150	, 220,	13	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation-Final   , At expiration
(1320,	150	, 220,	5	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation-Final  , One in advance
(1400,	150	, 230,	56	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form, 15 Days After Each Quarter
(1401,	150	, 230,	32	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form, 30 days after annual anniversary
(1402,	150	, 230,	62	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form, 30 Days After Each Quarter
(1403,	150	, 230,	61	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form, 30 Days After Each Semi-annual
(1404,	150	, 230,	31	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form, 60 days after annual anniversary
(1405,	150	, 230,	55	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form, 90 days prior to anniversaries
(1406,	150	, 230,	49	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form, Annual
(1408,	150	, 230,	50	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form, Annual - one month in advance
(1409,	150	, 230,	9	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form, Annual - two months in advance
(1410,	150	, 230,	2	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form, Bi-monthly
(1411,	150	, 230,	3	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form, Monthly
(1412,	150 , 230,  7	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form, Quarterly
(1415,	150	, 230,	6	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form, Semi-annual
(1416,	150	, 230,	52	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form, Semi-annual - one month in advance
(1500,	150	, 240,	35	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form-Final   , 120 days prior to expiration
(1501,	150	, 240,	58	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form-Final   , 15 days after expiration
(1502,	150	, 240,	38	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form-Final   , 30 days after award effective date
(1503,	150	, 240,	27	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form-Final   , 30 days after effective date
(1504,	150	, 240,	10	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form-Final   , 30 days after expiration
(1505,	150	, 240,	15	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form-Final   , 30 days prior to expiration date
(1506,	150	, 240,	33	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form-Final   , 45 days after expiration
(1507,	150	, 240,	36	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form-Final   , 45 days prior to expiration
(1508,	150	, 240,	39	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form-Final  , 6 months after award effective date
(1509,	150	, 240,	30	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form-Final   , 6 months after expiration date
(1510,	150	, 240,	20	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form-Final   , 6 months prior to expiration date
(1511,	150	, 240,	45	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form-Final   , 60 days after effective date
(1512,	150	, 240,	11	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form-Final   , 60 days after expiration
(1513,	150	, 240,	59	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form-Final   , 60 days prior to anniversary date
(1514,	150	, 240,	16	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form-Final   , 60 days prior to expiration date
(1515,	150	, 240,	44	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form-Final   , 90 days after effective date
(1516,	150	, 240,	12	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form-Final   , 90 days after expiration
(1517,	150	, 240,	17	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form-Final   , 90 days prior to expiration date
(1518,	150	, 240,	14	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form-Final   , As required
(1519,	150	, 240,	13	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form-Final   , At expiration
(1520,	150	, 240,	5	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form-Final  , One in advance
(1600,	150	, 250,	56	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment, 15 Days After Each Quarter
(1601,	150	, 250,	32	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment, 30 days after annual anniversary
(1602,	150	, 250,	62	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment, 30 Days After Each Quarter
(1603,	150	, 250,	61	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment, 30 Days After Each Semi-annual
(1604,	150	, 250,	31	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment, 60 days after annual anniversary
(1605,	150	, 250,	55	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment, 90 days prior to anniversaries
(1606,	150	, 250,	49	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment, Annual
(1608,	150	, 250,	50	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment, Annual - one month in advance
(1609,	150	, 250,	9	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment, Annual - two months in advance
(1610,	150	, 250,	2	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment, Bi-monthly
(1611,	150	, 250,	3	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment, Monthly
(1612,	150 , 250,  7	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment, Quarterly
(1615,	150	, 250,	6	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment, Semi-annual
(1616,	150	, 250,	52	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment, Semi-annual - one month in advance
(1700,	150	, 260,	56	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034), 15 Days After Each Quarter
(1701,	150	, 260,	32	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034), 30 days after annual anniversary
(1702,	150	, 260,	62	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034), 30 Days After Each Quarter
(1703,	150	, 260,	61	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034), 30 Days After Each Semi-annual
(1704,	150	, 260,	31	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034), 60 days after annual anniversary
(1705,	150	, 260,	55	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034), 90 days prior to anniversaries
(1706,	150	, 260,	49	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034), Annual
(1708,	150	, 260,	50	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034), Annual - one month in advance
(1709,	150	, 260,	9	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034), Annual - two months in advance
(1710,	150	, 260,	2	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034), Bi-monthly
(1711,	150	, 260,	3	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034), Monthly
(1712,	150 , 260,  7	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034), Quarterly
(1715,	150	, 260,	6	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034), Semi-annual
(1716,	150	, 260,	52	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034), Semi-annual - one month in advance
(1800,	150	, 270,	56	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035), 15 Days After Each Quarter
(1801,	150	, 270,	32	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035), 30 days after annual anniversary
(1802,	150	, 270,	62	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035), 30 Days After Each Quarter
(1803,	150	, 270,	61	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035), 30 Days After Each Semi-annual
(1804,	150	, 270,	31	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035), 60 days after annual anniversary
(1805,	150	, 270,	55	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035), 90 days prior to anniversaries
(1806,	150	, 270,	49	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035), Annual
(1808,	150	, 270,	50	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035), Annual - one month in advance
(1809,	150	, 270,	9	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035), Annual - two months in advance
(1810,	150	, 270,	2	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035), Bi-monthly
(1811,	150	, 270,	3	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035), Monthly
(1812,	150 , 270,  7	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035), Quarterly
(1815,	150	, 270,	6	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035), Semi-annual
(1816,	150	, 270,	52	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035), Semi-annual - one month in advance
(1900,	150	, 280,	56	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270), 15 Days After Each Quarter
(1901,	150	, 280,	32	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270), 30 days after annual anniversary
(1902,	150	, 280,	62	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270), 30 Days After Each Quarter
(1903,	150	, 280,	61	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270), 30 Days After Each Semi-annual
(1904,	150	, 280,	31	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270), 60 days after annual anniversary
(1905,	150	, 280,	55	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270), 90 days prior to anniversaries
(1906,	150	, 280,	49	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270), Annual
(1908,	150	, 280,	50	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270), Annual - one month in advance
(1909,	150	, 280,	9	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270), Annual - two months in advance
(1910,	150	, 280,	2	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270), Bi-monthly
(1911,	150	, 280,	3	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270), Monthly
(1912,	150 , 280,  7	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270), Quarterly
(1915,	150	, 280,	6	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270), Semi-annual
(1916,	150	, 280,	52	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270), Semi-annual - one month in advance
(2000,	150	, 290,	35	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270)-Final   , 120 days prior to expiration
(2001,	150	, 290,	58	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270)-Final   , 15 days after expiration
(2002,	150	, 290,	38	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270)-Final   , 30 days after award effective date
(2003,	150	, 290,	27	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270)-Final   , 30 days after effective date
(2004,	150	, 290,	10	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270)-Final   , 30 days after expiration
(2005,	150	, 290,	15	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270)-Final   , 30 days prior to expiration date
(2006,	150	, 290,	33	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270)-Final   , 45 days after expiration
(2007,	150	, 290,	36	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270)-Final   , 45 days prior to expiration
(2008,	150	, 290,	39	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270)-Final   , 6 months after award effective date
(2009,	150	, 290,	30	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270)-Final   , 6 months after expiration date
(2010,	150	, 290,	20	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270)-Final   , 6 months prior to expiration date
(2011,	150	, 290,	45	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270)-Final   , 60 days after effective date
(2012,	150	, 290,	11	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270)-Final   , 60 days after expiration
(2013,	150	, 290,	59	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270)-Final   , 60 days prior to anniversary date
(2014,	150	, 290,	16	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270)-Final   , 60 days prior to expiration date
(2015,	150	, 290,	44	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270)-Final   , 90 days after effective date
(2016,	150	, 290,	12	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270)-Final   , 90 days after expiration
(2017,	150	, 290,	17	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270)-Final   , 90 days prior to expiration date
(2018,	150	, 290,	14	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270)-Final   , As required
(2019,	150	, 290,	13	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270)-Final   , At expiration
(2020,	150	, 290,	5	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270)-Final  , One in advance

-- property
(2100,	170	, 300,	56	, NOW(),	'admin',	1, UUID()),  --  Property Report, 15 Days After Each Quarter
(2101,	170	, 300,	32	, NOW(),	'admin',	1, UUID()),  --  Property Report, 30 days after annual anniversary
(2102,	170	, 300,	62	, NOW(),	'admin',	1, UUID()),  --  Property Report, 30 Days After Each Quarter
(2103,	170	, 300,	61	, NOW(),	'admin',	1, UUID()),  --  Property Report, 30 Days After Each Semi-annual
(2104,	170	, 300,	31	, NOW(),	'admin',	1, UUID()),  --  Property Report, 60 days after annual anniversary
(2105,	170	, 300,	55	, NOW(),	'admin',	1, UUID()),  --  Property Report, 90 days prior to anniversaries
(2106,	170	, 300,	49	, NOW(),	'admin',	1, UUID()),  --  Property Report, Annual
(2108,	170	, 300,	50	, NOW(),	'admin',	1, UUID()),  --  Property Report, Annual - one month in advance
(2109,	170	, 300,	9	, NOW(),	'admin',	1, UUID()),  --  Property Report, Annual - two months in advance
(2110,	170	, 300,	2	, NOW(),	'admin',	1, UUID()),  --  Property Report, Bi-monthly
(2111,	170	, 300,	3	, NOW(),	'admin',	1, UUID()),  --  Property Report, Monthly
(2112,	170 , 300,  7	, NOW(),	'admin',	1, UUID()),  --  Property Report, Quarterly
(2115,	170	, 300,	6	, NOW(),	'admin',	1, UUID()),  --  Property Report, Semi-annual
(2116,	170	, 300,	52	, NOW(),	'admin',	1, UUID()),  --  Property Report, Semi-annual - one month in advance
(2200,	170	, 310,	35	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final, 120 days prior to expiration
(2201,	170	, 310,	58	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final, 15 days after expiration
(2202,	170	, 310,	38	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final, 30 days after award effective date
(2203,	170	, 310,	27	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final, 30 days after effective date
(2204,	170	, 310,	10	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final, 30 days after expiration
(2205,	170	, 310,	15	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final, 30 days prior to expiration date
(2206,	170	, 310,	33	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final, 45 days after expiration
(2207,	170	, 310,	36	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final, 45 days prior to expiration
(2208,	170	, 310,	39	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final, 6 months after award effective date
(2209,	170	, 310,	30	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final, 6 months after expiration date
(2210,	170	, 310,	20	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final, 6 months prior to expiration date
(2211,	170	, 310,	45	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final, 60 days after effective date
(2212,	170	, 310,	11	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final, 60 days after expiration
(2213,	170	, 310,	59	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final, 60 days prior to anniversary date
(2214,	170	, 310,	16	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final, 60 days prior to expiration date
(2215,	170	, 310,	44	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final, 90 days after effective date
(2216,	170	, 310,	12	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final, 90 days after expiration
(2217,	170	, 310,	17	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final, 90 days prior to expiration date
(2218,	170	, 310,	14	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final, As required
(2219,	170	, 310,	13	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final, At expiration
(2220,	170	, 310,	5	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final, One in advance
(2300,	170	, 320,	56	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form, 15 Days After Each Quarter
(2301,	170	, 320,	32	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form, 30 days after annual anniversary
(2302,	170	, 320,	62	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form, 30 Days After Each Quarter
(2303,	170	, 320,	61	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form, 30 Days After Each Semi-annual
(2304,	170	, 320,	31	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form, 60 days after annual anniversary
(2305,	170	, 320,	55	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form, 90 days prior to anniversaries
(2306,	170	, 320,	49	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form, Annual
(2308,	170	, 320,	50	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form, Annual - one month in advance
(2309,	170	, 320,	9	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form, Annual - two months in advance
(2310,	170	, 320,	2	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form, Bi-monthly
(2311,	170	, 320,	3	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form, Monthly
(2312,	170 , 320,  7	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form, Quarterly
(2315,	170	, 320,	6	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form, Semi-annual
(2316,	170	, 320,	52	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form, Semi-annual - one month in advance
(2400,	170	, 330,	35	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form Final, 120 days prior to expiration
(2401,	170	, 330,	58	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form Final, 15 days after expiration
(2402,	170	, 330,	38	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form Final, 30 days after award effective date
(2403,	170	, 330,	27	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form Final, 30 days after effective date
(2404,	170	, 330,	10	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form Final, 30 days after expiration
(2405,	170	, 330,	15	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form Final, 30 days prior to expiration date
(2406,	170	, 330,	33	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form Final, 45 days after expiration
(2407,	170	, 330,	36	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form Final, 45 days prior to expiration
(2408,	170	, 330,	39	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form Final, 6 months after award effective date
(2409,	170	, 330,	30	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form Final, 6 months after expiration date
(2410,	170	, 330,	20	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form Final, 6 months prior to expiration date
(2411,	170	, 330,	45	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form Final, 60 days after effective date
(2412,	170	, 330,	11	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form Final, 60 days after expiration
(2413,	170	, 330,	59	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form Final, 60 days prior to anniversary date
(2414,	170	, 330,	16	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form Final, 60 days prior to expiration date
(2415,	170	, 330,	44	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form Final, 90 days after effective date
(2416,	170	, 330,	12	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form Final, 90 days after expiration
(2417,	170	, 330,	17	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form Final, 90 days prior to expiration date
(2418,	170	, 330,	14	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form Final, As required
(2419,	170	, 330,	13	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form Final, At expiration
(2420,	170	, 330,	5	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form Final, One in advance
(2500,	170	, 340,	56	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43), 15 Days After Each Quarter
(2501,	170	, 340,	32	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43), 30 days after annual anniversary
(2502,	170	, 340,	62	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43), 30 Days After Each Quarter
(2503,	170	, 340,	61	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43), 30 Days After Each Semi-annual
(2504,	170	, 340,	31	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43), 60 days after annual anniversary
(2505,	170	, 340,	55	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43), 90 days prior to anniversaries
(2506,	170	, 340,	49	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43), Annual
(2508,	170	, 340,	50	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43), Annual - one month in advance
(2509,	170	, 340,	9	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43), Annual - two months in advance
(2510,	170	, 340,	2	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43), Bi-monthly
(2511,	170	, 340,	3	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43), Monthly
(2512,	170 , 340,  7	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43), Quarterly
(2515,	170	, 340,	6	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43), Semi-annual
(2516,	170	, 340,	52	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43), Semi-annual - one month in advance
(2600,	170	, 350,	35	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428)-Final, 120 days prior to expiration
(2601,	170	, 350,	58	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428)-Final, 15 days after expiration
(2602,	170	, 350,	38	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428)-Final, 30 days after award effective date
(2603,	170	, 350,	27	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428)-Final, 30 days after effective date
(2604,	170	, 350,	10	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428)-Final, 30 days after expiration
(2605,	170	, 350,	15	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428)-Final, 30 days prior to expiration date
(2606,	170	, 350,	33	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428)-Final, 45 days after expiration
(2607,	170	, 350,	36	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428)-Final, 45 days prior to expiration
(2608,	170	, 350,	39	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428)-Final, 6 months after award effective date
(2609,	170	, 350,	30	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428)-Final, 6 months after expiration date
(2610,	170	, 350,	20	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428)-Final, 6 months prior to expiration date
(2611,	170	, 350,	45	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428)-Final, 60 days after effective date
(2612,	170	, 350,	11	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428)-Final, 60 days after expiration
(2613,	170	, 350,	59	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428)-Final, 60 days prior to anniversary date
(2614,	170	, 350,	16	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428)-Final, 60 days prior to expiration date
(2615,	170	, 350,	44	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428)-Final, 90 days after effective date
(2616,	170	, 350,	12	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428)-Final, 90 days after expiration
(2617,	170	, 350,	17	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428)-Final, 90 days prior to expiration date
(2618,	170	, 350,	14	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428)-Final, As required
(2619,	170	, 350,	13	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428)-Final, At expiration
(2620,	170	, 350,	5	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428)-Final, One in advance
(2700,	170	, 360,	56	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018), 15 Days After Each Quarter
(2701,	170	, 360,	32	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018), 30 days after annual anniversary
(2702,	170	, 360,	62	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018), 30 Days After Each Quarter
(2703,	170	, 360,	61	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018), 30 Days After Each Semi-annual
(2704,	170	, 360,	31	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018), 60 days after annual anniversary
(2705,	170	, 360,	55	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018), 90 days prior to anniversaries
(2706,	170	, 360,	49	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018), Annual
(2708,	170	, 360,	50	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018), Annual - one month in advance
(2709,	170	, 360,	9	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018), Annual - two months in advance
(2710,	170	, 360,	2	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018), Bi-monthly
(2711,	170	, 360,	3	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018), Monthly
(2712,	170 , 360,  7	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018), Quarterly
(2715,	170	, 360,	6	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018), Semi-annual
(2716,	170	, 360,	52	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018), Semi-annual - one month in advance
(2800,	170	, 370,	35	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018)-Final, 120 days prior to expiration
(2801,	170	, 370,	58	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018)-Final, 15 days after expiration
(2802,	170	, 370,	38	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018)-Final, 30 days after award effective date
(2803,	170	, 370,	27	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018)-Final, 30 days after effective date
(2804,	170	, 370,	10	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018)-Final, 30 days after expiration
(2805,	170	, 370,	15	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018)-Final, 30 days prior to expiration date
(2806,	170	, 370,	33	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018)-Final, 45 days after expiration
(2807,	170	, 370,	36	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018)-Final, 45 days prior to expiration
(2808,	170	, 370,	39	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018)-Final, 6 months after award effective date
(2809,	170	, 370,	30	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018)-Final, 6 months after expiration date
(2810,	170	, 370,	20	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018)-Final, 6 months prior to expiration date
(2811,	170	, 370,	45	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018)-Final, 60 days after effective date
(2812,	170	, 370,	11	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018)-Final, 60 days after expiration
(2813,	170	, 370,	59	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018)-Final, 60 days prior to anniversary date
(2814,	170	, 370,	16	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018)-Final, 60 days prior to expiration date
(2815,	170	, 370,	44	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018)-Final, 90 days after effective date
(2816,	170	, 370,	12	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018)-Final, 90 days after expiration
(2817,	170	, 370,	17	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018)-Final, 90 days prior to expiration date
(2818,	170	, 370,	14	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018)-Final, As required
(2819,	170	, 370,	13	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018)-Final, At expiration
(2820,	170	, 370,	5	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018)-Final, One in advance
(2900,	170	, 380,	35	, NOW(),	'admin',	1, UUID()),  --  Tangible Personal Property Report-DOE (SF 428-B) Final, 120 days prior to expiration
(2901,	170	, 380,	58	, NOW(),	'admin',	1, UUID()),  --  Tangible Personal Property Report-DOE (SF 428-B) Final, 15 days after expiration
(2902,	170	, 380,	38	, NOW(),	'admin',	1, UUID()),  --  Tangible Personal Property Report-DOE (SF 428-B) Final, 30 days after award effective date
(2903,	170	, 380,	27	, NOW(),	'admin',	1, UUID()),  --  Tangible Personal Property Report-DOE (SF 428-B) Final, 30 days after effective date
(2904,	170	, 380,	10	, NOW(),	'admin',	1, UUID()),  --  Tangible Personal Property Report-DOE (SF 428-B) Final, 30 days after expiration
(2905,	170	, 380,	15	, NOW(),	'admin',	1, UUID()),  --  Tangible Personal Property Report-DOE (SF 428-B) Final, 30 days prior to expiration date
(2906,	170	, 380,	33	, NOW(),	'admin',	1, UUID()),  --  Tangible Personal Property Report-DOE (SF 428-B) Final, 45 days after expiration
(2907,	170	, 380,	36	, NOW(),	'admin',	1, UUID()),  --  Tangible Personal Property Report-DOE (SF 428-B) Final, 45 days prior to expiration
(2908,	170	, 380,	39	, NOW(),	'admin',	1, UUID()),  --  Tangible Personal Property Report-DOE (SF 428-B) Final, 6 months after award effective date
(2909,	170	, 380,	30	, NOW(),	'admin',	1, UUID()),  --  Tangible Personal Property Report-DOE (SF 428-B) Final, 6 months after expiration date
(2910,	170	, 380,	20	, NOW(),	'admin',	1, UUID()),  --  Tangible Personal Property Report-DOE (SF 428-B) Final, 6 months prior to expiration date
(2911,	170	, 380,	45	, NOW(),	'admin',	1, UUID()),  --  Tangible Personal Property Report-DOE (SF 428-B) Final, 60 days after effective date
(2912,	170	, 380,	11	, NOW(),	'admin',	1, UUID()),  --  Tangible Personal Property Report-DOE (SF 428-B) Final, 60 days after expiration
(2913,	170	, 380,	59	, NOW(),	'admin',	1, UUID()),  --  Tangible Personal Property Report-DOE (SF 428-B) Final, 60 days prior to anniversary date
(2914,	170	, 380,	16	, NOW(),	'admin',	1, UUID()),  --  Tangible Personal Property Report-DOE (SF 428-B) Final, 60 days prior to expiration date
(2915,	170	, 380,	44	, NOW(),	'admin',	1, UUID()),  --  Tangible Personal Property Report-DOE (SF 428-B) Final, 90 days after effective date
(2916,	170	, 380,	12	, NOW(),	'admin',	1, UUID()),  --  Tangible Personal Property Report-DOE (SF 428-B) Final, 90 days after expiration
(2917,	170	, 380,	17	, NOW(),	'admin',	1, UUID()),  --  Tangible Personal Property Report-DOE (SF 428-B) Final, 90 days prior to expiration date
(2918,	170	, 380,	14	, NOW(),	'admin',	1, UUID()),  --  Tangible Personal Property Report-DOE (SF 428-B) Final, As required
(2919,	170	, 380,	13	, NOW(),	'admin',	1, UUID()),  --  Tangible Personal Property Report-DOE (SF 428-B) Final, At expiration
(2920,	170	, 380,	5	, NOW(),	'admin',	1, UUID()),  --  Tangible Personal Property Report-DOE (SF 428-B) Final, One in advance

-- Intellectual Property
(3000,	120	, 390,	56	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form, 15 Days After Each Quarter
(3001,	120	, 390,	32	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form, 30 days after annual anniversary
(3002,	120	, 390,	62	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form, 30 Days After Each Quarter
(3003,	120	, 390,	61	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form, 30 Days After Each Semi-annual
(3004,	120	, 390,	31	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form, 60 days after annual anniversary
(3005,	120	, 390,	55	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form, 90 days prior to anniversaries
(3006,	120	, 390,	49	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form, Annual
(3008,	120	, 390,	50	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form, Annual - one month in advance
(3009,	120	, 390,	9	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form, Annual - two months in advance
(3010,	120	, 390,	2	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form, Bi-monthly
(3011,	120	, 390,	3	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form, Monthly
(3012,	120 , 390,  7	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form, Quarterly
(3015,	120	, 390,	6	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form, Semi-annual
(3016,	120	, 390,	52	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form, Semi-annual - one month in advance
(3100,	120	, 400,	35	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form Final, 120 days prior to expiration
(3101,	120	, 400,	58	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form Final, 15 days after expiration
(3102,	120	, 400,	38	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form Final, 30 days after award effective date
(3103,	120	, 400,	27	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form Final, 30 days after effective date
(3104,	120	, 400,	10	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form Final, 30 days after expiration
(3105,	120	, 400,	15	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form Final, 30 days prior to expiration date
(3106,	120	, 400,	33	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form Final, 45 days after expiration
(3107,	120	, 400,	36	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form Final, 45 days prior to expiration
(3108,	120	, 400,	39	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form Final, 6 months after award effective date
(3109,	120	, 400,	30	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form Final, 6 months after expiration date
(3110,	120	, 400,	20	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form Final, 6 months prior to expiration date
(3111,	120	, 400,	45	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form Final, 60 days after effective date
(3112,	120	, 400,	11	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form Final, 60 days after expiration
(3113,	120	, 400,	59	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form Final, 60 days prior to anniversary date
(3114,	120	, 400,	16	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form Final, 60 days prior to expiration date
(3115,	120	, 400,	44	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form Final, 90 days after effective date
(3116,	120	, 400,	12	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form Final, 90 days after expiration
(3117,	120	, 400,	17	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form Final, 90 days prior to expiration date
(3118,	120	, 400,	14	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form Final, As required
(3119,	120	, 400,	13	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form Final, At expiration
(3120,	120	, 400,	5	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form Final, One in advance
(3200,	120	, 410,	56	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, 15 Days After Each Quarter
(3201,	120	, 410,	32	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, 30 days after annual anniversary
(3202,	120	, 410,	62	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, 30 Days After Each Quarter
(3203,	120	, 410,	61	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, 30 Days After Each Semi-annual
(3204,	120	, 410,	31	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, 60 days after annual anniversary
(3205,	120	, 410,	55	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, 90 days prior to anniversaries
(3206,	120	, 410,	49	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Annual
(3208,	120	, 410,	50	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Annual - one month in advance
(3209,	120	, 410,	9	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Annual - two months in advance
(3210,	120	, 410,	2	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Bi-monthly
(3211,	120	, 410,	3	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Monthly
(3212,	120 , 410,  7	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Quarterly
(3215,	120	, 410,	6	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Semi-annual
(3216,	120	, 410,	52	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Semi-annual - one month in advance
(3300,	120	, 420,	35	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report-Final, 120 days prior to expiration
(3301,	120	, 420,	58	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report-Final, 15 days after expiration
(3302,	120	, 420,	38	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report-Final, 30 days after award effective date
(3303,	120	, 420,	27	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report-Final, 30 days after effective date
(3304,	120	, 420,	10	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report-Final, 30 days after expiration
(3305,	120	, 420,	15	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report-Final, 30 days prior to expiration date
(3306,	120	, 420,	33	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report-Final, 45 days after expiration
(3307,	120	, 420,	36	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report-Final, 45 days prior to expiration
(3308,	120	, 420,	39	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report-Final, 6 months after award effective date
(3309,	120	, 420,	30	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report-Final, 6 months after expiration date
(3310,	120	, 420,	20	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report-Final, 6 months prior to expiration date
(3311,	120	, 420,	45	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report-Final, 60 days after effective date
(3312,	120	, 420,	11	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report-Final, 60 days after expiration
(3313,	120	, 420,	59	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report-Final, 60 days prior to anniversary date
(3314,	120	, 420,	16	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report-Final, 60 days prior to expiration date
(3315,	120	, 420,	44	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report-Final, 90 days after effective date
(3316,	120	, 420,	12	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report-Final, 90 days after expiration
(3317,	120	, 420,	17	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report-Final, 90 days prior to expiration date
(3318,	120	, 420,	14	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report-Final, As required
(3319,	120	, 420,	13	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report-Final, At expiration
(3320,	120	, 420,	5	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report-Final, One in advance
(3400,	120	, 430,	35	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), 120 days prior to expiration
(3401,	120	, 430,	58	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), 15 days after expiration
(3402,	120	, 430,	38	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), 30 days after award effective date
(3403,	120	, 430,	27	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), 30 days after effective date
(3404,	120	, 430,	10	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), 30 days after expiration
(3405,	120	, 430,	15	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), 30 days prior to expiration date
(3406,	120	, 430,	33	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), 45 days after expiration
(3407,	120	, 430,	36	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), 45 days prior to expiration
(3408,	120	, 430,	39	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), 6 months after award effective date
(3409,	120	, 430,	30	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), 6 months after expiration date
(3410,	120	, 430,	20	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), 6 months prior to expiration date
(3411,	120	, 430,	45	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), 60 days after effective date
(3412,	120	, 430,	11	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), 60 days after expiration
(3413,	120	, 430,	59	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), 60 days prior to anniversary date
(3414,	120	, 430,	16	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), 60 days prior to expiration date
(3415,	120	, 430,	44	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), 90 days after effective date
(3416,	120	, 430,	12	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), 90 days after expiration
(3417,	120	, 430,	17	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), 90 days prior to expiration date
(3418,	120	, 430,	14	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), As required
(3419,	120	, 430,	13	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), At expiration
(3420,	120	, 430,	5	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), One in advance
(3500,	120	, 440,	56	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, 15 Days After Each Quarter
(3501,	120	, 440,	32	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, 30 days after annual anniversary
(3502,	120	, 440,	62	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, 30 Days After Each Quarter
(3503,	120	, 440,	61	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, 30 Days After Each Semi-annual
(3504,	120	, 440,	31	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, 60 days after annual anniversary
(3505,	120	, 440,	55	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, 90 days prior to anniversaries
(3506,	120	, 440,	49	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, Annual
(3508,	120	, 440,	50	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, Annual - one month in advance
(3509,	120	, 440,	9	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, Annual - two months in advance
(3510,	120	, 440,	2	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, Bi-monthly
(3511,	120	, 440,	3	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, Monthly
(3512,	120 , 440,  7	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, Quarterly
(3515,	120	, 440,	6	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, Semi-annual
(3516,	120	, 440,	52	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, Semi-annual - one month in advance
(3600,	120	, 450,	35	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), 120 days prior to expiration
(3601,	120	, 450,	58	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), 15 days after expiration
(3602,	120	, 450,	38	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), 30 days after award effective date
(3603,	120	, 450,	27	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), 30 days after effective date
(3604,	120	, 450,	10	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), 30 days after expiration
(3605,	120	, 450,	15	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), 30 days prior to expiration date
(3606,	120	, 450,	33	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), 45 days after expiration
(3607,	120	, 450,	36	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), 45 days prior to expiration
(3608,	120	, 450,	39	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), 6 months after award effective date
(3609,	120	, 450,	30	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), 6 months after expiration date
(3610,	120	, 450,	20	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), 6 months prior to expiration date
(3611,	120	, 450,	45	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), 60 days after effective date
(3612,	120	, 450,	11	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), 60 days after expiration
(3613,	120	, 450,	59	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), 60 days prior to anniversary date
(3614,	120	, 450,	16	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), 60 days prior to expiration date
(3615,	120	, 450,	44	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), 90 days after effective date
(3616,	120	, 450,	12	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), 90 days after expiration
(3617,	120	, 450,	17	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), 90 days prior to expiration date
(3618,	120	, 450,	14	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), As required
(3619,	120	, 450,	13	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), At expiration
(3620,	120	, 450,	5	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), One in advance

-- technical management
(3700,	180	, 460,	56	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, 15 Days After Each Quarter
(3701,	180	, 460,	32	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, 30 days after annual anniversary
(3702,	180	, 460,	62	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, 30 Days After Each Quarter
(3703,	180	, 460,	61	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, 30 Days After Each Semi-annual
(3704,	180	, 460,	31	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, 60 days after annual anniversary
(3705,	180	, 460,	55	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, 90 days prior to anniversaries
(3706,	180	, 460,	49	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, Annual
(3708,	180	, 460,	50	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, Annual - one month in advance
(3709,	180	, 460,	9	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, Annual - two months in advance
(3710,	180	, 460,	2	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, Bi-monthly
(3711,	180	, 460,	3	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, Monthly
(3712,	180 , 460,  7	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, Quarterly
(3715,	180	, 460,	6	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, Semi-annual
(3716,	180	, 460,	52	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, Semi-annual - one month in advance
(3800,	180	, 470,	35	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, 120 days prior to expiration
(3801,	180	, 470,	58	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, 15 days after expiration
(3802,	180	, 470,	38	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, 30 days after award effective date
(3803,	180	, 470,	27	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, 30 days after effective date
(3804,	180	, 470,	10	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, 30 days after expiration
(3805,	180	, 470,	15	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, 30 days prior to expiration date
(3806,	180	, 470,	33	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, 45 days after expiration
(3807,	180	, 470,	36	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, 45 days prior to expiration
(3808,	180	, 470,	39	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, 6 months after award effective date
(3809,	180	, 470,	30	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, 6 months after expiration date
(3810,	180	, 470,	20	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, 6 months prior to expiration date
(3811,	180	, 470,	45	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, 60 days after effective date
(3812,	180	, 470,	11	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, 60 days after expiration
(3813,	180	, 470,	59	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, 60 days prior to anniversary date
(3814,	180	, 470,	16	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, 60 days prior to expiration date
(3815,	180	, 470,	44	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, 90 days after effective date
(3816,	180	, 470,	12	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, 90 days after expiration
(3817,	180	, 470,	17	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, 90 days prior to expiration date
(3818,	180	, 470,	14	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, As required
(3819,	180	, 470,	13	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, At expiration
(3820,	180	, 470,	5	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, One in advance
(3900,	180	, 480,	56	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, 15 Days After Each Quarter
(3901,	180	, 480,	32	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, 30 days after annual anniversary
(3902,	180	, 480,	62	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, 30 Days After Each Quarter
(3903,	180	, 480,	61	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, 30 Days After Each Semi-annual
(3904,	180	, 480,	31	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, 60 days after annual anniversary
(3905,	180	, 480,	55	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, 90 days prior to anniversaries
(3906,	180	, 480,	49	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, Annual
(3908,	180	, 480,	50	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, Annual - one month in advance
(3909,	180	, 480,	9	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, Annual - two months in advance
(3910,	180	, 480,	2	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, Bi-monthly
(3911,	180	, 480,	3	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, Monthly
(3912,	180 , 480,  7	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, Quarterly
(3915,	180	, 480,	6	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, Semi-annual
(3916,	180	, 480,	52	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, Semi-annual - one month in advance
(4000,	180	, 490,	35	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, 120 days prior to expiration
(4001,	180	, 490,	58	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, 15 days after expiration
(4002,	180	, 490,	38	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, 30 days after award effective date
(4003,	180	, 490,	27	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, 30 days after effective date
(4004,	180	, 490,	10	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, 30 days after expiration
(4005,	180	, 490,	15	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, 30 days prior to expiration date
(4006,	180	, 490,	33	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, 45 days after expiration
(4007,	180	, 490,	36	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, 45 days prior to expiration
(4008,	180	, 490,	39	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, 6 months after award effective date
(4009,	180	, 490,	30	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, 6 months after expiration date
(4010,	180	, 490,	20	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, 6 months prior to expiration date
(4011,	180	, 490,	45	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, 60 days after effective date
(4012,	180	, 490,	11	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, 60 days after expiration
(4013,	180	, 490,	59	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, 60 days prior to anniversary date
(4014,	180	, 490,	16	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, 60 days prior to expiration date
(4015,	180	, 490,	44	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, 90 days after effective date
(4016,	180	, 490,	12	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, 90 days after expiration
(4017,	180	, 490,	17	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, 90 days prior to expiration date
(4018,	180	, 490,	14	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, As required
(4019,	180	, 490,	13	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, At expiration
(4020,	180	, 490,	5	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, One in advance
(4100,	180	, 500,	56	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, 15 Days After Each Quarter
(4101,	180	, 500,	32	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, 30 days after annual anniversary
(4102,	180	, 500,	62	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, 30 Days After Each Quarter
(4103,	180	, 500,	61	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, 30 Days After Each Semi-annual
(4104,	180	, 500,	31	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, 60 days after annual anniversary
(4105,	180	, 500,	55	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, 90 days prior to anniversaries
(4106,	180	, 500,	49	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, Annual
(4108,	180	, 500,	50	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, Annual - one month in advance
(4109,	180	, 500,	9	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, Annual - two months in advance
(4110,	180	, 500,	2	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, Bi-monthly
(4111,	180	, 500,	3	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, Monthly
(4112,	180 , 500,  7	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, Quarterly
(4115,	180	, 500,	6	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, Semi-annual
(4116,	180	, 500,	52	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, Semi-annual - one month in advance
(4200,	180	, 510,	35	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan Final, 120 days prior to expiration
(4201,	180	, 510,	58	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan Final, 15 days after expiration
(4202,	180	, 510,	38	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan Final, 30 days after award effective date
(4203,	180	, 510,	27	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan Final, 30 days after effective date
(4204,	180	, 510,	10	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan Final, 30 days after expiration
(4205,	180	, 510,	15	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan Final, 30 days prior to expiration date
(4206,	180	, 510,	33	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan Final, 45 days after expiration
(4207,	180	, 510,	36	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan Final, 45 days prior to expiration
(4208,	180	, 510,	39	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan Final, 6 months after award effective date
(4209,	180	, 510,	30	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan Final, 6 months after expiration date
(4210,	180	, 510,	20	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan Final, 6 months prior to expiration date
(4211,	180	, 510,	45	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan Final, 60 days after effective date
(4212,	180	, 510,	11	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan Final, 60 days after expiration
(4213,	180	, 510,	59	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan Final, 60 days prior to anniversary date
(4214,	180	, 510,	16	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan Final, 60 days prior to expiration date
(4215,	180	, 510,	44	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan Final, 90 days after effective date
(4216,	180	, 510,	12	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan Final, 90 days after expiration
(4217,	180	, 510,	17	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan Final, 90 days prior to expiration date
(4218,	180	, 510,	14	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan Final, As required
(4219,	180	, 510,	13	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan Final, At expiration
(4220,	180	, 510,	5	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan Final, One in advance
(4300,	180	, 520,	56	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, 15 Days After Each Quarter
(4301,	180	, 520,	32	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, 30 days after annual anniversary
(4302,	180	, 520,	62	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, 30 Days After Each Quarter
(4303,	180	, 520,	61	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, 30 Days After Each Semi-annual
(4304,	180	, 520,	31	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, 60 days after annual anniversary
(4305,	180	, 520,	55	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, 90 days prior to anniversaries
(4306,	180	, 520,	49	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, Annual
(4307,	180	, 520,	50	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, Annual - one month in advance
(4308,	180	, 520,	9	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, Annual - two months in advance
(4309,	180	, 520,	2	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, Bi-monthly
(4310,	180	, 520,	3	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, Monthly
(4311,	180 , 520,  7	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, Quarterly
(4312,	180	, 520,	6	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, Semi-annual
(4313,	180	, 520,	52	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, Semi-annual - one month in advance
(4400,	180	, 530,	56	, NOW(),	'admin',	1, UUID()),  --  Management Plan, 15 Days After Each Quarter
(4401,	180	, 530,	32	, NOW(),	'admin',	1, UUID()),  --  Management Plan, 30 days after annual anniversary
(4402,	180	, 530,	62	, NOW(),	'admin',	1, UUID()),  --  Management Plan, 30 Days After Each Quarter
(4403,	180	, 530,	61	, NOW(),	'admin',	1, UUID()),  --  Management Plan, 30 Days After Each Semi-annual
(4404,	180	, 530,	31	, NOW(),	'admin',	1, UUID()),  --  Management Plan, 60 days after annual anniversary
(4405,	180	, 530,	55	, NOW(),	'admin',	1, UUID()),  --  Management Plan, 90 days prior to anniversaries
(4406,	180	, 530,	49	, NOW(),	'admin',	1, UUID()),  --  Management Plan, Annual
(4407,	180	, 530,	50	, NOW(),	'admin',	1, UUID()),  --  Management Plan, Annual - one month in advance
(4408,	180	, 530,	9	, NOW(),	'admin',	1, UUID()),  --  Management Plan, Annual - two months in advance
(4409,	180	, 530,	2	, NOW(),	'admin',	1, UUID()),  --  Management Plan, Bi-monthly
(4410,	180	, 530,	3	, NOW(),	'admin',	1, UUID()),  --  Management Plan, Monthly
(4411,	180 , 530,  7	, NOW(),	'admin',	1, UUID()),  --  Management Plan, Quarterly
(4412,	180	, 530,	6	, NOW(),	'admin',	1, UUID()),  --  Management Plan, Semi-annual
(4413,	180	, 530,	52	, NOW(),	'admin',	1, UUID()),  --  Management Plan, Semi-annual - one month in advance
(4500,	180	, 540,	56	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, 15 Days After Each Quarter
(4501,	180	, 540,	32	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, 30 days after annual anniversary
(4502,	180	, 540,	62	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, 30 Days After Each Quarter
(4503,	180	, 540,	61	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, 30 Days After Each Semi-annual
(4504,	180	, 540,	31	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, 60 days after annual anniversary
(4505,	180	, 540,	55	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, 90 days prior to anniversaries
(4506,	180	, 540,	49	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, Annual
(4507,	180	, 540,	50	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, Annual - one month in advance
(4508,	180	, 540,	9	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, Annual - two months in advance
(4509,	180	, 540,	2	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, Bi-monthly
(4510,	180	, 540,	3	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, Monthly
(4511,	180 , 540,  7	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, Quarterly
(4512,	180	, 540,	6	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, Semi-annual
(4513,	180	, 540,	52	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, Semi-annual - one month in advance
(4600,	180	, 550,	56	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, 15 Days After Each Quarter
(4601,	180	, 550,	32	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, 30 days after annual anniversary
(4602,	180	, 550,	62	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, 30 Days After Each Quarter
(4603,	180	, 550,	61	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, 30 Days After Each Semi-annual
(4604,	180	, 550,	31	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, 60 days after annual anniversary
(4605,	180	, 550,	55	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, 90 days prior to anniversaries
(4606,	180	, 550,	49	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, Annual
(4607,	180	, 550,	50	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, Annual - one month in advance
(4608,	180	, 550,	9	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, Annual - two months in advance
(4609,	180	, 550,	2	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, Bi-monthly
(4610,	180	, 550,	3	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, Monthly
(4611,	180 , 550,  7	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, Quarterly
(4612,	180	, 550,	6	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, Semi-annual
(4613,	180	, 550,	52	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, Semi-annual - one month in advance
(4700,	180	, 560,	56	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, 15 Days After Each Quarter
(4701,	180	, 560,	32	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, 30 days after annual anniversary
(4702,	180	, 560,	62	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, 30 Days After Each Quarter
(4703,	180	, 560,	61	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, 30 Days After Each Semi-annual
(4704,	180	, 560,	31	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, 60 days after annual anniversary
(4705,	180	, 560,	55	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, 90 days prior to anniversaries
(4706,	180	, 560,	49	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, Annual
(4707,	180	, 560,	50	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, Annual - one month in advance
(4708,	180	, 560,	9	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, Annual - two months in advance
(4709,	180	, 560,	2	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, Bi-monthly
(4710,	180	, 560,	3	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, Monthly
(4711,	180 , 560,  7	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, Quarterly
(4712,	180	, 560,	6	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, Semi-annual
(4713,	180	, 560,	52	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, Semi-annual - one month in advance
(4800,	180	, 570,	35	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report Final, 120 days prior to expiration
(4801,	180	, 570,	58	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report Final, 15 days after expiration
(4802,	180	, 570,	38	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report Final, 30 days after award effective date
(4803,	180	, 570,	27	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report Final, 30 days after effective date
(4804,	180	, 570,	10	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report Final, 30 days after expiration
(4805,	180	, 570,	15	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report Final, 30 days prior to expiration date
(4806,	180	, 570,	33	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report Final, 45 days after expiration
(4807,	180	, 570,	36	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report Final, 45 days prior to expiration
(4808,	180	, 570,	39	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report Final, 6 months after award effective date
(4809,	180	, 570,	30	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report Final, 6 months after expiration date
(4810,	180	, 570,	20	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report Final, 6 months prior to expiration date
(4811,	180	, 570,	45	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report Final, 60 days after effective date
(4812,	180	, 570,	11	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report Final, 60 days after expiration
(4813,	180	, 570,	59	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report Final, 60 days prior to anniversary date
(4814,	180	, 570,	16	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report Final, 60 days prior to expiration date
(4815,	180	, 570,	44	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report Final, 90 days after effective date
(4816,	180	, 570,	12	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report Final, 90 days after expiration
(4817,	180	, 570,	17	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report Final, 90 days prior to expiration date
(4818,	180	, 570,	14	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report Final, As required
(4819,	180	, 570,	13	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report Final, At expiration
(4820,	180	, 570,	5	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report Final, One in advance
(4900,	180	, 580,	56	, NOW(),	'admin',	1, UUID()),  --  Presentation, 15 Days After Each Quarter
(4901,	180	, 580,	32	, NOW(),	'admin',	1, UUID()),  --  Presentation, 30 days after annual anniversary
(4902,	180	, 580,	62	, NOW(),	'admin',	1, UUID()),  --  Presentation, 30 Days After Each Quarter
(4903,	180	, 580,	61	, NOW(),	'admin',	1, UUID()),  --  Presentation, 30 Days After Each Semi-annual
(4904,	180	, 580,	31	, NOW(),	'admin',	1, UUID()),  --  Presentation, 60 days after annual anniversary
(4905,	180	, 580,	55	, NOW(),	'admin',	1, UUID()),  --  Presentation, 90 days prior to anniversaries
(4906,	180	, 580,	49	, NOW(),	'admin',	1, UUID()),  --  Presentation, Annual
(4907,	180	, 580,	50	, NOW(),	'admin',	1, UUID()),  --  Presentation, Annual - one month in advance
(4908,	180	, 580,	9	, NOW(),	'admin',	1, UUID()),  --  Presentation, Annual - two months in advance
(4909,	180	, 580,	2	, NOW(),	'admin',	1, UUID()),  --  Presentation, Bi-monthly
(4910,	180	, 580,	3	, NOW(),	'admin',	1, UUID()),  --  Presentation, Monthly
(4911,	180 , 580,  7	, NOW(),	'admin',	1, UUID()),  --  Presentation, Quarterly
(4912,	180	, 580,	6	, NOW(),	'admin',	1, UUID()),  --  Presentation, Semi-annual
(4913,	180	, 580,	52	, NOW(),	'admin',	1, UUID()),  --  Presentation, Semi-annual - one month in advance
(5000,	180	, 590,	56	, NOW(),	'admin',	1, UUID()),  --  Proceedings, 15 Days After Each Quarter
(5001,	180	, 590,	32	, NOW(),	'admin',	1, UUID()),  --  Proceedings, 30 days after annual anniversary
(5002,	180	, 590,	62	, NOW(),	'admin',	1, UUID()),  --  Proceedings, 30 Days After Each Quarter
(5003,	180	, 590,	61	, NOW(),	'admin',	1, UUID()),  --  Proceedings, 30 Days After Each Semi-annual
(5004,	180	, 590,	31	, NOW(),	'admin',	1, UUID()),  --  Proceedings, 60 days after annual anniversary
(5005,	180	, 590,	55	, NOW(),	'admin',	1, UUID()),  --  Proceedings, 90 days prior to anniversaries
(5006,	180	, 590,	49	, NOW(),	'admin',	1, UUID()),  --  Proceedings, Annual
(5007,	180	, 590,	50	, NOW(),	'admin',	1, UUID()),  --  Proceedings, Annual - one month in advance
(5008,	180	, 590,	9	, NOW(),	'admin',	1, UUID()),  --  Proceedings, Annual - two months in advance
(5009,	180	, 590,	2	, NOW(),	'admin',	1, UUID()),  --  Proceedings, Bi-monthly
(5010,	180	, 590,	3	, NOW(),	'admin',	1, UUID()),  --  Proceedings, Monthly
(5011,	180 , 590,  7	, NOW(),	'admin',	1, UUID()),  --  Proceedings, Quarterly
(5012,	180	, 590,	6	, NOW(),	'admin',	1, UUID()),  --  Proceedings, Semi-annual
(5013,	180	, 590,	52	, NOW(),	'admin',	1, UUID()),  --  Proceedings, Semi-annual - one month in advance
(5100,	180	, 600,	56	, NOW(),	'admin',	1, UUID()),  --  Publication, 15 Days After Each Quarter
(5101,	180	, 600,	32	, NOW(),	'admin',	1, UUID()),  --  Publication, 30 days after annual anniversary
(5102,	180	, 600,	62	, NOW(),	'admin',	1, UUID()),  --  Publication, 30 Days After Each Quarter
(5103,	180	, 600,	61	, NOW(),	'admin',	1, UUID()),  --  Publication, 30 Days After Each Semi-annual
(5104,	180	, 600,	31	, NOW(),	'admin',	1, UUID()),  --  Publication, 60 days after annual anniversary
(5105,	180	, 600,	55	, NOW(),	'admin',	1, UUID()),  --  Publication, 90 days prior to anniversaries
(5106,	180	, 600,	49	, NOW(),	'admin',	1, UUID()),  --  Publication, Annual
(5107,	180	, 600,	50	, NOW(),	'admin',	1, UUID()),  --  Publication, Annual - one month in advance
(5108,	180	, 600,	9	, NOW(),	'admin',	1, UUID()),  --  Publication, Annual - two months in advance
(5109,	180	, 600,	2	, NOW(),	'admin',	1, UUID()),  --  Publication, Bi-monthly
(5110,	180	, 600,	3	, NOW(),	'admin',	1, UUID()),  --  Publication, Monthly
(5111,	180 , 600,  7	, NOW(),	'admin',	1, UUID()),  --  Publication, Quarterly
(5112,	180	, 600,	6	, NOW(),	'admin',	1, UUID()),  --  Publication, Semi-annual
(5113,	180	, 600,	52	, NOW(),	'admin',	1, UUID()),  --  Publication, Semi-annual - one month in advance
(5200,	180	, 610,	56	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), 15 Days After Each Quarter
(5201,	180	, 610,	32	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), 30 days after annual anniversary
(5202,	180	, 610,	62	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), 30 Days After Each Quarter
(5203,	180	, 610,	61	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), 30 Days After Each Semi-annual
(5204,	180	, 610,	31	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), 60 days after annual anniversary
(5205,	180	, 610,	55	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), 90 days prior to anniversaries
(5206,	180	, 610,	49	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), Annual
(5207,	180	, 610,	50	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), Annual - one month in advance
(5208,	180	, 610,	9	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), Annual - two months in advance
(5209,	180	, 610,	2	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), Bi-monthly
(5210,	180	, 610,	3	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), Monthly
(5211,	180 , 610,  7	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), Quarterly
(5212,	180	, 610,	6	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), Semi-annual
(5213,	180	, 610,	52	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), Semi-annual - one month in advance
(5300,	180	, 620,	56	, NOW(),	'admin',	1, UUID()),  --  Technical Report, 15 Days After Each Quarter
(5301,	180	, 620,	32	, NOW(),	'admin',	1, UUID()),  --  Technical Report, 30 days after annual anniversary
(5302,	180	, 620,	62	, NOW(),	'admin',	1, UUID()),  --  Technical Report, 30 Days After Each Quarter
(5303,	180	, 620,	61	, NOW(),	'admin',	1, UUID()),  --  Technical Report, 30 Days After Each Semi-annual
(5304,	180	, 620,	31	, NOW(),	'admin',	1, UUID()),  --  Technical Report, 60 days after annual anniversary
(5305,	180	, 620,	55	, NOW(),	'admin',	1, UUID()),  --  Technical Report, 90 days prior to anniversaries
(5306,	180	, 620,	49	, NOW(),	'admin',	1, UUID()),  --  Technical Report, Annual
(5307,	180	, 620,	50	, NOW(),	'admin',	1, UUID()),  --  Technical Report, Annual - one month in advance
(5308,	180	, 620,	9	, NOW(),	'admin',	1, UUID()),  --  Technical Report, Annual - two months in advance
(5309,	180	, 620,	2	, NOW(),	'admin',	1, UUID()),  --  Technical Report, Bi-monthly
(5310,	180	, 620,	3	, NOW(),	'admin',	1, UUID()),  --  Technical Report, Monthly
(5311,	180 , 620,  7	, NOW(),	'admin',	1, UUID()),  --  Technical Report, Quarterly
(5312,	180	, 620,	6	, NOW(),	'admin',	1, UUID()),  --  Technical Report, Semi-annual
(5313,	180	, 620,	52	, NOW(),	'admin',	1, UUID()),  --  Technical Report, Semi-annual - one month in advance
(5400,	180	, 630,	35	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, 120 days prior to expiration
(5401,	180	, 630,	58	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, 15 days after expiration
(5402,	180	, 630,	38	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, 30 days after award effective date
(5403,	180	, 630,	27	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, 30 days after effective date
(5404,	180	, 630,	10	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, 30 days after expiration
(5405,	180	, 630,	15	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, 30 days prior to expiration date
(5406,	180	, 630,	33	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, 45 days after expiration
(5407,	180	, 630,	36	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, 45 days prior to expiration
(5408,	180	, 630,	39	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, 6 months after award effective date
(5409,	180	, 630,	30	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, 6 months after expiration date
(5410,	180	, 630,	20	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, 6 months prior to expiration date
(5411,	180	, 630,	45	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, 60 days after effective date
(5412,	180	, 630,	11	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, 60 days after expiration
(5413,	180	, 630,	59	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, 60 days prior to anniversary date
(5414,	180	, 630,	16	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, 60 days prior to expiration date
(5415,	180	, 630,	44	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, 90 days after effective date
(5416,	180	, 630,	12	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, 90 days after expiration
(5417,	180	, 630,	17	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, 90 days prior to expiration date
(5418,	180	, 630,	14	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, As required
(5419,	180	, 630,	13	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, At expiration
(5420,	180	, 630,	5	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, One in advance
(5500,	180	, 640,	56	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, 15 Days After Each Quarter
(5501,	180	, 640,	32	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, 30 days after annual anniversary
(5502,	180	, 640,	62	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, 30 Days After Each Quarter
(5503,	180	, 640,	61	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, 30 Days After Each Semi-annual
(5504,	180	, 640,	31	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, 60 days after annual anniversary
(5505,	180	, 640,	55	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, 90 days prior to anniversaries
(5506,	180	, 640,	49	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, Annual
(5507,	180	, 640,	50	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, Annual - one month in advance
(5508,	180	, 640,	9	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, Annual - two months in advance
(5509,	180	, 640,	2	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, Bi-monthly
(5510,	180	, 640,	3	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, Monthly
(5511,	180 , 640,  7	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, Quarterly
(5512,	180	, 640,	6	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, Semi-annual
(5513,	180	, 640,	52	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, Semi-annual - one month in advance
(5600,	180	, 650,	35	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form Final, 120 days prior to expiration
(5601,	180	, 650,	58	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form Final, 15 days after expiration
(5602,	180	, 650,	38	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form Final, 30 days after award effective date
(5603,	180	, 650,	27	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form Final, 30 days after effective date
(5604,	180	, 650,	10	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form Final, 30 days after expiration
(5605,	180	, 650,	15	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form Final, 30 days prior to expiration date
(5606,	180	, 650,	33	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form Final, 45 days after expiration
(5607,	180	, 650,	36	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form Final, 45 days prior to expiration
(5608,	180	, 650,	39	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form Final, 6 months after award effective date
(5609,	180	, 650,	30	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form Final, 6 months after expiration date
(5610,	180	, 650,	20	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form Final, 6 months prior to expiration date
(5611,	180	, 650,	45	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form Final, 60 days after effective date
(5612,	180	, 650,	11	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form Final, 60 days after expiration
(5613,	180	, 650,	59	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form Final, 60 days prior to anniversary date
(5614,	180	, 650,	16	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form Final, 60 days prior to expiration date
(5615,	180	, 650,	44	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form Final, 90 days after effective date
(5616,	180	, 650,	12	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form Final, 90 days after expiration
(5617,	180	, 650,	17	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form Final, 90 days prior to expiration date
(5618,	180	, 650,	14	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form Final, As required
(5619,	180	, 650,	13	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form Final, At expiration
(5620,	180	, 650,	5	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form Final, One in advance

-- Procurement
(5700,	160	, 660,	56	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), 15 Days After Each Quarter
(5701,	160	, 660,	32	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), 30 days after annual anniversary
(5702,	160	, 660,	62	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), 30 Days After Each Quarter
(5703,	160	, 660,	61	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), 30 Days After Each Semi-annual
(5704,	160	, 660,	31	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), 60 days after annual anniversary
(5705,	160	, 660,	55	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), 90 days prior to anniversaries
(5706,	160	, 660,	49	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), Annual
(5707,	160	, 660,	50	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), Annual - one month in advance
(5708,	160	, 660,	9	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), Annual - two months in advance
(5709,	160	, 660,	2	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), Bi-monthly
(5710,	160	, 660,	3	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), Monthly
(5711,	160 , 660,  7	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), Quarterly
(5712,	160	, 660,	6	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), Semi-annual
(5713,	160	, 660,	52	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), Semi-annual - one month in advance
(5800,	160	, 670,	35	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, 120 days prior to expiration
(5801,	160	, 670,	58	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, 15 days after expiration
(5802,	160	, 670,	38	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, 30 days after award effective date
(5803,	160	, 670,	27	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, 30 days after effective date
(5804,	160	, 670,	10	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, 30 days after expiration
(5805,	160	, 670,	15	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, 30 days prior to expiration date
(5806,	160	, 670,	33	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, 45 days after expiration
(5807,	160	, 670,	36	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, 45 days prior to expiration
(5808,	160	, 670,	39	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, 6 months after award effective date
(5809,	160	, 670,	30	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, 6 months after expiration date
(5810,	160	, 670,	20	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, 6 months prior to expiration date
(5811,	160	, 670,	45	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, 60 days after effective date
(5812,	160	, 670,	11	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, 60 days after expiration
(5813,	160	, 670,	59	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, 60 days prior to anniversary date
(5814,	160	, 670,	16	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, 60 days prior to expiration date
(5815,	160	, 670,	44	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, 90 days after effective date
(5816,	160	, 670,	12	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, 90 days after expiration
(5817,	160	, 670,	17	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, 90 days prior to expiration date
(5818,	160	, 670,	14	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, As required
(5819,	160	, 670,	13	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, At expiration
(5820,	160	, 670,	5	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, One in advance
(5900,	160	, 680,	56	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), 15 Days After Each Quarter
(5901,	160	, 680,	32	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), 30 days after annual anniversary
(5902,	160	, 680,	62	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), 30 Days After Each Quarter
(5903,	160	, 680,	61	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), 30 Days After Each Semi-annual
(5904,	160	, 680,	31	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), 60 days after annual anniversary
(5905,	160	, 680,	55	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), 90 days prior to anniversaries
(5906,	160	, 680,	49	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), Annual
(5907,	160	, 680,	50	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), Annual - one month in advance
(5908,	160	, 680,	9	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), Annual - two months in advance
(5909,	160	, 680,	2	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), Bi-monthly
(5910,	160	, 680,	3	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), Monthly
(5911,	160 , 680,  7	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), Quarterly
(5912,	160	, 680,	6	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), Semi-annual
(5913,	160	, 680,	52	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), Semi-annual - one month in advance
(6000,	160	, 690,	35	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-FInal, 120 days prior to expiration
(6001,	160	, 690,	58	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-FInal, 15 days after expiration
(6002,	160	, 690,	38	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-FInal, 30 days after award effective date
(6003,	160	, 690,	27	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-FInal, 30 days after effective date
(6004,	160	, 690,	10	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-FInal, 30 days after expiration
(6005,	160	, 690,	15	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-FInal, 30 days prior to expiration date
(6006,	160	, 690,	33	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-FInal, 45 days after expiration
(6007,	160	, 690,	36	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-FInal, 45 days prior to expiration
(6008,	160	, 690,	39	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-FInal, 6 months after award effective date
(6009,	160	, 690,	30	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-FInal, 6 months after expiration date
(6010,	160	, 690,	20	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-FInal, 6 months prior to expiration date
(6011,	160	, 690,	45	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-FInal, 60 days after effective date
(6012,	160	, 690,	11	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-FInal, 60 days after expiration
(6013,	160	, 690,	59	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-FInal, 60 days prior to anniversary date
(6014,	160	, 690,	16	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-FInal, 60 days prior to expiration date
(6015,	160	, 690,	44	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-FInal, 90 days after effective date
(6016,	160	, 690,	12	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-FInal, 90 days after expiration
(6017,	160	, 690,	17	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-FInal, 90 days prior to expiration date
(6018,	160	, 690,	14	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-FInal, As required
(6019,	160	, 690,	13	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-FInal, At expiration
(6020,	160	, 690,	5	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-FInal, One in advance
(6100,	160	, 700,	35	, NOW(),	'admin',	1, UUID()),  --  UCAR Subrecipient Closeout Form, 120 days prior to expiration
(6101,	160	, 700,	58	, NOW(),	'admin',	1, UUID()),  --  UCAR Subrecipient Closeout Form, 15 days after expiration
(6102,	160	, 700,	38	, NOW(),	'admin',	1, UUID()),  --  UCAR Subrecipient Closeout Form, 30 days after award effective date
(6103,	160	, 700,	27	, NOW(),	'admin',	1, UUID()),  --  UCAR Subrecipient Closeout Form, 30 days after effective date
(6104,	160	, 700,	10	, NOW(),	'admin',	1, UUID()),  --  UCAR Subrecipient Closeout Form, 30 days after expiration
(6105,	160	, 700,	15	, NOW(),	'admin',	1, UUID()),  --  UCAR Subrecipient Closeout Form, 30 days prior to expiration date
(6106,	160	, 700,	33	, NOW(),	'admin',	1, UUID()),  --  UCAR Subrecipient Closeout Form, 45 days after expiration
(6107,	160	, 700,	36	, NOW(),	'admin',	1, UUID()),  --  UCAR Subrecipient Closeout Form, 45 days prior to expiration
(6108,	160	, 700,	39	, NOW(),	'admin',	1, UUID()),  --  UCAR Subrecipient Closeout Form, 6 months after award effective date
(6109,	160	, 700,	30	, NOW(),	'admin',	1, UUID()),  --  UCAR Subrecipient Closeout Form, 6 months after expiration date
(6110,	160	, 700,	20	, NOW(),	'admin',	1, UUID()),  --  UCAR Subrecipient Closeout Form, 6 months prior to expiration date
(6111,	160	, 700,	45	, NOW(),	'admin',	1, UUID()),  --  UCAR Subrecipient Closeout Form, 60 days after effective date
(6112,	160	, 700,	11	, NOW(),	'admin',	1, UUID()),  --  UCAR Subrecipient Closeout Form, 60 days after expiration
(6113,	160	, 700,	59	, NOW(),	'admin',	1, UUID()),  --  UCAR Subrecipient Closeout Form, 60 days prior to anniversary date
(6114,	160	, 700,	16	, NOW(),	'admin',	1, UUID()),  --  UCAR Subrecipient Closeout Form, 60 days prior to expiration date
(6115,	160	, 700,	44	, NOW(),	'admin',	1, UUID()),  --  UCAR Subrecipient Closeout Form, 90 days after effective date
(6116,	160	, 700,	12	, NOW(),	'admin',	1, UUID()),  --  UCAR Subrecipient Closeout Form, 90 days after expiration
(6117,	160	, 700,	17	, NOW(),	'admin',	1, UUID()),  --  UCAR Subrecipient Closeout Form, 90 days prior to expiration date
(6118,	160	, 700,	14	, NOW(),	'admin',	1, UUID()),  --  UCAR Subrecipient Closeout Form, As required
(6119,	160	, 700,	13	, NOW(),	'admin',	1, UUID()),  --  UCAR Subrecipient Closeout Form, At expiration
(6120,	160	, 700,	5	, NOW(),	'admin',	1, UUID()),  --  UCAR Subrecipient Closeout Form, One in advance

-- Contracts
(6200,	100	, 710,	56	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, 15 Days After Each Quarter
(6201,	100	, 710,	32	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, 30 days after annual anniversary
(6202,	100	, 710,	62	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, 30 Days After Each Quarter
(6203,	100	, 710,	61	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, 30 Days After Each Semi-annual
(6204,	100	, 710,	31	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, 60 days after annual anniversary
(6205,	100	, 710,	55	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, 90 days prior to anniversaries
(6206,	100	, 710,	49	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, Annual
(6207,	100	, 710,	50	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, Annual - one month in advance
(6208,	100	, 710,	9	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, Annual - two months in advance
(6209,	100	, 710,	2	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, Bi-monthly
(6210,	100	, 710,	3	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, Monthly
(6211,	100 , 710,  7	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, Quarterly
(6212,	100	, 710,	6	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, Semi-annual
(6213,	100	, 710,	52	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, Semi-annual - one month in advance
(6300,	160	, 720,	56	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, 15 Days After Each Quarter
(6301,	160	, 720,	32	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, 30 days after annual anniversary
(6302,	160	, 720,	62	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, 30 Days After Each Quarter
(6303,	160	, 720,	61	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, 30 Days After Each Semi-annual
(6304,	160	, 720,	31	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, 60 days after annual anniversary
(6305,	160	, 720,	55	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, 90 days prior to anniversaries
(6306,	160	, 720,	49	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, Annual
(6307,	160	, 720,	50	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, Annual - one month in advance
(6308,	160	, 720,	9	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, Annual - two months in advance
(6309,	160	, 720,	2	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, Bi-monthly
(6310,	160	, 720,	3	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, Monthly
(6311,	160 , 720,  7	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, Quarterly
(6312,	160	, 720,	6	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, Semi-annual
(6313,	160	, 720,	52	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, Semi-annual - one month in advance
(6400,	100	, 730,	56	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , 15 Days After Each Quarter
(6401,	100	, 730,	32	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , 30 days after annual anniversary
(6402,	100	, 730,	62	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , 30 Days After Each Quarter
(6403,	100	, 730,	61	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , 30 Days After Each Semi-annual
(6404,	100	, 730,	31	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , 60 days after annual anniversary
(6405,	100	, 730,	55	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , 90 days prior to anniversaries
(6406,	100	, 730,	49	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , Annual
(6407,	100	, 730,	50	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , Annual - one month in advance
(6408,	100	, 730,	9	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , Annual - two months in advance
(6409,	100	, 730,	2	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , Bi-monthly
(6410,	100	, 730,	3	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , Monthly
(6411,	100 , 730,  7	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , Quarterly
(6412,	100	, 730,	6	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , Semi-annual
(6413,	100	, 730,	52	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , Semi-annual - one month in advance
(6500,	100	, 740,	35	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, 120 days prior to expiration
(6501,	100	, 740,	58	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, 15 days after expiration
(6502,	100	, 740,	38	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, 30 days after award effective date
(6503,	100	, 740,	27	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, 30 days after effective date
(6504,	100	, 740,	10	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, 30 days after expiration
(6505,	100	, 740,	15	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, 30 days prior to expiration date
(6506,	100	, 740,	33	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, 45 days after expiration
(6507,	100	, 740,	36	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, 45 days prior to expiration
(6508,	100	, 740,	39	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, 6 months after award effective date
(6509,	100	, 740,	30	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, 6 months after expiration date
(6510,	100	, 740,	20	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, 6 months prior to expiration date
(6511,	100	, 740,	45	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, 60 days after effective date
(6512,	100	, 740,	11	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, 60 days after expiration
(6513,	100	, 740,	59	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, 60 days prior to anniversary date
(6514,	100	, 740,	16	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, 60 days prior to expiration date
(6515,	100	, 740,	44	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, 90 days after effective date
(6516,	100	, 740,	12	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, 90 days after expiration
(6517,	100	, 740,	17	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, 90 days prior to expiration date
(6518,	100	, 740,	14	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, As required
(6519,	100	, 740,	13	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, At expiration
(6520,	100	, 740,	5	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, One in advance
(6600,	100	, 750,	56	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , 15 Days After Each Quarter
(6601,	100	, 750,	32	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , 30 days after annual anniversary
(6602,	100	, 750,	62	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , 30 Days After Each Quarter
(6603,	100	, 750,	61	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , 30 Days After Each Semi-annual
(6604,	100	, 750,	31	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , 60 days after annual anniversary
(6605,	100	, 750,	55	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , 90 days prior to anniversaries
(6606,	100	, 750,	49	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , Annual
(6607,	100	, 750,	50	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , Annual - one month in advance
(6608,	100	, 750,	9	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , Annual - two months in advance
(6609,	100	, 750,	2	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , Bi-monthly
(6610,	100	, 750,	3	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , Monthly
(6611,	100 , 750,  7	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , Quarterly
(6612,	100	, 750,	6	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , Semi-annual
(6613,	100	, 750,	52	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , Semi-annual - one month in advance
(6700,	100	, 760,	35	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, 120 days prior to expiration
(6701,	100	, 760,	58	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, 15 days after expiration
(6702,	100	, 760,	38	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, 30 days after award effective date
(6703,	100	, 760,	27	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, 30 days after effective date
(6704,	100	, 760,	10	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, 30 days after expiration
(6705,	100	, 760,	15	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, 30 days prior to expiration date
(6706,	100	, 760,	33	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, 45 days after expiration
(6707,	100	, 760,	36	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, 45 days prior to expiration
(6708,	100	, 760,	39	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, 6 months after award effective date
(6709,	100	, 760,	30	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, 6 months after expiration date
(6710,	100	, 760,	20	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, 6 months prior to expiration date
(6711,	100	, 760,	45	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, 60 days after effective date
(6712,	100	, 760,	11	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, 60 days after expiration
(6713,	100	, 760,	59	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, 60 days prior to anniversary date
(6714,	100	, 760,	16	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, 60 days prior to expiration date
(6715,	100	, 760,	44	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, 90 days after effective date
(6716,	100	, 760,	12	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, 90 days after expiration
(6717,	100	, 760,	17	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, 90 days prior to expiration date
(6718,	100	, 760,	14	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, As required
(6719,	100	, 760,	13	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, At expiration
(6720,	100	, 760,	5	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, One in advance
(6800,	100	, 770,	35	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , 120 days prior to expiration
(6801,	100	, 770,	58	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , 15 days after expiration
(6802,	100	, 770,	38	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , 30 days after award effective date
(6803,	100	, 770,	27	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , 30 days after effective date
(6804,	100	, 770,	10	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , 30 days after expiration
(6805,	100	, 770,	15	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , 30 days prior to expiration date
(6806,	100	, 770,	33	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , 45 days after expiration
(6807,	100	, 770,	36	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , 45 days prior to expiration
(6808,	100	, 770,	39	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , 6 months after award effective date
(6809,	100	, 770,	30	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , 6 months after expiration date
(6810,	100	, 770,	20	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , 6 months prior to expiration date
(6811,	100	, 770,	45	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , 60 days after effective date
(6812,	100	, 770,	11	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , 60 days after expiration
(6813,	100	, 770,	59	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , 60 days prior to anniversary date
(6814,	100	, 770,	16	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , 60 days prior to expiration date
(6815,	100	, 770,	44	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , 90 days after effective date
(6816,	100	, 770,	12	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , 90 days after expiration
(6817,	100	, 770,	17	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , 90 days prior to expiration date
(6818,	100	, 770,	14	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , As required
(6819,	100	, 770,	13	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , At expiration
(6820,	100	, 770,	5	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , One in advance
(6900,	100	, 780,	35	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, 120 days prior to expiration
(6901,	100	, 780,	58	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, 15 days after expiration
(6902,	100	, 780,	38	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, 30 days after award effective date
(6903,	100	, 780,	27	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, 30 days after effective date
(6904,	100	, 780,	10	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, 30 days after expiration
(6905,	100	, 780,	15	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, 30 days prior to expiration date
(6906,	100	, 780,	33	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, 45 days after expiration
(6907,	100	, 780,	36	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, 45 days prior to expiration
(6908,	100	, 780,	39	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, 6 months after award effective date
(6909,	100	, 780,	30	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, 6 months after expiration date
(6910,	100	, 780,	20	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, 6 months prior to expiration date
(6911,	100	, 780,	45	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, 60 days after effective date
(6912,	100	, 780,	11	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, 60 days after expiration
(6913,	100	, 780,	59	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, 60 days prior to anniversary date
(6914,	100	, 780,	16	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, 60 days prior to expiration date
(6915,	100	, 780,	44	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, 90 days after effective date
(6916,	100	, 780,	12	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, 90 days after expiration
(6917,	100	, 780,	17	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, 90 days prior to expiration date
(6918,	100	, 780,	14	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, As required
(6919,	100	, 780,	13	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, At expiration
(6920,	100	, 780,	5	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, One in advance
(7000,	100	, 790,	56	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (IRB) Approval , 15 Days After Each Quarter
(7001,	100	, 790,	32	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (IRB) Approval , 30 days after annual anniversary
(7002,	100	, 790,	62	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (IRB) Approval , 30 Days After Each Quarter
(7003,	100	, 790,	61	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (IRB) Approval , 30 Days After Each Semi-annual
(7004,	100	, 790,	31	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (IRB) Approval , 60 days after annual anniversary
(7005,	100	, 790,	55	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (IRB) Approval , 90 days prior to anniversaries
(7006,	100	, 790,	49	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (IRB) Approval , Annual
(7007,	100	, 790,	50	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (IRB) Approval , Annual - one month in advance
(7008,	100	, 790,	9	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (IRB) Approval , Annual - two months in advance
(7009,	100	, 790,	2	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (IRB) Approval , Bi-monthly
(7010,	100	, 790,	3	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (IRB) Approval , Monthly
(7011,	100 , 790,  7	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (IRB) Approval , Quarterly
(7012,	100	, 790,	6	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (IRB) Approval , Semi-annual
(7013,	100	, 790,	52	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (IRB) Approval , Semi-annual - one month in advance
(7100,	100	, 780,	35	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), 120 days prior to expiration
(7101,	100	, 800,	58	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), 15 days after expiration
(7102,	100	, 800,	38	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), 30 days after award effective date
(7103,	100	, 800,	27	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), 30 days after effective date
(7104,	100	, 800,	10	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), 30 days after expiration
(7105,	100	, 800,	15	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), 30 days prior to expiration date
(7106,	100	, 800,	33	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), 45 days after expiration
(7107,	100	, 800,	36	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), 45 days prior to expiration
(7108,	100	, 800,	39	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), 6 months after award effective date
(7109,	100	, 800,	30	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), 6 months after expiration date
(7110,	100	, 800,	20	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), 6 months prior to expiration date
(7111,	100	, 800,	45	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), 60 days after effective date
(7112,	100	, 800,	11	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), 60 days after expiration
(7113,	100	, 800,	59	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), 60 days prior to anniversary date
(7114,	100	, 800,	16	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), 60 days prior to expiration date
(7115,	100	, 800,	44	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), 90 days after effective date
(7116,	100	, 800,	12	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), 90 days after expiration
(7117,	100	, 800,	17	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), 90 days prior to expiration date
(7118,	100	, 800,	14	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), As required
(7119,	100	, 800,	13	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), At expiration
(7120,	100	, 800,	5	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), One in advance
(7200,	100	, 810,	56	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, 15 Days After Each Quarter
(7201,	100	, 810,	32	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, 30 days after annual anniversary
(7202,	100	, 810,	62	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, 30 Days After Each Quarter
(7203,	100	, 810,	61	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, 30 Days After Each Semi-annual
(7204,	100	, 810,	31	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, 60 days after annual anniversary
(7205,	100	, 810,	55	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, 90 days prior to anniversaries
(7206,	100	, 810,	49	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, Annual
(7207,	100	, 810,	50	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, Annual - one month in advance
(7208,	100	, 810,	9	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, Annual - two months in advance
(7209,	100	, 810,	2	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, Bi-monthly
(7210,	100	, 810,	3	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, Monthly
(7211,	100 , 810,  7	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, Quarterly
(7212,	100	, 810,	6	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, Semi-annual
(7213,	100	, 810,	52	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, Semi-annual - one month in advance

-- Legal
(7300,	130	, 820,	56	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, 15 Days After Each Quarter
(7301,	130	, 820,	32	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, 30 days after annual anniversary
(7302,	130	, 820,	62	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, 30 Days After Each Quarter
(7303,	130	, 820,	61	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, 30 Days After Each Semi-annual
(7304,	130	, 820,	31	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, 60 days after annual anniversary
(7305,	130	, 820,	55	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, 90 days prior to anniversaries
(7306,	130	, 820,	49	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, Annual
(7307,	130	, 820,	50	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, Annual - one month in advance
(7308,	130	, 820,	9	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, Annual - two months in advance
(7309,	130	, 820,	2	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, Bi-monthly
(7310,	130	, 820,	3	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, Monthly
(7311,	130 , 820,  7	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, Quarterly
(7312,	130	, 820,	6	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, Semi-annual
(7313,	130	, 820,	52	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, Semi-annual - one month in advance
(7400,	130	, 830,	56	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, 15 Days After Each Quarter
(7401,	130	, 830,	32	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, 30 days after annual anniversary
(7402,	130	, 830,	62	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, 30 Days After Each Quarter
(7403,	130	, 830,	61	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, 30 Days After Each Semi-annual
(7404,	130	, 830,	31	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, 60 days after annual anniversary
(7405,	130	, 830,	55	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, 90 days prior to anniversaries
(7406,	130	, 830,	49	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, Annual
(7407,	130	, 830,	50	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, Annual - one month in advance
(7408,	130	, 830,	9	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, Annual - two months in advance
(7409,	130	, 830,	2	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, Bi-monthly
(7410,	130	, 830,	3	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, Monthly
(7411,	130 , 830,  7	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, Quarterly
(7412,	130	, 830,	6	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, Semi-annual
(7413,	130	, 830,	52	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, Semi-annual - one month in advance

-- NCAR Operations
(7500,	140	, 840,	56	, NOW(),	'admin',	1, UUID()),  --  Energy/Sustainability Report, 15 Days After Each Quarter
(7501,	140	, 840,	32	, NOW(),	'admin',	1, UUID()),  --  Energy/Sustainability Report, 30 days after annual anniversary
(7502,	140	, 840,	62	, NOW(),	'admin',	1, UUID()),  --  Energy/Sustainability Report, 30 Days After Each Quarter
(7503,	140	, 840,	61	, NOW(),	'admin',	1, UUID()),  --  Energy/Sustainability Report, 30 Days After Each Semi-annual
(7504,	140	, 840,	31	, NOW(),	'admin',	1, UUID()),  --  Energy/Sustainability Report, 60 days after annual anniversary
(7505,	140	, 840,	55	, NOW(),	'admin',	1, UUID()),  --  Energy/Sustainability Report, 90 days prior to anniversaries
(7506,	140	, 840,	49	, NOW(),	'admin',	1, UUID()),  --  Energy/Sustainability Report, Annual
(7507,	140	, 840,	50	, NOW(),	'admin',	1, UUID()),  --  Energy/Sustainability Report, Annual - one month in advance
(7508,	140	, 840,	9	, NOW(),	'admin',	1, UUID()),  --  Energy/Sustainability Report, Annual - two months in advance
(7509,	140	, 840,	2	, NOW(),	'admin',	1, UUID()),  --  Energy/Sustainability Report, Bi-monthly
(7510,	140	, 840,	3	, NOW(),	'admin',	1, UUID()),  --  Energy/Sustainability Report, Monthly
(7511,	140 , 840,  7	, NOW(),	'admin',	1, UUID()),  --  Energy/Sustainability Report, Quarterly
(7512,	140	, 840,	6	, NOW(),	'admin',	1, UUID()),  --  Energy/Sustainability Report, Semi-annual
(7513,	140	, 840,	52	, NOW(),	'admin',	1, UUID()),  --  Energy/Sustainability Report, Semi-annual - one month in advance
(7600,	140	, 850,	56	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), 15 Days After Each Quarter
(7601,	140	, 850,	32	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), 30 days after annual anniversary
(7602,	140	, 850,	62	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), 30 Days After Each Quarter
(7603,	140	, 850,	61	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), 30 Days After Each Semi-annual
(7604,	140	, 850,	31	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), 60 days after annual anniversary
(7605,	140	, 850,	55	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), 90 days prior to anniversaries
(7606,	140	, 850,	49	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), Annual
(7607,	140	, 850,	50	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), Annual - one month in advance
(7608,	140	, 850,	9	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), Annual - two months in advance
(7609,	140	, 850,	2	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), Bi-monthly
(7610,	140	, 850,	3	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), Monthly
(7611,	140 , 850,  7	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), Quarterly
(7612,	140	, 850,	6	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), Semi-annual
(7613,	140	, 850,	52	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), Semi-annual - one month in advance
(7700,	140	, 860,	56	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), 15 Days After Each Quarter
(7701,	140	, 860,	32	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), 30 days after annual anniversary
(7702,	140	, 860,	62	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), 30 Days After Each Quarter
(7703,	140	, 860,	61	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), 30 Days After Each Semi-annual
(7704,	140	, 860,	31	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), 60 days after annual anniversary
(7705,	140	, 860,	55	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), 90 days prior to anniversaries
(7706,	140	, 860,	49	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), Annual
(7707,	140	, 860,	50	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), Annual - one month in advance
(7708,	140	, 860,	9	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), Annual - two months in advance
(7709,	140	, 860,	2	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), Bi-monthly
(7710,	140	, 860,	3	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), Monthly
(7711,	140 , 860,  7	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), Quarterly
(7712,	140	, 860,	6	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), Semi-annual
(7713,	140	, 860,	52	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), Semi-annual - one month in advance
(7800,	140	, 850,	56	, NOW(),	'admin',	1, UUID()),  --  GAU (Now Core-Hours) and SUR Funding Sources and Usage, 15 Days After Each Quarter
(7801,	140	, 870,	32	, NOW(),	'admin',	1, UUID()),  --  GAU (Now Core-Hours) and SUR Funding Sources and Usage, 30 days after annual anniversary
(7802,	140	, 870,	62	, NOW(),	'admin',	1, UUID()),  --  GAU (Now Core-Hours) and SUR Funding Sources and Usage, 30 Days After Each Quarter
(7803,	140	, 870,	61	, NOW(),	'admin',	1, UUID()),  --  GAU (Now Core-Hours) and SUR Funding Sources and Usage, 30 Days After Each Semi-annual
(7804,	140	, 870,	31	, NOW(),	'admin',	1, UUID()),  --  GAU (Now Core-Hours) and SUR Funding Sources and Usage, 60 days after annual anniversary
(7805,	140	, 870,	55	, NOW(),	'admin',	1, UUID()),  --  GAU (Now Core-Hours) and SUR Funding Sources and Usage, 90 days prior to anniversaries
(7806,	140	, 870,	49	, NOW(),	'admin',	1, UUID()),  --  GAU (Now Core-Hours) and SUR Funding Sources and Usage, Annual
(7807,	140	, 870,	50	, NOW(),	'admin',	1, UUID()),  --  GAU (Now Core-Hours) and SUR Funding Sources and Usage, Annual - one month in advance
(7808,	140	, 870,	9	, NOW(),	'admin',	1, UUID()),  --  GAU (Now Core-Hours) and SUR Funding Sources and Usage, Annual - two months in advance
(7809,	140	, 870,	2	, NOW(),	'admin',	1, UUID()),  --  GAU (Now Core-Hours) and SUR Funding Sources and Usage, Bi-monthly
(7810,	140	, 870,	3	, NOW(),	'admin',	1, UUID()),  --  GAU (Now Core-Hours) and SUR Funding Sources and Usage, Monthly
(7811,	140 , 870,  7	, NOW(),	'admin',	1, UUID()),  --  GAU (Now Core-Hours) and SUR Funding Sources and Usage, Quarterly
(7812,	140	, 870,	6	, NOW(),	'admin',	1, UUID()),  --  GAU (Now Core-Hours) and SUR Funding Sources and Usage, Semi-annual
(7813,	140	, 870,	52	, NOW(),	'admin',	1, UUID()),  --  GAU (Now Core-Hours) and SUR Funding Sources and Usage, Semi-annual - one month in advance
(7900,	140	, 880,	56	, NOW(),	'admin',	1, UUID()),  --  UCAR Management Information Report, 15 Days After Each Quarter
(7901,	140	, 880,	32	, NOW(),	'admin',	1, UUID()),  --  UCAR Management Information Report, 30 days after annual anniversary
(7902,	140	, 880,	62	, NOW(),	'admin',	1, UUID()),  --  UCAR Management Information Report, 30 Days After Each Quarter
(7903,	140	, 880,	61	, NOW(),	'admin',	1, UUID()),  --  UCAR Management Information Report, 30 Days After Each Semi-annual
(7904,	140	, 880,	31	, NOW(),	'admin',	1, UUID()),  --  UCAR Management Information Report, 60 days after annual anniversary
(7905,	140	, 880,	55	, NOW(),	'admin',	1, UUID()),  --  UCAR Management Information Report, 90 days prior to anniversaries
(7906,	140	, 880,	49	, NOW(),	'admin',	1, UUID()),  --  UCAR Management Information Report, Annual
(7907,	140	, 880,	50	, NOW(),	'admin',	1, UUID()),  --  UCAR Management Information Report, Annual - one month in advance
(7908,	140	, 880,	9	, NOW(),	'admin',	1, UUID()),  --  UCAR Management Information Report, Annual - two months in advance
(7909,	140	, 880,	2	, NOW(),	'admin',	1, UUID()),  --  UCAR Management Information Report, Bi-monthly
(7910,	140	, 880,	3	, NOW(),	'admin',	1, UUID()),  --  UCAR Management Information Report, Monthly
(7911,	140 , 880,  7	, NOW(),	'admin',	1, UUID()),  --  UCAR Management Information Report, Quarterly
(7912,	140	, 880,	6	, NOW(),	'admin',	1, UUID()),  --  UCAR Management Information Report, Semi-annual
(7913,	140	, 880,	52	, NOW(),	'admin',	1, UUID());  --  UCAR Management Information Report, Semi-annual - one month in advance

-- procurement

COMMIT;   

/*

SELECT * FROM frequency;
SELECT * FROM REPORT_CLASS;
SELECT * FROM REPORT_STATUS;
select * from closeout_report_type;
select * from krcr_parm_t
order by 3;
select * from award_closeout;
select * from frequency_base;
select * from valid_frequency_base;
select * from report;
SELECT * FROM valid_class_report_freq;
select * from report;

*/
  

			