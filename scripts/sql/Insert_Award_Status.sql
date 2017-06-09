 START TRANSACTION;
 
select * from award_status;
select * from award_template;

INSERT INTO award_status
           (VER_NBR
           ,STATUS_CODE
           ,DESCRIPTION
           ,UPDATE_TIMESTAMP
           ,UPDATE_USER
		   ,OBJ_ID
            )
           
           SELECT 1 as VER_NBR, 
           7 AS STATUS_CODE, 
           'WRAP' AS DESCRIPTION, 
           NOW() AS UPDATE_TIMESTAMP,
           'admin' AS UPDATE_USER,
		   UUID() AS OBJ_ID;
           
			UPDATE award_status
			SET DESCRIPTION = 'In Closeout' 
			WHERE STATUS_CODE = 4;
           
SELECT *
FROM award_status;

       
COMMIT;
           