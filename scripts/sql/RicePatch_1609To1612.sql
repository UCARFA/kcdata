-- V1611_001__lookup_distinct.sql

INSERT INTO KRCR_PARM_T (APPL_ID, NMSPC_CD, CMPNT_CD, PARM_NM, VAL, PARM_DESC_TXT, PARM_TYP_CD, EVAL_OPRTR_CD, OBJ_ID, VER_NBR)
VALUES ('KUALI', 'KR-NS', 'Lookup', 'RESULTS_DISTINCT', 'Y', 'Whether to apply the distinct flag to lookup requests.', 'CONFG', 'A', UUID(), 1);

-- V1611_003__version_history_sort.sql

INSERT INTO KRCR_PARM_T (APPL_ID, NMSPC_CD, CMPNT_CD, PARM_NM, VAL, PARM_DESC_TXT, PARM_TYP_CD, EVAL_OPRTR_CD, OBJ_ID, VER_NBR)
VALUES ('KC', 'KC-AWARD', 'All', 'SORT_TIME_AND_MONEY_TRANSACTIONS_DESCENDING', 'N', 'Sort time and money transaction history in descending order.', 'CONFG', 'A', UUID(), 1);

--  V1612_001__RESKC-1441_credit_split.sql

INSERT INTO KRCR_PARM_T (APPL_ID, NMSPC_CD, CMPNT_CD, PARM_NM, VAL, PARM_DESC_TXT, PARM_TYP_CD, EVAL_OPRTR_CD, OBJ_ID, VER_NBR)
VALUES ('KC', 'KC-PD', 'All', 'ENABLE_OPT_IN_PERSONNEL_CREDIT_SPLIT_FUNCTIONALITY', 'N', 'This flag when enabled will give the proposal creator the ability to choose which persons to add credit split for.', 'CONFG', 'A', UUID(), 1);
