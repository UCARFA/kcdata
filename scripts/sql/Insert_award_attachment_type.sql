select * from award_attachment;
select * from award_attachment_type;


START TRANSACTION;

SELECT * FROM award_attachment_type;

INSERT award_attachment_type (TYPE_CODE, DESCRIPTION, VER_NBR, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
VALUES  

(100, 'AWARD-Base Agreement', 1, NOW(), 'admin', UUID()),
(110, 'AWARD-Budget',1, NOW(), 'admin', UUID()),
(120, 'AWARD-Modification',1, NOW(), 'admin', UUID()),
(130, 'AWARD-Proposal/SOW',1, NOW(), 'admin', UUID()),
(140, 'AWARD-Small Business Plan',1, NOW(), 'admin', UUID()),
(150, 'AWARD-Supporting Document',1, NOW(), 'admin', UUID()),
(160, 'AWARD-Terms and Conditions',1, NOW(), 'admin', UUID()),
(170, 'OTHER',1, NOW(), 'admin', UUID()),
(180, 'RELATED AGREEMENT-Export License',1, NOW(), 'admin', UUID()),
(190, 'RELATED AGREEMENT-Technical Assistance Agreement',1, NOW(), 'admin', UUID()),
(200, 'RELATED AGREEMENT-Foreign Currency Agreement/Forward Pricing Contract',1, NOW(), 'admin', UUID()),
(210, 'RELATED AGREEMENT-Intellectual Property License',1, NOW(), 'admin', UUID()),
(220, 'RELATED AGREEMENT-Non-Disclosure Agreement',1, NOW(), 'admin', UUID()),
(230, 'REPORT-Closeout',1, NOW(), 'admin', UUID()),
(240, 'REPORT-Contracts',1, NOW(), 'admin', UUID()),
(250, 'REPORT-Entity/Lab/Program',1, NOW(), 'admin', UUID()),
(260, 'REPORT-Finance',1, NOW(), 'admin', UUID()),
(270, 'REPORT-Invoice',1, NOW(), 'admin', UUID()),
(280, 'REPORT-Legal',1, NOW(), 'admin', UUID()),
(290, 'REPORT-Procurement',1, NOW(), 'admin', UUID()),
(300, 'REPORT-Property',1, NOW(), 'admin', UUID());

SELECT * FROM award_attachment_type;

SELECT * FROM AWARD_ATTACHMENT;

UPDATE AWARD_ATTACHMENT
SET TYPE_CODE = 170 
WHERE TYPE_CODE IN (1,2,3,4,5,6,7,28,29,30);

DELETE FROM award_attachment_type
WHERE TYPE_CODE < 100;

SELECT * FROM award_attachment_type;

COMMIT;