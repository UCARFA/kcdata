-- Enable and configure test emails
-- --------------------------------

start transaction;


UPDATE krcr_parm_t SET VAL = 'kctesters@ucar.edu' WHERE PARM_NM = "EMAIL_NOTIFICATION_FROM_ADDRESS"
AND NMSPC_CD = "KC-GEN";

UPDATE krcr_parm_t SET VAL = 'kctesters@ucar.edu' WHERE PARM_NM = "EMAIL_NOTIFICATION_TEST_ADDRESS"
AND NMSPC_CD = "KC-GEN";

UPDATE krcr_parm_t SET VAL = 'Y' WHERE PARM_NM = "EMAIL_NOTIFICATION_TEST_ENABLED"
AND NMSPC_CD = "KC-GEN";

UPDATE krcr_parm_t SET VAL = 'kctesters@ucar.edu' WHERE PARM_NM = "EMAIL_NOTIFICATION_TEST_ADDRESS"
AND NMSPC_CD = "KR-WKFLW";

COMMIT;
