-- Disable Credit Splits (FAPA-413)
-- --------------------------------

START TRANSACTION;

UPDATE krcr_parm_t SET VAL = 'N' WHERE PARM_NM = 'award.creditsplit.enabled';

UPDATE krcr_parm_t SET VAL = 'N' WHERE PARM_NM = 'institutionalproposal.creditsplit.enabled';

UPDATE krcr_parm_t SET VAL = 'N' WHERE PARM_NM = 'proposaldevelopment.creditsplit.enabled';

-- Disable PI Certification for IP Awards (FAPA-474)

UPDATE krcr_parm_t SET VAL = '0' WHERE PARM_NM = 'awardUncertifiedKeyPersonnel';

--  Enable notifications and emails

UPDATE krcr_parm_t SET VAL = 'kctesters@ucar.edu' WHERE PARM_NM = 'EMAIL_NOTIFICATION_FROM_ADDRESS';

UPDATE krcr_parm_t SET VAL = 'kctesters@ucar.edu' WHERE PARM_NM = 'EMAIL_NOTIFICATION_TEST_ADDRESS' AND APPL_ID = 'KC';

UPDATE krcr_parm_t SET VAL = 'kctesters@ucar.edu' where parm_nm = 'EMAIL_NOTIFICATION_TEST_ADDRESS' AND APPL_ID = 'KUALI';

UPDATE krcr_parm_t SET VAL = 'Y' WHERE PARM_NM = 'EMAIL_NOTIFICATION_TEST_ENABLED';

UPDATE krcr_parm_t SET VAL = 'Y' WHERE PARM_NM = 'EMAIL_NOTIFICATIONS_ENABLED';

UPDATE krcr_parm_t SET VAL = 'kctesters@ucar.edu' WHERE PARM_NM = 'KC_DEFAULT_EMAIL_RECIPIENT';

UPDATE krcr_parm_t SET VAL = 'kctesters@ucar.edu' WHERE PARM_NM = 'LOOKUP_CONTACT_EMAIL';

UPDATE krcr_parm_t SET VAL = 'Y' WHERE PARM_NM = 'SEND_EMAIL_NOTIFICATION_IND';

UPDATE krcr_parm_t SET VAL = '0 0 12 * * ?' WHERE PARM_NM = 'REPORT_TRACKING_NOTIFICATIONS_BATCH_CRON_TRIGGER';

UPDATE krcr_parm_t SET VAL = 'Y' WHERE PARM_NM = 'REPORT_TRACKING_NOTIFICATIONS_BATCH_ENABLED';

UPDATE krcr_parm_t SET VAL = 'admin' WHERE PARM_NM = 'REPORT_TRACKING_NOTIFICATIONS_BATCH_RECIPIENT';

UPDATE krcr_parm_t SET VAL = 'ON' WHERE PARM_NM = 'FIN_SYSTEM_INTEGRATION_ON';

UPDATE krcr_parm_t SET VAL = 'admin' WHERE PARM_NM = 'CFDA_BATCH_NOTIFICATION_RECIPIENT';

-- Configure Max File Size Parameter (FAPA-2040)

-- UPDATE krcr_parm_t SET VAL = '25M' WHERE PARM_NM = 'MAX_FILE_SIZE_ATTACHMENT';

-- UPDATE krcr_parm_t SET VAL = '25M' WHERE PARM_NM = 'MAX_FILE_SIZE_DEFAULT_UPLOAD';

-- Set Fiscal Start Month Parameter to 10 (FAPA-2148)

UPDATE krcr_parm_t SET VAL = '10' WHERE PARM_NM = 'KC_FISCAL_START_MONTH ';

COMMIT;
