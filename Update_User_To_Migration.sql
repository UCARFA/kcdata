
START TRANSACTION;

-- update attachment_file
UPDATE attachment_file
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update the award table
UPDATE award
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- Update the award_amount_info
UPDATE award_amount_info
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update award_amount_transaction
UPDATE award_amount_transaction
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update award_attachment_type
UPDATE award_attachment_type
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update award_basis_of_payment
UPDATE award_basis_of_payment
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update award_cgb
UPDATE award_cgb
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update Award_Closeout
UPDATE Award_Closeout
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update Award_Comment
UPDATE Award_Comment
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update award_cost_share
UPDATE award_cost_share
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update Award_custom_data
UPDATE Award_custom_data
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update award_document
UPDATE award_document
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update award_funding_proposals
UPDATE award_funding_proposals
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update award_hierarchy
UPDATE award_hierarchy
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update award_method_of_payment
UPDATE award_method_of_payment
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update award_notepad
UPDATE award_notepad
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'ADMIN';

-- update award_notepad
UPDATE award_notepad
SET CREATE_USER = 'Migration'
WHERE CREATE_USER = 'ADMIN';

-- award_persons
UPDATE award_persons
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update award_person_units
UPDATE award_person_units
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update award_budget_limit
UPDATE award_budget_limit
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update closeout_report_type
UPDATE closeout_report_type
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update comment_type
UPDATE comment_type
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update contact_type
UPDATE contact_type
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- award_report_terms
UPDATE award_report_terms
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- award_sponsor_contacts
UPDATE award_sponsor_contacts
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- award_sponsor_term
UPDATE award_sponsor_term
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- award_status
UPDATE award_status
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update award_unit_contacts
UPDATE award_unit_contacts
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update award_report_notification_sent
UPDATE award_report_notification_sent
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update award_report_tracking
UPDATE award_report_tracking
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update award_report_tracking
UPDATE award_report_tracking
SET LAST_UPDATE_USER = 'Migration';

-- update award_budget_limit
UPDATE award_budget_limit
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update award_attachment
UPDATE award_attachment
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update award_funding_proposals
UPDATE award_funding_proposals
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update award_transaction_type
UPDATE award_transaction_type
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update award_type
UPDATE award_type
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update award_unit_contacts
UPDATE award_unit_contacts
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update cost_share_type
UPDATE cost_share_type
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update custom_attribute
UPDATE custom_attribute
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update custom_attribute_document
UPDATE custom_attribute_document
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update distribution
UPDATE distribution
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update frequency
UPDATE frequency
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update frequency_base
UPDATE frequency_base
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- group_types
UPDATE group_types
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update idc_rate_type
UPDATE  idc_rate_type
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update ip_review
UPDATE ip_review
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update institute_proposal_document
UPDATE institute_proposal_document
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update krew_actn_itm_t
UPDATE krew_actn_itm_t
SET PRNCPL_ID = 'Migration'
WHERE PRNCPL_ID = 'admin';

-- update krew_actn_rqst_t
UPDATE krew_actn_rqst_t
SET PRNCPL_ID = 'Migration'
WHERE PRNCPL_ID = 'admin';

-- update krew_actn_tkn_t
UPDATE krew_actn_tkn_t
SET PRNCPL_ID = 'Migration'
WHERE PRNCPL_ID = 'admin';

-- update krew_doc_hdr_t
UPDATE krew_doc_hdr_t
SET INITR_PRNCPL_ID = 'Migration'
WHERE INITR_PRNCPL_ID = 'admin';

-- update krew_out_box_itm_t
UPDATE krew_out_box_itm_t
SET PRNCPL_ID = 'Migration'
WHERE PRNCPL_ID = 'admin';

-- update krew_doc_hdr_t
UPDATE krew_doc_hdr_t
SET INITR_PRNCPL_ID = 'Migration'
WHERE INITR_PRNCPL_ID = 'admin';

-- update NSF Codes
UPDATE nsf_codes
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update organization
UPDATE organization
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update organization_type_list
UPDATE organization_type_list
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update pending_transactions
UPDATE pending_transactions
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update person_ext_t
UPDATE person_ext_t
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';


-- update proposal
UPDATE proposal
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update proposal_comments
UPDATE proposal_comments
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update proposal_ip_review_join
UPDATE proposal_ip_review_join
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update proposal_persons
UPDATE proposal_persons
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update proposal_person_units
UPDATE proposal_person_units
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update proposal_type
UPDATE proposal_type
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update rate_class
UPDATE rate_class
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update rate_type
UPDATE rate_type
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update report
UPDATE report
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update report_class
UPDATE report_class
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update report_status
UPDATE report_status
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update rolodex
UPDATE rolodex
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update sponsor
UPDATE sponsor
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update sponsor_term
UPDATE sponsor_term
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update transaction details
UPDATE transaction_details
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update time_and_money_document
UPDATE time_and_money_document
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update valid_award_basis_payment
UPDATE valid_award_basis_payment
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update valid_basis_method_pmt
UPDATE valid_basis_method_pmt
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update valid_class_report_freq
UPDATE valid_class_report_freq
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update valid_frequency_base
UPDATE valid_frequency_base
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update version_history
UPDATE version_history
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update unit
UPDATE unit
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';

-- update unit_administrator
UPDATE unit_administrator
SET UPDATE_USER = 'Migration'
WHERE UPDATE_USER = 'admin';



COMMIT;






