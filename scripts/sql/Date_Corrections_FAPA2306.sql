-- ------------------------------------------------------------------------------
-- FAPA - 2306
-- SJW 4/26/18

-- Create Source Temp Table

DROP TEMPORARY TABLE IF EXISTS tmp_date_corrections;

CREATE TEMPORARY TABLE `tmp_date_corrections` (
`contract_id` varchar(10) collate utf8_bin NOT NULL DEFAULT '',
`mod_number` varchar(50) collate utf8_bin NOT NULL DEFAULT '',
`new_proj_start_date` varchar(15) collate utf8_bin NOT NULL DEFAULT '',
`new_obl_start_date` varchar(15) collate utf8_bin NOT NULL DEFAULT ''
);

-- Mac/UNIX - LOAD DATA LOCAL INFILE '~/git/kcdata/scripts/sql/dataFiles/dateCorrections_FAPA2306.csv'
-- WINDOWS (fateam) - 
LOAD DATA LOCAL INFILE '.\scripts\sql\dataFiles\dateCorrections_FAPA2306.csv'
INTO TABLE tmp_date_corrections
FIELDS TERMINATED BY ','
IGNORE 1 LINES
(contract_id, mod_number, new_proj_start_date, new_obl_start_date)
;

-- ------------------------------------------------------------------------------
-- Create Rollback Temp Table

DROP TEMPORARY TABLE IF EXISTS tmp_FAPA2306_rollback;

CREATE TEMPORARY TABLE `tmp_FAPA2306_rollback` (
`contract_id` varchar(10) collate utf8_bin NOT NULL DEFAULT '',
`mod_number` varchar(50) collate utf8_bin NOT NULL DEFAULT '',
`award_effective_date` datetime,
`current_fund_effective_date` datetime
);

-- ------------------------------------------------------------------------------
-- Project Start Date - Table: award, Column: award_effective_date

-- Backup project start date records
INSERT INTO tmp_FAPA2306_rollback (contract_id, mod_number, award_effective_date)
SELECT a.fin_chart_of_accounts_code, a.modification_number, a.award_effective_date
FROM award a, tmp_date_corrections tdc
WHERE a.fin_chart_of_accounts_code = tdc.contract_id
AND a.modification_number = tdc.mod_number
AND tdc.new_proj_start_date != ''
AND tdc.new_proj_start_date IS NOT NULL
AND a.award_effective_date != CONCAT((STR_TO_DATE(tdc.new_proj_start_date, '%m/%d/%Y')),' ','00:00:00');

-- Update award project start date
UPDATE award a, tmp_date_corrections tdc
SET a.award_effective_date = CONCAT((STR_TO_DATE(tdc.new_proj_start_date, '%m/%d/%Y')),' ','00:00:00'),
a.update_user = 'dbupdate', a.update_timestamp = now()
WHERE a.fin_chart_of_accounts_code = tdc.contract_id
AND a.modification_number = tdc.mod_number
AND tdc.new_proj_start_date != ''
AND tdc.new_proj_start_date IS NOT NULL
AND a.award_effective_date != CONCAT((STR_TO_DATE(tdc.new_proj_start_date, '%m/%d/%Y')),' ','00:00:00');

-- ------------------------------------------------------------------------------
-- Obligation Start Date - Table: award_amount_info, Column: current_fund_effective_date

-- Backup obligation start date records
INSERT INTO tmp_FAPA2306_rollback (contract_id, mod_number, current_fund_effective_date)
SELECT a.fin_chart_of_accounts_code, a.modification_number, ai.current_fund_effective_date
FROM award a, award_amount_info ai, tmp_date_corrections tdc
WHERE a.award_id = ai.award_id
AND a.fin_chart_of_accounts_code = tdc.contract_id
AND a.modification_number = tdc.mod_number
AND tdc.new_obl_start_date != ''
AND tdc.new_obl_start_date IS NOT NULL
AND ai.current_fund_effective_date != CONCAT((STR_TO_DATE(tdc.new_obl_start_date, '%m/%d/%Y')),' ','00:00:00');

-- Update obligation start date
UPDATE award a, award_amount_info ai, tmp_date_corrections tdc
SET ai.current_fund_effective_date = CONCAT((STR_TO_DATE(tdc.new_obl_start_date, '%m/%d/%Y')),' ','00:00:00'),
ai.update_user = 'dbupdate', ai.update_timestamp = now()
WHERE a.award_id = ai.award_id
AND a.FIN_CHART_OF_ACCOUNTS_CODE = tdc.contract_id
AND a.modification_number = tdc.mod_number
AND tdc.new_obl_start_date != ''
AND tdc.new_obl_start_date IS NOT NULL
AND ai.current_fund_effective_date != CONCAT((STR_TO_DATE(tdc.new_obl_start_date, '%m/%d/%Y')),' ','00:00:00');

DROP TEMPORARY TABLE IF EXISTS tmp_date_corrections;