
  DROP TEMPORARY TABLE IF EXISTS tmp_krim_role_perm_t;
  CREATE TEMPORARY TABLE tmp_krim_role_perm_t (
  ROLE_PERM_ID varchar(40) COLLATE utf8_bin NOT NULL DEFAULT '',
  OBJ_ID varchar(36) COLLATE utf8_bin NOT NULL,
  VER_NBR decimal(8,0) NOT NULL DEFAULT '1',
  ROLE_ID varchar(40) COLLATE utf8_bin NOT NULL,
  PERM_ID varchar(40) COLLATE utf8_bin NOT NULL,
  ACTV_IND varchar(1) COLLATE utf8_bin DEFAULT 'Y');
  
INSERT tmp_krim_role_perm_t(ROLE_PERM_ID, OBJ_ID, VER_NBR, ROLE_ID, PERM_ID, ACTV_IND)
VALUES('2179',	UUID(),	'2',	'1907',	'10018',	'N'),
('2185',	UUID(),	'1',	'1907',	'10018',	'Y'),
('2176',	UUID(),	'1',	'1907',	'10026',	'Y'),
('2177',	UUID(),	'1',	'1907',	'10027',	'Y');


INSERT krim_role_perm_t (ROLE_PERM_ID, OBJ_ID, VER_NBR, ROLE_ID, PERM_ID, ACTV_IND)
SELECT ROLE_PERM_ID, OBJ_ID, VER_NBR, ROLE_ID, PERM_ID, ACTV_IND
FROM tmp_krim_role_perm_t
WHERE ROLE_ID NOT IN (SELECT ROLE_ID FROM krim_role_perm_t);


DROP TEMPORARY TABLE IF EXISTS tmp_krim_role_perm_t;

/*select * 
from krim_perm_attr_data_t 
where perm_id in ('10026', '10018', '10027');*/

/*SELECT * 
FROM Krim_perm_t
WHERE NM IN ('View Proposal', 'View Award Attachments','View Award') ;*/

/*SELECT *
FROM krim_role_t
WHERE role_id IN  ('1907');*/

/*SELECT *
FROM krim_role_perm_t
WHERE ROLE_ID IN  ('1907')
AND perm_id in ('10026', '10018', '10027');*/

/*SELECT *
FROM krim_role_perm_v
WHERE ROLE_ID IN  ('1907')
AND perm_id in ('10026', '10018', '10027');*/

/*SELECT *
FROM krim_role_perm_id_s
WHERE ID IN ('1907')*/

/*select * from krim_attr_defn_t;
select * from krim_perm_tmpl_t;
select * from krim_role_tmpl_t;*/






