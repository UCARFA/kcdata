-- Jira ticket #478

-- there are some bogus relationships from CONTACT_TYPE_CODE 30 to 38, because they were deleted but in the test data.

START TRANSACTION;

SELECT * FROM contact_type;

UPDATE CONTACT_TYPE 
SET DESCRIPTION = 'ALL-Administrative Contact'
WHERE Contact_Type_Code = 13;

UPDATE CONTACT_TYPE 
SET DESCRIPTION = 'CON-Close-out Contact'
WHERE Contact_Type_Code = 10;

UPDATE CONTACT_TYPE 
SET DESCRIPTION = 'FIN-Financial Contact'
WHERE Contact_Type_Code = 38;

UPDATE CONTACT_TYPE 
SET DESCRIPTION = 'CON-Intellectual Property Contact'
WHERE Contact_Type_Code = 4;

UPDATE CONTACT_TYPE 
SET DESCRIPTION = 'ALL-Other Reporting Contact'
WHERE Contact_Type_Code = 8;

UPDATE CONTACT_TYPE 
SET DESCRIPTION = 'FIN-Financial Reporting Contact'
WHERE Contact_Type_Code = 3;

UPDATE CONTACT_TYPE 
SET DESCRIPTION = 'FIN-Property Office Contact'
WHERE Contact_Type_Code = 16;

UPDATE CONTACT_TYPE 
SET DESCRIPTION = 'CON-ESRS Report Contact'
WHERE Contact_Type_Code = 6;

UPDATE CONTACT_TYPE 
SET DESCRIPTION = 'ALL-Technical Contact/Program Manager'
WHERE Contact_Type_Code = 1;


INSERT CONTACT_TYPE (VER_NBR, CONTACT_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
VALUES

(1,	40,	'CON-Administering Contract/Grant Officer',	NOW(),'admin',	UUID()),
(1,	41,	'CON-Contract/Grant Specialist/Officer',	NOW(),'admin',	UUID()),
(1,	42,	'FIN-Invoicing Contact',	NOW(),'admin',	UUID());

UPDATE AWARD_REP_TERMS_RECNT
	SET CONTACT_TYPE_CODE =   CASE 	
								
                                WHEN CONTACT_TYPE_CODE = 30 THEN 3 
								WHEN CONTACT_TYPE_CODE = 31 THEN 40
								WHEN CONTACT_TYPE_CODE = 32 THEN 41 
								WHEN CONTACT_TYPE_CODE = 33 THEN 42
                                WHEN CONTACT_TYPE_CODE = 34 THEN 13 
								WHEN CONTACT_TYPE_CODE = 35 THEN 8
								WHEN CONTACT_TYPE_CODE = 36 THEN 16
								WHEN CONTACT_TYPE_CODE = 37 THEN  6
								ELSE CONTACT_TYPE_CODE


							END;
                            
SELECT * FROM AWARD_TEMPL_REP_TERMS_RECNT;
UPDATE AWARD_TEMPL_REP_TERMS_RECNT
	SET CONTACT_TYPE_CODE =   CASE 	
								
                                WHEN CONTACT_TYPE_CODE = 30 THEN 3 
								WHEN CONTACT_TYPE_CODE = 31 THEN 40
								WHEN CONTACT_TYPE_CODE = 32 THEN 41 
								WHEN CONTACT_TYPE_CODE = 33 THEN 42
                                WHEN CONTACT_TYPE_CODE = 34 THEN 13 
								WHEN CONTACT_TYPE_CODE = 35 THEN 8
								WHEN CONTACT_TYPE_CODE = 36 THEN 16
								WHEN CONTACT_TYPE_CODE = 37 THEN  6
								ELSE CONTACT_TYPE_CODE

							END;
                            
SELECT * FROM AWARD_TEMPLATE_CONTACT;
UPDATE AWARD_TEMPLATE_CONTACT
	SET CONTACT_TYPE_CODE =   CASE 	

                                WHEN CONTACT_TYPE_CODE = 30 THEN 3 
								WHEN CONTACT_TYPE_CODE = 31 THEN 40
								WHEN CONTACT_TYPE_CODE = 32 THEN 41 
								WHEN CONTACT_TYPE_CODE = 33 THEN 42
                                WHEN CONTACT_TYPE_CODE = 34 THEN 13 
								WHEN CONTACT_TYPE_CODE = 35 THEN 8
								WHEN CONTACT_TYPE_CODE = 36 THEN 16
								WHEN CONTACT_TYPE_CODE = 37 THEN  6
                                ELSE CONTACT_TYPE_CODE


							END;
                           
SELECT * FROM CONTACT_USAGE;
UPDATE CONTACT_USAGE
	SET CONTACT_TYPE_CODE =   CASE 	

                                WHEN CONTACT_TYPE_CODE = 30 THEN 3 
								WHEN CONTACT_TYPE_CODE = 31 THEN 40
								WHEN CONTACT_TYPE_CODE = 32 THEN 41 
								WHEN CONTACT_TYPE_CODE = 33 THEN 42
                                WHEN CONTACT_TYPE_CODE = 34 THEN 13 
								WHEN CONTACT_TYPE_CODE = 35 THEN 8
								WHEN CONTACT_TYPE_CODE = 36 THEN 16
								WHEN CONTACT_TYPE_CODE = 37 THEN  6
                                ELSE CONTACT_TYPE_CODE


							END;
                            
SELECT * FROM SUBAWARD_CONTACT;
UPDATE SUBAWARD_CONTACT
	SET CONTACT_TYPE_CODE =   CASE 	

                                WHEN CONTACT_TYPE_CODE = 30 THEN 3 
								WHEN CONTACT_TYPE_CODE = 31 THEN 40
								WHEN CONTACT_TYPE_CODE = 32 THEN 41 
								WHEN CONTACT_TYPE_CODE = 33 THEN 42
                                WHEN CONTACT_TYPE_CODE = 34 THEN 13 
								WHEN CONTACT_TYPE_CODE = 35 THEN 8
								WHEN CONTACT_TYPE_CODE = 36 THEN 16
								WHEN CONTACT_TYPE_CODE = 37 THEN  6
                                ELSE CONTACT_TYPE_CODE


							END;


DELETE FROM contact_type
WHERE CONTACT_TYPE_CODE IN (-1,22,37,2,14,30,34,36,35,9,17,18,19,20,5,21,11,12,24,31,33,15,23,32,7);

select * from contact_usage;

SELECT * FROM contact_type;

COMMIT;

