-- FAPA 1455
-- additional adds to report status as of 8/30/2017
-- select * from report_status;

DROP TEMPORARY TABLE IF EXISTS tmp_report_status_table;
CREATE TEMPORARY TABLE tmp_report_status_table (
  `REPORT_STATUS_CODE` varchar(3) COLLATE utf8_bin NOT NULL,
  `DESCRIPTION` varchar(200) COLLATE utf8_bin NOT NULL,
  `ACTIVE_FLAG` char(1) COLLATE utf8_bin NOT NULL,
  `UPDATE_TIMESTAMP` datetime DEFAULT NULL,
  `UPDATE_USER` varchar(60) COLLATE utf8_bin NOT NULL,
  `VER_NBR` decimal(8,0) NOT NULL,
  `OBJ_ID` varchar(36) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`REPORT_STATUS_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT tmp_report_status_table (REPORT_STATUS_CODE, DESCRIPTION, ACTIVE_FLAG, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
VALUES 
(5,	'Revised',	'Y',	NOW(),	'admin',	1,	UUID()),
(6,	'Submitted for Internal Approval',	'Y',	NOW(),	'admin',	1,	UUID()),
(7,	'Submitted to Sponsor',	'Y',	NOW(),	'admin',	1,	UUID()),
(8, 'Not Required', 'Y', NOW(), 'admin', 1, UUID()),
(9, 'Required Only If Applicable', 'Y', NOW(), 'admin', 1, UUID());

INSERT report_status (REPORT_STATUS_CODE, DESCRIPTION, ACTIVE_FLAG, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT REPORT_STATUS_CODE, DESCRIPTION, ACTIVE_FLAG, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID
FROM tmp_report_status_table
WHERE REPORT_STATUS_CODE NOT IN (SELECT REPORT_STATUS_CODE FROM report_status);

DROP TEMPORARY TABLE tmp_report_status_table;








