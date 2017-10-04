DROP TEMPORARY TABLE IF EXISTS tmp_award_closeout;
CREATE TEMPORARY TABLE `tmp_award_closeout` (
  `ID` MEDIUMINT NOT NULL AUTO_INCREMENT,
  `AWARD_ID` decimal(22,0) NOT NULL,
  `AWARD_NUMBER` varchar(12) COLLATE utf8_bin NOT NULL,
  `SEQUENCE_NUMBER` decimal(4,0) NOT NULL,
  `CLOSEOUT_REPORT_CODE` varchar(3) COLLATE utf8_bin NOT NULL,
  `CLOSEOUT_REPORT_NAME` varchar(100) COLLATE utf8_bin NOT NULL,
  `MULTIPLE` char(1) COLLATE utf8_bin DEFAULT NULL,
  `UPDATE_TIMESTAMP` datetime NOT NULL,
  `UPDATE_USER` varchar(60) COLLATE utf8_bin NOT NULL,
  `VER_NBR` decimal(8,0) NOT NULL DEFAULT '1',
  `OBJ_ID` varchar(36) COLLATE utf8_bin NOT NULL,
   PRIMARY KEY (ID));
   
INSERT into tmp_award_closeout (AWARD_ID, AWARD_NUMBER, SEQUENCE_NUMBER, CLOSEOUT_REPORT_CODE, CLOSEOUT_REPORT_NAME, MULTIPLE,  UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT AWARD_ID, AWARD_NUMBER, SEQUENCE_NUMBER, CLOSEOUT_REPORT_CODE, CLOSEOUT_REPORT_NAME, MULTIPLE,  UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID
FROM award_closeout;

INSERT into tmp_award_closeout(AWARD_ID, AWARD_NUMBER, SEQUENCE_NUMBER, CLOSEOUT_REPORT_CODE, CLOSEOUT_REPORT_NAME, MULTIPLE,  UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT AWARD_ID, AWARD_NUMBER, '1', CLOSEOUT_REPORT_CODE, DESCRIPTION AS CLOSEOUT_REPORT_NAME, 'N',  NOW(), 'Migration', '0', UUID()
FROM closeout_report_type
CROSS JOIN award
WHERE CLOSEOUT_REPORT_CODE <> 'UD';

INSERT award_closeout (AWARD_CLOSEOUT_ID, AWARD_ID, AWARD_NUMBER, SEQUENCE_NUMBER, CLOSEOUT_REPORT_CODE, CLOSEOUT_REPORT_NAME, MULTIPLE,  UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT ID, AWARD_ID, AWARD_NUMBER, SEQUENCE_NUMBER, CLOSEOUT_REPORT_CODE, CLOSEOUT_REPORT_NAME, MULTIPLE,  UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID
FROM tmp_award_closeout
WHERE AWARD_ID NOT IN (SELECT AWARD_ID FROM AWARD_CLOSEOUT);

INSERT seq_award_award_closeout (ID)
SELECT AWARD_CLOSEOUT_ID
FROM award_closeout
WHERE AWARD_CLOSEOUT_ID NOT IN (SELECT ID FROM seq_award_award_closeout);

DROP TEMPORARY TABLE IF EXISTS tmp_award_closeout;








