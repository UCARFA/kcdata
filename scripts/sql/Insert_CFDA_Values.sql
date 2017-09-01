DROP TEMPORARY TABLE IF EXISTS cfda_table;
CREATE TEMPORARY TABLE cfda_table (
  `CFDA_NBR` varchar(7) COLLATE utf8_bin NOT NULL,
  `CFDA_PGM_TTL_NM` varchar(300) COLLATE utf8_bin NOT NULL,
  `CFDA_MAINT_TYP_ID` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `ACTIVE_FLAG` varchar(1) COLLATE utf8_bin NOT NULL,
  `VER_NBR` decimal(8,0) NOT NULL DEFAULT '1',
  `OBJ_ID` varchar(36) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`CFDA_NBR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

insert into cfda_table (CFDA_NBR, CFDA_PGM_TTL_NM, CFDA_MAINT_TYP_ID, ACTIVE_FLAG, VER_NBR, OBJ_ID) 
values('60.000', 'NONE', 'MANUAL', 'Y', '1', uuid()),
('02.000', 'UNKNOWN', 'MANUAL', 'Y', '1', uuid()),
('10.000', 'Department of Agriculture - Default', 'MANUAL', 'Y', '1', uuid()),
('11.000', 'Department of Commerce - Default', 'MANUAL', 'Y', '1', uuid()),
('12.000', 'Department of Defense - Default', 'MANUAL', 'Y', '1', uuid()),
('15.000', 'Department of the Interior - Default', 'MANUAL', 'Y', '1', uuid()),
('19.000', 'Department of State - Default', 'MANUAL', 'Y', '1', uuid()),
('20.000', 'Department of Transportation - Default', 'MANUAL', 'Y', '1', uuid()),
('42.000', 'Library of Congress - Default', 'MANUAL', 'Y', '1', uuid()),
('43.000', 'National Aeronautics and Space Administration - Default', 'MANUAL', 'Y', '1', uuid()),
('47.000', 'National Science Foundation - Default', 'MANUAL', 'Y', '1', uuid()),
('66.000', 'Environmental Protection Agency - Default', 'MANUAL', 'Y', '1', uuid()),
('81.000', 'Department of Energy - Default', 'MANUAL', 'Y', '1', uuid()),
('84.000', 'Department of Education - Default', 'MANUAL', 'Y', '1', uuid()),
('93.000', 'Department of Health and Human Services - Default', 'MANUAL', 'Y', '1', uuid()),
('97.000', 'Department of Homeland Security - Default', 'MANUAL', 'Y', '1', uuid()),
('98.000', 'Agency for International Development - Default', 'MANUAL', 'Y', '1', uuid());

UPDATE cfda
INNER JOIN cfda_table ct
ON cfda.CFDA_NBR = ct.CFDA_NBR
SET cfda.CFDA_PGM_TTL_NM = ct.CFDA_PGM_TTL_NM
WHERE cfda.CFDA_MAINT_TYP_ID = 'MANUAL' ;

INSERT cfda (CFDA_NBR, CFDA_PGM_TTL_NM, CFDA_MAINT_TYP_ID, ACTIVE_FLAG, VER_NBR, OBJ_ID) 
SELECT CFDA_NBR, CFDA_PGM_TTL_NM, CFDA_MAINT_TYP_ID, ACTIVE_FLAG, VER_NBR, OBJ_ID
FROM cfda_table WHERE CFDA_NBR NOT IN (SELECT CFDA_NBR FROM CFDA);





