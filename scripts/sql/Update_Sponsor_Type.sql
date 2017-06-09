start transaction;

select * from sponsor_type;

-- Modify Sponsor Types FAPA-438, FAPA-566 (changes)
-- -------------------------------------------------
DELETE FROM SPONSOR_TYPE 
WHERE DESCRIPTION IN ('Foundation', 'Foreign Foundation', 'Local Government', 'Foreign Local Government');

INSERT INTO SPONSOR_TYPE (SPONSOR_TYPE_CODE,DESCRIPTION,UPDATE_USER,UPDATE_TIMESTAMP,OBJ_ID,VER_NBR) 
VALUES ('002','US Department of Defense','admin',NOW(),UUID(),1),
 ('007','US FFRDC Commercial','admin',NOW(),UUID(),1),
 ('008','US FFRDC Non-Profit','admin',NOW(),UUID(),1),
 ('009','US FFRDC Institution of Higher Education','admin',NOW(),UUID(),1),
 ('011','Foreign Military','admin',NOW(),UUID(),1);


UPDATE SPONSOR_TYPE 
SET DESCRIPTION = 'US Federal', SPONSOR_TYPE_CODE = '001' 
WHERE DESCRIPTION = 'Federal';

UPDATE SPONSOR_TYPE 
SET DESCRIPTION = 'US State/Local', SPONSOR_TYPE_CODE = '003' 
WHERE DESCRIPTION = 'State';

UPDATE SPONSOR_TYPE 
SET DESCRIPTION = 'US Commercial', SPONSOR_TYPE_CODE = '004' 
WHERE DESCRIPTION = 'Private Profit';

UPDATE SPONSOR_TYPE 
SET DESCRIPTION = 'US Non-Profit', SPONSOR_TYPE_CODE = '005'  
WHERE DESCRIPTION = 'Private Non-Profit';

UPDATE SPONSOR_TYPE 
SET DESCRIPTION = 'US Institution of Higher Education', SPONSOR_TYPE_CODE = '006' 
WHERE DESCRIPTION = 'Institution of Higher Education';

UPDATE SPONSOR_TYPE 
SET DESCRIPTION = 'Foreign Federal', SPONSOR_TYPE_CODE = '010' 
WHERE DESCRIPTION = 'Foreign Federal Government';

UPDATE SPONSOR_TYPE 
SET DESCRIPTION = 'Foreign State/Local', SPONSOR_TYPE_CODE = '012' 
WHERE DESCRIPTION = 'Foreign State Government';

UPDATE SPONSOR_TYPE 
SET DESCRIPTION = 'Foreign Commercial', SPONSOR_TYPE_CODE = '013' 
WHERE DESCRIPTION = 'Foreign Private Profit';

UPDATE SPONSOR_TYPE 
SET DESCRIPTION = 'Foreign Non-Profit', SPONSOR_TYPE_CODE = '014'  
WHERE DESCRIPTION = 'Foreign Private Non-Profit';

UPDATE SPONSOR_TYPE 
SET SPONSOR_TYPE_CODE = '015' 
WHERE DESCRIPTION = 'Foreign Institution of Higher Education';

COMMIT;


