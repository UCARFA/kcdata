START TRANSACTION;

SELECT * FROM cost_share_type;

INSERT cost_share_type (COST_SHARE_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
VALUES (100, 'Contribution', NOW(),'admin', 1, UUID()), 
 (110, 'In Kind', NOW(),'admin', 1, UUID()), 
 (120, 'Other', NOW(),'admin', 1, UUID()),
 (130, 'Residual', NOW(),'admin', 1, UUID()),
 (140, 'STORM', NOW(),'admin', 1, UUID());

SELECT * FROM cost_share_type;

SELECT * FROM award_cost_share;

UPDATE award_cost_share
SET COST_SHARE_TYPE_CODE = 110
WHERE COST_SHARE_TYPE_CODE = 24;

SELECT * FROM award_cost_share;


SELECT * FROM cost_share_type;

DELETE FROM cost_share_type
WHERE COST_SHARE_TYPE_CODE < 100;

SELECT * FROM cost_share_type;

COMMIT;
