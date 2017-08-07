START TRANSACTION;

SELECT * FROM comment_type;
select * from award_comment;
select * from proposal_comments;
select * from award_template_comments;
select * from krcr_parm_t;


UPDATE comment_type
SET DESCRIPTION = 'Contracts Comments'
WHERE COMMENT_TYPE_CODE = '2';

UPDATE comment_type
SET DESCRIPTION = 'Finance Comments'
WHERE COMMENT_TYPE_CODE = '3';

UPDATE comment_type
SET DESCRIPTION = 'Lab/Program Comments'
WHERE COMMENT_TYPE_CODE = '4';

UPDATE comment_type
SET DESCRIPTION = 'Legal Comments'
WHERE COMMENT_TYPE_CODE = '5';

UPDATE comment_type
SET DESCRIPTION = 'Procurement Comments'
WHERE COMMENT_TYPE_CODE = '6';

INSERT comment_type (COMMENT_TYPE_CODE, DESCRIPTION, TEMPLATE_FLAG, CHECKLIST_FLAG, AWARD_COMMENT_SCREEN_FLAG, VER_NBR, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
VALUES  
('22',	'Property Comments',	'Y', 'N', 'Y', 1,	NOW(),	'admin',	UUID()); 

UPDATE award_comment
SET COMMENT_TYPE_CODE = '6' 
WHERE COMMENT_TYPE_CODE = '5';

UPDATE award_comment
SET COMMENT_TYPE_CODE = '22' 
WHERE COMMENT_TYPE_CODE = '6';


UPDATE proposal_comments
SET COMMENT_TYPE_CODE = '6' 
WHERE COMMENT_TYPE_CODE = '5';

UPDATE proposal_comments
SET COMMENT_TYPE_CODE = '22' 
WHERE COMMENT_TYPE_CODE = '6';


-- This could be an issue with other versions of Kuali  You will need to locate the new OBJ_ID once that is changed.

UPDATE krcr_parm_t
SET VALUE = '2,3,4,5,6,22'
Where PARM_NM = 'scope.sync.COMMENTS_TAB.AwardComment.commentTypeCode';

COMMIT;




