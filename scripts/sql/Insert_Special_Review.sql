
select * from special_review;
select * from eps_prop_special_review;
select * from proposal_special_review;
select * from special_review_usage;
select * from valid_sp_rev_approval;
select * from sp_rev_approval_type;


START TRANSACTION;

INSERT SPECIAL_REVIEW(SPECIAL_REVIEW_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID, SORT_ID)
VALUES (100,'Not Applicable', NOW(),	'admin',	1,	UUID(),	1);

UPDATE special_review_usage
	SET SPECIAL_REVIEW_CODE =   100;
                               
UPDATE valid_sp_rev_approval
	SET SPECIAL_REVIEW_CODE =   100;
    
DELETE FROM SPECIAL_REVIEW
WHERE SPECIAL_REVIEW_CODE < 100 ;

COMMIT;
                               
                                							