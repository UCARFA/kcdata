-- Update Country Codes (FAPA-469)
-- -------------------------------

START TRANSACTION;

INSERT INTO KRLC_CNTRY_T (POSTAL_CNTRY_CD,POSTAL_CNTRY_NM,PSTL_CNTRY_RSTRC_IND,ACTV_IND,ALT_POSTAL_CNTRY_CD,OBJ_ID,VER_NBR)
VALUES ('AA','Australian Antarctic Territory','N','Y','AAT',UUID(),1),
 ('XD','Diego Garcia','N','Y','XDG',UUID(),1),
 ('XF','French Antilles','N','Y','XFA',UUID(),1),
 ('XG','Guantanamo Bay','N','Y','XGB',UUID(),1),
 ('XM','Multinational','N','Y','XMU',UUID(),1);

UPDATE KRLC_CNTRY_T 
SET POSTAL_CNTRY_NM = 'Cote d''Ivoire' 
WHERE POSTAL_CNTRY_CD = 'CI';

UPDATE KRLC_CNTRY_T 
SET POSTAL_CNTRY_NM = 'Reunion' 
WHERE POSTAL_CNTRY_CD = 'RE';

UPDATE KRLC_CNTRY_T 
SET POSTAL_CNTRY_NM = 'Aland Islands' 
WHERE POSTAL_CNTRY_CD = 'AX';

UPDATE KRLC_CNTRY_T 
SET POSTAL_CNTRY_NM = 'Saint Barthelemy' 
WHERE POSTAL_CNTRY_CD = 'BL';

COMMIT;
