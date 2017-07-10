select * from idc_rate_type;
select * from rate_type;
select * from rate_class;
select * from proposal_idc_rate;

START TRANSACTION;

INSERT idc_rate_type(IDC_RATE_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
VALUES  (100, ' Reduced IDC - MTDC', NOW(), 'admin', 1, UUID()),
		(110, ' Reduced IDC - TDC', NOW(), 'admin', 1, UUID()),
        (120, ' Reduced Benefit', NOW(), 'admin', 1, UUID());
 
/* 
DELETE FROM idc_rate_type
WHERE IDC_RATE_TYPE_CODE < 100;
*/
        
UPDATE krcr_parm_t
SET VAL = 0
WHERE PARM_NM = 'enable.award.FnA.validation';

INSERT RATE_CLASS(RATE_CLASS_CODE, DESCRIPTION, RATE_CLASS_TYPE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
VALUES ('13','F&A - Award', 'O', NOW(), 'admin', 1, UUID());

INSERT RATE_TYPE(RATE_CLASS_CODE, RATE_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
VALUES('13', '100', 'Reduced IDC - MTDC', NOW(), 'admin', 1, UUID()),
('13', '110', 'Reduced IDC - TDC', NOW(), 'admin', 1, UUID()),
('13', '120', 'Reduced Benefit', NOW(), 'admin', 1, UUID());
 
COMMIT;