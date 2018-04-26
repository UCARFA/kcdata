-- Create user 'dbupdate' for direct database updates

INSERT INTO KRIM_ENTITY_ID_S VALUES(NULL);
INSERT INTO KRIM_ENTITY_NM_ID_S VALUES(NULL);
INSERT INTO KRIM_ENTITY_T (ACTV_IND,ENTITY_ID,LAST_UPDT_DT,OBJ_ID,VER_NBR)
  VALUES ('Y',(SELECT (MAX(ID)) FROM KRIM_ENTITY_ID_S),now(),UUID(),1);

INSERT INTO KRIM_ENTITY_NM_T (ENTITY_NM_ID,ENTITY_ID,FIRST_NM,LAST_NM,NM_TYP_CD,DFLT_IND,ACTV_IND,LAST_UPDT_DT,OBJ_ID,VER_NBR) 
VALUES ((SELECT (MAX(ID)) FROM KRIM_ENTITY_NM_ID_S),(SELECT (MAX(ID)) FROM KRIM_ENTITY_ID_S),'Database','Update','PRM','Y','Y',now(),UUID(),1);

INSERT INTO KRIM_PRNCPL_ID_S VALUES(NULL);

INSERT INTO KRIM_PRNCPL_T (ACTV_IND,ENTITY_ID,LAST_UPDT_DT,OBJ_ID,PRNCPL_ID,PRNCPL_NM, PRNCPL_PSWD, VER_NBR)
  VALUES ('Y',(SELECT (MAX(ID)) FROM KRIM_ENTITY_ID_S),now(),UUID(),(SELECT (MAX(ID)) FROM KRIM_PRNCPL_ID_S),'dbupdate','J!gsawPu22le',1);