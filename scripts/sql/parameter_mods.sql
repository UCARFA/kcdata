-- Disable Credit Splits (FAPA-413)
-- --------------------------------

UPDATE krcr_parm_t SET VAL = 'N' WHERE PARM_NM = "award.creditsplit.enabled";

UPDATE krcr_parm_t SET VAL = 'N' WHERE PARM_NM = "institutionalproposal.creditsplit.enabled";

UPDATE krcr_parm_t SET VAL = 'N' WHERE PARM_NM = "proposaldevelopment.creditsplit.enabled";

-- Disable PI Certification for IP Awards (FAPA-474)

UPDATE krcr_parm_t SET VAL = '0' WHERE PARM_NM = "awardUncertifiedKeyPersonnel";
