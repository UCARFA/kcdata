START TRANSACTION;

SELECT * FROM award_transaction_type;

INSERT award_transaction_type (AWARD_TRANSACTION_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, SHOW_IN_ACTION_SUMMARY, VER_NBR, OBJ_ID)
VALUES( 30, 'CONTRACTS-Administrative Action', NOW(), 'admin', 'Y', '1', UUID()),
( 40,  'CONTRACTS-Report Action', NOW(), 'admin', 'Y', '1', UUID()),
( 50,  'FINANCE-Administrative Action', NOW(), 'admin', 'Y', '1', UUID()),
( 60,  'FINANCE-Invoice Action', NOW(), 'admin', 'Y', '1', UUID()),
( 70, 'FINANCE-Report Action', NOW(), 'admin', 'Y', '1', UUID());

SELECT * FROM award_transaction_type;

COMMIT;