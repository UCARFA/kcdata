-- additional adds to report status as of 8/30/2017


INSERT report_status (REPORT_STATUS_CODE, DESCRIPTION, ACTIVE_FLAG, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
VALUES (8, 'Not Required', 'Y', NOW(), 'admin', 1, UUID()),
(9, 'Required Only If Applicable', 'Y', NOW(), 'admin', 1, UUID());


