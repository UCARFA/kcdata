-- ------------------------------------------------------------------------------
-- FAPA - 2305 Rollback
-- SJW 4/26/18

-- ------------------------------------------------------------------------------
-- ROLLBACK Project Start Date - Table: award, Column: award_effective_date

UPDATE award a, rollback_FAPA2305 rb
SET a.award_effective_date = rb.award_effective_date
WHERE a.fin_chart_of_accounts_code = rb.contract_id
and a.modification_number = rb.mod_number
and a.award_effective_date != rb.award_effective_date
and rb.award_effective_date is not null;

-- ------------------------------------------------------------------------------
-- ROLLBACK Project End Date - Table: award_amount_info, Column: final_expiration_date

UPDATE award a, award_amount_info ai, rollback_FAPA2305 rb
SET ai.final_expiration_date = rb.final_expiration_date
WHERE a.award_id = ai.award_id
and a.fin_chart_of_accounts_code = rb.contract_id
and a.modification_number = rb.mod_number
and rb.final_expiration_date is not null
and ai.final_expiration_date != rb.final_expiration_date;

-- ------------------------------------------------------------------------------
-- ROLLBACK Obligation Start Date - Table: award_amount_info, Column: current_fund_effective_date

UPDATE award a, award_amount_info ai, rollback_FAPA2305 rb
SET ai.current_fund_effective_date = rb.current_fund_effective_date
WHERE a.award_id = ai.award_id
and a.fin_chart_of_accounts_code = rb.contract_id
and a.modification_number = rb.mod_number
and rb.current_fund_effective_date is not null
and ai.current_fund_effective_date != rb.current_fund_effective_date;

-- ------------------------------------------------------------------------------
-- ROLLBACK Obligation End Date - Table: award_amount_info, Column: obligation_expiration_date

UPDATE award a, award_amount_info ai, rollback_FAPA2305 rb
SET ai.obligation_expiration_date = rb.obligation_expiration_date
WHERE a.award_id = ai.award_id
and a.fin_chart_of_accounts_code = rb.contract_id
and a.modification_number = rb.mod_number
and rb.obligation_expiration_date is not null
and ai.obligation_expiration_date != rb.obligation_expiration_date;

