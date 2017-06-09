BEGIN

DECLARE @rowcount int;

SELECT (@rowcount:= COUNT(*)) as COUNT 
FROM AWARD_TRANSACTION_TYPE 
WHERE AWARD_TRANSACTION_TYPE_CODE IN ('30','40','50','60','70');

IF @rowcount = 0 THEN 

INSERT award_transaction_type (AWARD_TRANSACTION_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, SHOW_IN_ACTION_SUMMARY, VER_NBR, OBJ_ID)
VALUES( 30, '_CONTRACTS-Administrative Action', NOW(), 'admin', 'Y', '1', UUID()),
( 40,  '_CONTRACTS-Report Action', NOW(), 'admin', 'Y', '1', UUID()),
( 50,  '_FINANCE-Administrative Action', NOW(), 'admin', 'Y', '1', UUID()),
( 60,  '_FINANCE-Invoice Action', NOW(), 'admin', 'Y', '1', UUID()),
( 70, '_FINANCE-Report Action', NOW(), 'admin', 'Y', '1', UUID());

ELSE 

UPDATE award_transaction_type
SET DESCRIPTION = '_CONTRACTS-Administrative Action' 
WHERE AWARD_TRANSACTION_TYPE_CODE = 30;

UPDATE award_transaction_type
SET DESCRIPTION = '_CONTRACTS-Report Action' 
WHERE AWARD_TRANSACTION_TYPE_CODE = 40;

UPDATE award_transaction_type
SET DESCRIPTION = '_FINANCE-Administrative Action' 
WHERE AWARD_TRANSACTION_TYPE_CODE = 50;

UPDATE award_transaction_type
SET DESCRIPTION = '_FINANCE-Invoice Action' 
WHERE AWARD_TRANSACTION_TYPE_CODE = 60;

UPDATE award_transaction_type
SET DESCRIPTION = '_FINANCE-Report Action' 
WHERE AWARD_TRANSACTION_TYPE_CODE = 70;


INSERT award_transaction_type (AWARD_TRANSACTION_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, SHOW_IN_ACTION_SUMMARY, VER_NBR, OBJ_ID)
VALUES( 80, 'Deobligation, Period of Performance Change', NOW(), 'admin', 'Y', '1', UUID()),
( 90,  'Deobligation, Scope Change', NOW(), 'admin', 'Y', '1', UUID()),
( 100, 'Deobligation, Period of Performance Change, Scope Change', NOW(), 'admin', 'Y', '1', UUID()),
( 110, 'Supplemental Funding, Period of Performance Change', NOW(), 'admin', 'Y', '1', UUID()),
( 120, 'Supplemental Funding, Scope Change', NOW(), 'admin', 'Y', '1', UUID()),
( 130, 'Supplemental Funding, Period of Performance Change, Scope Change', NOW(), 'admin', 'Y', '1', UUID());

END IF;
 
END;


