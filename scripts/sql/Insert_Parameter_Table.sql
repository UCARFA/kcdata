DROP TEMPORARY TABLE IF EXISTS tmp_krcr_parm_t;
CREATE TEMPORARY TABLE `tmp_krcr_parm_t` (
  `NMSPC_CD` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `CMPNT_CD` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '',
  `PARM_NM` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `OBJ_ID` varchar(36) COLLATE utf8_bin NOT NULL,
  `VER_NBR` decimal(8,0) NOT NULL DEFAULT '1',
  `PARM_TYP_CD` varchar(5) COLLATE utf8_bin NOT NULL,
  `VAL` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `PARM_DESC_TXT` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `EVAL_OPRTR_CD` varchar(1) COLLATE utf8_bin DEFAULT NULL,
  `APPL_ID` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`NMSPC_CD`,`CMPNT_CD`,`PARM_NM`,`APPL_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Create SQL script for Kuali Parameters (FAPA-2091)
-- ------------------------------------------------

INSERT INTO tmp_krcr_parm_t (NMSPC_CD, CMPNT_CD, PARM_NM, PARM_TYP_CD, VAL, PARM_DESC_TXT, EVAL_OPRTR_CD, APPL_ID, VER_NBR, OBJ_ID)
VALUES ('KC-AWARD', 'All', 'HTTPPOST_CFDA_INFO', 'CONFG', 'true', 'Enable sending of new CFDA information to message queue', 'A', 'KC', 1, UUID()),
('KC-AWARD', 'All', 'HTTPPOST_AWARDTYPE_INFO', 'CONFG', 'true', 'Enable sending of new award type information to message queue', 'A', 'KC', 1, UUID()),
('KC-AWARD', 'All', 'HTTPPOST_AWARD_INFO', 'CONFG', 'true', 'Enable sending of new award information to message queue', 'A', 'KC', 1, UUID()),
('KC-AWARD', 'All', 'HTTPPOST_PAYMENTBASIS_INFO', 'CONFG', 'true', 'Enable sending of new payment basis information to message queue', 'A', 'KC', 1, UUID()),
('KC-GEN', 'All', 'ACTIVEMQ_KEYPARTS_URL', 'CONFG', 'http://fatomcat-test:8161/api/message?destination=KUALIIFASKEYPARTS&type=queue', 'ActiveMQ IFAS Key Parts URL', 'A', 'KC', 1, UUID()),
('KC-GEN', 'All', 'USE_AD_AUTH_ROLE', 'CONFG', 'false', 'Enable use of AD role for authentication', 'A', 'KC', 1, UUID()),
('KC-GEN', 'All', 'AD_AUTH_ROLE', 'CONFG', 'Kuali Users', 'AD role for authentication.  Must set parm USE_AD_AUTH_ROLE to true.', 'A', 'KC', 1, UUID()),
('KC-GEN', 'All', 'CUSTOM_ATTRIBUTE_SORT', 'CONFG', 'alpha', 'Sort value (id or alpha) for Custom Attributes', 'A', 'KC', 1, UUID());

-- ------------------------------------------------

INSERT INTO krcr_parm_t (NMSPC_CD, CMPNT_CD, PARM_NM, PARM_TYP_CD, VAL, PARM_DESC_TXT, EVAL_OPRTR_CD, APPL_ID, VER_NBR, OBJ_ID)
SELECT NMSPC_CD, CMPNT_CD, PARM_NM, PARM_TYP_CD, VAL, PARM_DESC_TXT, EVAL_OPRTR_CD, APPL_ID, VER_NBR, OBJ_ID
FROM tmp_krcr_parm_t WHERE PARM_NM NOT IN (SELECT PARM_NM FROM krcr_parm_t);

DROP TEMPORARY TABLE IF EXISTS tmp_krcr_parm_t;
