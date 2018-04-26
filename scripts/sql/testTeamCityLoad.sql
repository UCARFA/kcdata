DROP TEMPORARY TABLE IF EXISTS tmp_testCSVLoad;

CREATE TEMPORARY TABLE `tmp_testCSVLoad` (
`contract_id` varchar(10) collate utf8_bin NOT NULL DEFAULT '',
`mod_number` varchar(50) collate utf8_bin NOT NULL DEFAULT '',
`new_proj_start_date` varchar(15) collate utf8_bin NOT NULL DEFAULT '',
`new_obl_start_date` varchar(15) collate utf8_bin NOT NULL DEFAULT ''
);

LOAD DATA LOCAL INFILE 'scripts\\sql\\dataFiles\\testLoad2.csv'
-- LOAD DATA LOCAL INFILE '~/git/kcdata/scripts/sql/dataFiles/testLoad.csv'
INTO TABLE tmp_testCSVLoad
FIELDS TERMINATED BY ','
IGNORE 1 LINES
(contract_id, mod_number, new_proj_start_date, new_obl_start_date)
;
