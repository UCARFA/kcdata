start transaction;

UPDATE custom_attribute
SET group_name = 'Additional Primary Proposal Information'
WHERE ID in ('1','2','3');

/*
DELETE from custom_attribute_id
WHERE ID = 4

DELETE from custom_attribute
WHERE ID = 4;
*/

INSERT custom_attribute(ID, NAME, LABEL, DATA_TYPE_CODE, DATA_LENGTH, group_name, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
VALUES (160,'awardCeilingValue','Award Ceiling Value',2,25,'Award Information',NOW(),'admin', 0, UUID()),
(150,'awardFloorValue','Award Floor Value',2,25,'Award Information',NOW(),'admin', 0, UUID()),
(140,'awardCFDALocation','CFDA Location on Award',1,100,'Award Information',NOW(),'admin', 0, UUID()),
(130,'awardCostLimitation','Cost Limitation (Percentage)',2,2,'Award Information',NOW(),'admin', 0, UUID()),
(120,'awardCostLimitNotifyPeriod','Cost Limitation Notice (#days)',2,3,'Award Information',NOW(),'admin', 0, UUID()),
(110,'awardFinalCloseDate','Final Close Date',3,10,'Award Information',NOW(),'admin', 0, UUID()),
(100,'awardCurrencyType','Foreign Currency Type',1,50,'Award Information',NOW(),'admin', 0, UUID()),
(230,'awardFileLocationNotes','File Location Notes',1,100, 'File & Archive Information',NOW(),'admin', 0, UUID()),
(220,'awardDateCheckedOut','Date Checked Out',3,10, 'File & Archive Information',NOW(),'admin', 0, UUID()),
(210,'awardDateSendToArchive','Date to Send to Archive',3,10, 'File & Archive Information',NOW(),'admin', 0, UUID()),
(200,'awardArchiveBoxNumber','Archive Box Number',1,25, 'File & Archive Information',NOW(),'admin', 0, UUID());

INSERT custom_attribute_document(DOCUMENT_TYPE_CODE, CUSTOM_ATTRIBUTE_ID, IS_REQUIRED, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, ACTIVE_FLAG, OBJ_ID)
VALUES('AWRD', 100, 'N', NOW(), 'admin', 0, 'Y', UUID()),
('AWRD', 110, 'N', NOW(), 'admin', 0, 'Y', UUID()),
('AWRD', 120, 'N', NOW(), 'admin', 0, 'Y', UUID()),
('AWRD', 130, 'N', NOW(), 'admin', 0, 'Y', UUID()),
('AWRD', 140, 'N', NOW(), 'admin', 0, 'Y', UUID()),
('AWRD', 150, 'N', NOW(), 'admin', 0, 'Y', UUID()),
('AWRD', 160, 'N', NOW(), 'admin', 0, 'Y', UUID()),
('AWRD', 200, 'N', NOW(), 'admin', 0, 'Y', UUID()),
('AWRD', 210, 'N', NOW(), 'admin', 0, 'Y', UUID()),
('AWRD', 220, 'N', NOW(), 'admin', 0, 'Y', UUID()),
('AWRD', 230, 'N', NOW(), 'admin', 0, 'Y', UUID());


select * from custom_attribute
order by 9,1;

Select * from custom_attribute_document
commit;
