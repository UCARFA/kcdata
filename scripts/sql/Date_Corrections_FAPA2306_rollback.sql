-- ------------------------------------------------------------------------------
-- FAPA - 2306 Rollback
-- SJW 4/26/18

-- ------------------------------------------------------------------------------
-- ROLLBACK Project Start Date - Table: award, Column: award_effective_date

UPDATE award a, rollback_FAPA2306 rb
SET a.award_effective_date = rb.award_effective_date
WHERE a.fin_chart_of_accounts_code = rb.contract_id
AND a.MODIFICATION_NUMBER = rb.mod_number
and rb.current_fund_effective_date is null
and a.AWARD_EFFECTIVE_DATE != rb.award_effective_date;


-- ------------------------------------------------------------------------------
-- ROLLBACK Obligation Start Date - Table: award_amount_info, Column: current_fund_effective_date

UPDATE award a, award_amount_info ai, rollback_FAPA2306 rb
SET ai.current_fund_effective_date = rb.current_fund_effective_date
WHERE a.award_id = ai.award_id
and a.fin_chart_of_accounts_code = rb.contract_id
and a.modification_number = rb.mod_number
and rb.current_fund_effective_date is not null
and ai.current_fund_effective_date != rb.current_fund_effective_date;
