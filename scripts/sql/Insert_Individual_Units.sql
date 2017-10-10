 -- Put the variables into the stored procedure and run

  START TRANSACTION;
 
 SELECT @unit_number  := 'PPC'; -- Unit Number
 SELECT @unit_name := 'NCAR-CGD-PPC';  -- Unit Name
 SELECT @parent_unit := 'CGD'; -- Parent Unit Number
 SELECT @active := 'Y';  -- Active Flag (Y or N)


DROP TEMPORARY TABLE IF EXISTS tmp_unit;
CREATE TEMPORARY TABLE tmp_unit (
  UNIT_NUMBER varchar(8) COLLATE utf8_bin NOT NULL DEFAULT '',
  UNIT_NAME varchar(60) COLLATE utf8_bin DEFAULT NULL,
  ORGANIZATION_ID varchar(8) COLLATE utf8_bin DEFAULT NULL,
  UPDATE_TIMESTAMP datetime NOT NULL,
  UPDATE_USER varchar(60) COLLATE utf8_bin NOT NULL,
  VER_NBR decimal(8,0) NOT NULL DEFAULT '1',
  PARENT_UNIT_NUMBER varchar(8) COLLATE utf8_bin DEFAULT NULL,
  OBJ_ID varchar(36) COLLATE utf8_bin NOT NULL,
  ACTIVE_FLAG char(1) COLLATE utf8_bin NOT NULL DEFAULT 'Y');
  
 INSERT tmp_unit(UNIT_NUMBER, UNIT_NAME, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, PARENT_UNIT_NUMBER, OBJ_ID, ACTIVE_FLAG)
 VALUES (@unit_number, @unit_name, NOW(), 'admin', 1, @parent_unit, UUID(), @active);
 
 INSERT INTO UNIT (UNIT_NUMBER,UNIT_NAME, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR ,PARENT_UNIT_NUMBER, OBJ_ID,ACTIVE_FLAG) 
 SELECT UNIT_NUMBER, UNIT_NAME, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, PARENT_UNIT_NUMBER, OBJ_ID, ACTIVE_FLAG
 FROM tmp_unit 
 WHERE unit_number NOT IN (SELECT unit_number from unit);
  
 DROP TEMPORARY TABLE IF EXISTS tmp_unit; 

 COMMIT;
 

 
 

 


