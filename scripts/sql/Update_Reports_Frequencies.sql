-- this is related to jira ticket #622

-- report class 

START TRANSACTION;



/*

SELECT * FROM award_report_terms;
SELECT * FROM report_class
order by 3;
select * from report;
select * from frequency
order by 3;
select * from frequency_base;
select * from distribution;
SELECT * FROM award_template_report_terms;
select * from valid_frequency_base;
select * from valid_class_report_freq;
select * from award;
select * from closeout_report_type;
select * from award_closeout;
select * from krcr_parm_t;
select * from report_status;
select * from award_payment_schedule;
select * from seq_award_award_closeout;
select * from seq_report_id;
select * from seq_valid_class_report_freq;
*/

-- Report Status


--  updating existing values

UPDATE REPORT_STATUS
SET Description = 'Approved Internally'
WHERE REPORT_STATUS_CODE = 1 ;

UPDATE REPORT_STATUS
SET Description = 'Due'
WHERE REPORT_STATUS_CODE = 2 ;

UPDATE REPORT_STATUS
SET Description = 'Pending'
WHERE REPORT_STATUS_CODE = 3 ;

UPDATE REPORT_STATUS
SET Description = 'Received'
WHERE REPORT_STATUS_CODE = 4 ;

-- adding in new values

INSERT report_status (REPORT_STATUS_CODE, DESCRIPTION, ACTIVE_FLAG, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
VALUES(5,	'Revised',	'Y',	NOW(),	'admin',	1,	UUID()),
(6,	'Submitted for Internal Approval',	'Y',	NOW(),	'admin',	1,	UUID()),
(7,	'Submitted to Sponsor',	'Y',	NOW(),	'admin',	1,	UUID());

-- SET GLOBAL FOREIGN_KEY_CHECKS=0;
-- Insert and update report_class

-- VERY IMPORTANT!!!!!!  The Payments and Invoices has to have the description remain in the third position in Report_Class table for some odd reason developer hard coded the number.
-- for the array being used for the pull-down.  If you don't leave it in the third position, the pulldown will not work.  


UPDATE REPORT_CLASS
SET DESCRIPTION = 'Contracts' 
WHERE REPORT_CLASS_CODE = 3;

UPDATE REPORT_CLASS
SET ACTIVE_FLAG = 'N' 
WHERE REPORT_CLASS_CODE = 5;

UPDATE REPORT_CLASS
SET DESCRIPTION = 'UCAR Legal' 
WHERE REPORT_CLASS_CODE = 7;

-- SET GLOBAL FOREIGN_KEY_CHECKS=1;

-- truncating the valid class report frequency table so that relating tables can be updated
TRUNCATE TABLE valid_class_report_freq;

-- insert frequency with a couple new values

INSERT frequency (VER_NBR, FREQUENCY_CODE, DESCRIPTION, NUMBER_OF_DAYS, NUMBER_OF_MONTHS, REPEAT_FLAG, UPDATE_TIMESTAMP, UPDATE_USER, ADVANCE_NUMBER_OF_DAYS, ADVANCE_NUMBER_OF_MONTHS, OBJ_ID, ACTIVE_FLAG)
values(1, 61, '15 days before', 0, 0, 'N', NOW(), 'admin', 15,0, UUID(), 'Y'),
(1, 62, '_120 days after ', 120, 0, 'N', NOW(), 'admin', 0,0, UUID(), 'Y'),
(1, 63, ' As required', 0, 0, 'Y', NOW(), 'admin', 0,0, UUID(), 'Y'), 
(1, 64, 'Quarterly-15 days before', 0, 3, 'Y', NOW(), 'admin', 15,0, UUID(), 'Y'), 
(1, 65, 'Quarterly-30 days before', 0, 3, 'Y', NOW(), 'admin', 30,0, UUID(), 'Y'),
(1, 66, 'Quarterly-30 days after', 30, 0, 'Y', NOW(), 'admin', 0,0, UUID(), 'Y'),
(1, 67, 'Semi-annual-30 days before', 0, 6, 'Y', NOW(), 'admin', 30,0, UUID(), 'Y'),
(1, 68, 'Semi-annual-30 days after', 30, 6, 'Y', NOW(), 'admin', 0,0, UUID(), 'Y'),
(1, 69, 'Annual-30 days before', 0, 12, 'Y', NOW(), 'admin', 30,0, UUID(), 'Y'),
(1, 70, 'Annual-45 days before', 0, 12, 'Y', NOW(), 'admin', 45,0, UUID(), 'Y'),
(1, 71, 'Annual-45 days after', 45, 12, 'Y', NOW(), 'admin', 0,0, UUID(), 'Y'),
(1, 72, 'Annual-60 days before', 0, 12, 'Y', NOW(), 'admin', 60,0, UUID(), 'Y'),
(1, 73, 'Annual-120 days before', 0, 12, 'Y', NOW(), 'admin', 120,0, UUID(), 'Y'),
(1, 74, 'Annual-120 days after', 120, 12, 'Y', NOW(), 'admin', 30,0, UUID(), 'Y'),
(1, 75, 'Annual-90 days after', 90, 12, 'Y', NOW(), 'admin', 0,0, UUID(), 'Y');

 UPDATE Frequency 
			SET DESCRIPTION = CASE FREQUENCY_CODE 
 					WHEN 14 THEN ' As required'
					WHEN 58 THEN '15 days after'
                    WHEN 15 THEN '30 days before'
                    WHEN 38 THEN '30 days after'
                    WHEN 36 THEN '45 days before'
                    WHEN 33 THEN '45 days after'
                    WHEN 59 THEN '60 days before'
                    WHEN 45 THEN '60 days after'
                    WHEN 17 THEN '90 days before'
                    WHEN 44 THEN '90 days after'
                    WHEN 35 THEN '_120 days before'
                    WHEN 42 THEN '__1 year after'
                    WHEN 56 THEN 'Quarterly-15 days after'
                    WHEN 32 THEN 'Annual-30 days after'
                    WHEN 31 THEN 'Annual-60 days after'
                    WHEN 55 THEN 'Annual-90 days before'
                    ELSE DESCRIPTION
				 END;

 
 UPDATE Frequency
 SET ACTIVE_FLAG = 'Y'
 WHERE DESCRIPTION = '1 year after expiration';

-- insert closeout report type

UPDATE closeout_report_type
SET DESCRIPTION = 'Contracts' WHERE CLOSEOUT_REPORT_CODE = 3;

UPDATE closeout_report_type
SET DESCRIPTION = 'Technical/Management' WHERE CLOSEOUT_REPORT_CODE = 4;

UPDATE closeout_report_type
SET DESCRIPTION = 'Payment/Invoice' WHERE CLOSEOUT_REPORT_CODE = 6;

UPDATE Award_closeout
SET CLOSEOUT_REPORT_NAME = 'Contracts' WHERE CLOSEOUT_REPORT_CODE = 3;


 -- delete old values and insert new ones for the valid frequency base table.
 
TRUNCATE valid_frequency_base;

INSERT valid_frequency_base(VALID_FREQUENCY_BASE_ID, FREQUENCY_BASE_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID,  FREQUENCY_CODE)
VALUES 
(100, 1, NOW(), 'admin', 1, UUID(),14), -- As required
(101, 2, NOW(), 'admin', 1, UUID(),14), -- As required
(102, 3, NOW(), 'admin', 1, UUID(),14), -- As required
(103, 4, NOW(), 'admin', 1, UUID(),14), -- As required
(104, 5, NOW(), 'admin', 1, UUID(),14), -- As required
(105, 6, NOW(), 'admin', 1, UUID(),14), -- As required
(106, 1, NOW(), 'admin', 1, UUID(),61),  -- 15 days before
(107, 2, NOW(), 'admin', 1, UUID(),61),  -- 15 days before
(108, 3, NOW(), 'admin', 1, UUID(),61),  -- 15 days before
(109, 4, NOW(), 'admin', 1, UUID(),61),  -- 15 days before
(110, 5, NOW(), 'admin', 1, UUID(),61),  -- 15 days before
(111, 6, NOW(), 'admin', 1, UUID(),61),  -- 15 days before
(112, 1, NOW(), 'admin', 1, UUID(),58),  -- 15 days after expiration
(113, 2, NOW(), 'admin', 1, UUID(),58),  -- 15 days after expiration
(114, 3, NOW(), 'admin', 1, UUID(),58),  -- 15 days after expiration
(115, 4, NOW(), 'admin', 1, UUID(),58),  -- 15 days after expiration
(116, 5, NOW(), 'admin', 1, UUID(),58),  -- 15 days after expiration
(117, 6, NOW(), 'admin', 1, UUID(),58),  -- 15 days after expiration
(118, 1, NOW(), 'admin', 1, UUID(),15), -- 30 days prior to expiration date
(119, 2, NOW(), 'admin', 1, UUID(),15), -- 30 days prior to expiration date
(120, 3, NOW(), 'admin', 1, UUID(),15), -- 30 days prior to expiration date
(121, 4, NOW(), 'admin', 1, UUID(),15), -- 30 days prior to expiration date
(122, 5, NOW(), 'admin', 1, UUID(),15), -- 30 days prior to expiration date
(123, 6, NOW(), 'admin', 1, UUID(),15), -- 30 days prior to expiration date
(124, 1, NOW(), 'admin', 1, UUID(),38), -- 30 days after award effective date
(125, 2, NOW(), 'admin', 1, UUID(),38), -- 30 days after award effective date
(126, 3, NOW(), 'admin', 1, UUID(),38), -- 30 days after award effective date
(127, 4, NOW(), 'admin', 1, UUID(),38), -- 30 days after award effective date
(128, 5, NOW(), 'admin', 1, UUID(),38), -- 30 days after award effective date
(129, 6, NOW(), 'admin', 1, UUID(),38), -- 30 days after award effective date
(130, 1, NOW(), 'admin', 1, UUID(),36), -- 45 days prior to expiration
(131, 2, NOW(), 'admin', 1, UUID(),36), -- 45 days prior to expiration
(132, 3, NOW(), 'admin', 1, UUID(),36), -- 45 days prior to expiration
(133, 4, NOW(), 'admin', 1, UUID(),36), -- 45 days prior to expiration
(134, 5, NOW(), 'admin', 1, UUID(),36), -- 45 days prior to expiration
(135, 6, NOW(), 'admin', 1, UUID(),36), -- 45 days prior to expiration
(136, 1, NOW(), 'admin', 1, UUID(),33), -- 45 days after expiration
(137, 2, NOW(), 'admin', 1, UUID(),33), -- 45 days after expiration
(138, 3, NOW(), 'admin', 1, UUID(),33), -- 45 days after expiration
(139, 4, NOW(), 'admin', 1, UUID(),33), -- 45 days after expiration
(140, 5, NOW(), 'admin', 1, UUID(),33), -- 45 days after expiration
(141, 6, NOW(), 'admin', 1, UUID(),33), -- 45 days after expiration
(142, 1, NOW(), 'admin', 1, UUID(),59), -- 60 days prior to anniversary date
(143, 2, NOW(), 'admin', 1, UUID(),59), -- 60 days prior to anniversary date
(144, 3, NOW(), 'admin', 1, UUID(),59), -- 60 days prior to anniversary date
(145, 4, NOW(), 'admin', 1, UUID(),59), -- 60 days prior to anniversary date
(146, 5, NOW(), 'admin', 1, UUID(),59), -- 60 days prior to anniversary date
(147, 6, NOW(), 'admin', 1, UUID(),59), -- 60 days prior to anniversary date
(148, 1, NOW(), 'admin', 1, UUID(),45), -- 60 days after effective date
(149, 2, NOW(), 'admin', 1, UUID(),45), -- 60 days after effective date
(150, 3, NOW(), 'admin', 1, UUID(),45), -- 60 days after effective date
(151, 4, NOW(), 'admin', 1, UUID(),45), -- 60 days after effective date
(152, 5, NOW(), 'admin', 1, UUID(),45), -- 60 days after effective date
(153, 6, NOW(), 'admin', 1, UUID(),45), -- 60 days after effective date
(154, 1, NOW(), 'admin', 1, UUID(),17), -- 90 days prior to expiration date
(155, 2, NOW(), 'admin', 1, UUID(),17), -- 90 days prior to expiration date
(156, 3, NOW(), 'admin', 1, UUID(),17), -- 90 days prior to expiration date
(157, 4, NOW(), 'admin', 1, UUID(),17), -- 90 days prior to expiration date
(158, 5, NOW(), 'admin', 1, UUID(),17), -- 90 days prior to expiration date
(159, 6, NOW(), 'admin', 1, UUID(),17), -- 90 days prior to expiration date
(160, 1, NOW(), 'admin', 1, UUID(),44), -- 90 days after effective date
(161, 2, NOW(), 'admin', 1, UUID(),44), -- 90 days after effective date
(162, 3, NOW(), 'admin', 1, UUID(),44), -- 90 days after effective date
(163, 4, NOW(), 'admin', 1, UUID(),44), -- 90 days after effective date
(164, 5, NOW(), 'admin', 1, UUID(),44), -- 90 days after effective date
(165, 6, NOW(), 'admin', 1, UUID(),44), -- 90 days after effective date
(166, 1, NOW(), 'admin', 1, UUID(),35), -- 120 days prior to expiration
(167, 2, NOW(), 'admin', 1, UUID(),35), -- 120 days prior to expiration
(168, 3, NOW(), 'admin', 1, UUID(),35), -- 120 days prior to expiration
(169, 4, NOW(), 'admin', 1, UUID(),35), -- 120 days prior to expiration
(170, 5, NOW(), 'admin', 1, UUID(),35), -- 120 days prior to expiration
(171, 6, NOW(), 'admin', 1, UUID(),35), -- 120 days prior to expiration
(172, 1, NOW(), 'admin', 1, UUID(),62), -- 120 days after
(173, 2, NOW(), 'admin', 1, UUID(),62), -- 120 days after
(174, 3, NOW(), 'admin', 1, UUID(),62), -- 120 days after
(175, 4, NOW(), 'admin', 1, UUID(),62), -- 120 days after
(176, 5, NOW(), 'admin', 1, UUID(),62), -- 120 days after
(177, 6, NOW(), 'admin', 1, UUID(),62), -- 120 days after
(178, 1, NOW(), 'admin', 1, UUID(),42), -- __1 year after 
(179, 2, NOW(), 'admin', 1, UUID(),42), -- __1 year after 
(180, 3, NOW(), 'admin', 1, UUID(),42), -- __1 year after 
(181, 4, NOW(), 'admin', 1, UUID(),42), -- __1 year after 
(182, 5, NOW(), 'admin', 1, UUID(),42), -- __1 year after 
(183, 6, NOW(), 'admin', 1, UUID(),42), -- __1 year after 
-- ---------------------------------------------------------------------------- this is the break between repeating and not
(184, 1, NOW(), 'admin', 1, UUID(),63), -- As Required
(185, 2, NOW(), 'admin', 1, UUID(),63), -- As Required
(186, 3, NOW(), 'admin', 1, UUID(),63), -- As Required
(187, 4, NOW(), 'admin', 1, UUID(),63), -- As Required
(188, 5, NOW(), 'admin', 1, UUID(),63), -- As Required
(189, 6, NOW(), 'admin', 1, UUID(),63), -- As Required
(190, 1, NOW(), 'admin', 1, UUID(),2),  -- Monthly
(191, 2, NOW(), 'admin', 1, UUID(),2),  -- Monthly
(192, 3, NOW(), 'admin', 1, UUID(),2),  -- Monthly
(193, 4, NOW(), 'admin', 1, UUID(),2),  -- Monthly
(194, 5, NOW(), 'admin', 1, UUID(),2),  -- Monthly
(195, 6, NOW(), 'admin', 1, UUID(),2),  -- Monthly
(196, 1, NOW(), 'admin', 1, UUID(),9),  -- Bi-monthly
(197, 2, NOW(), 'admin', 1, UUID(),9),  -- Bi-monthly
(198, 3, NOW(), 'admin', 1, UUID(),9),  -- Bi-monthly
(199, 4, NOW(), 'admin', 1, UUID(),9),  -- Bi-monthly
(200, 5, NOW(), 'admin', 1, UUID(),9),  -- Bi-monthly
(201, 6, NOW(), 'admin', 1, UUID(),9),  -- Bi-monthly
(202, 1, NOW(), 'admin', 1, UUID(),3),  -- Quarterly 
(203, 2, NOW(), 'admin', 1, UUID(),3),  -- Quarterly 
(204, 3, NOW(), 'admin', 1, UUID(),3),  -- Quarterly 
(205, 4, NOW(), 'admin', 1, UUID(),3),  -- Quarterly 
(206, 5, NOW(), 'admin', 1, UUID(),3),  -- Quarterly
(207, 6, NOW(), 'admin', 1, UUID(),3),  -- Quarterly 
(208, 1, NOW(), 'admin', 1, UUID(),64), -- Quarterly-15 days before
(209, 2, NOW(), 'admin', 1, UUID(),64), -- Quarterly-15 days before
(210, 3, NOW(), 'admin', 1, UUID(),64), -- Quarterly-15 days before
(211, 4, NOW(), 'admin', 1, UUID(),64), -- Quarterly-15 days before
(212, 5, NOW(), 'admin', 1, UUID(),64), -- Quarterly-15 days before
(213, 6, NOW(), 'admin', 1, UUID(),64), -- Quarterly-15 days before 
(214, 1, NOW(), 'admin', 1, UUID(),56), -- 15 Days After Each Quarter
(215, 2, NOW(), 'admin', 1, UUID(),56), -- 15 Days After Each Quarter
(216, 3, NOW(), 'admin', 1, UUID(),56), -- 15 Days After Each Quarter
(217, 4, NOW(), 'admin', 1, UUID(),56), -- 15 Days After Each Quarter
(218, 5, NOW(), 'admin', 1, UUID(),56), -- 15 Days After Each Quarter
(219, 6, NOW(), 'admin', 1, UUID(),56), -- 15 Days After Each Quarter
(220, 1, NOW(), 'admin', 1, UUID(),65), -- Quarterly-30 days before
(221, 2, NOW(), 'admin', 1, UUID(),65), -- Quarterly-30 days before
(222, 3, NOW(), 'admin', 1, UUID(),65), -- Quarterly-30 days before
(223, 4, NOW(), 'admin', 1, UUID(),65), -- Quarterly-30 days before
(224, 5, NOW(), 'admin', 1, UUID(),65), -- Quarterly-30 days before
(225, 6, NOW(), 'admin', 1, UUID(),65), -- Quarterly-30 days before
(226, 1, NOW(), 'admin', 1, UUID(),66), -- 30 Days After Each Quarter
(227, 2, NOW(), 'admin', 1, UUID(),66), -- 30 Days After Each Quarter
(228, 3, NOW(), 'admin', 1, UUID(),66), -- 30 Days After Each Quarter
(229, 4, NOW(), 'admin', 1, UUID(),66), -- 30 Days After Each Quarter
(230, 5, NOW(), 'admin', 1, UUID(),66), -- 30 Days After Each Quarter
(231, 6, NOW(), 'admin', 1, UUID(),66), -- 30 Days After Each Quarter
(232, 1, NOW(), 'admin', 1, UUID(),6),  -- Semi-annual
(233, 2, NOW(), 'admin', 1, UUID(),6),  -- Semi-annual
(234, 3, NOW(), 'admin', 1, UUID(),6),  -- Semi-annual
(235, 4, NOW(), 'admin', 1, UUID(),6),  -- Semi-annual
(236, 5, NOW(), 'admin', 1, UUID(),6),  -- Semi-annual
(237, 6, NOW(), 'admin', 1, UUID(),6),  -- Semi-annual
(238, 1, NOW(), 'admin', 1, UUID(),67),  -- Semi-annual-30 days before
(239, 2, NOW(), 'admin', 1, UUID(),67),  -- Semi-annual-30 days before
(240, 3, NOW(), 'admin', 1, UUID(),67),  -- Semi-annual-30 days before
(241, 4, NOW(), 'admin', 1, UUID(),67),  -- Semi-annual-30 days before
(242, 5, NOW(), 'admin', 1, UUID(),67),  -- Semi-annual-30 days before
(243, 6, NOW(), 'admin', 1, UUID(),67),  -- Semi-annual-30 days before
(244, 1, NOW(), 'admin', 1, UUID(),68), -- 30 Days After Each Semi-annual
(245, 2, NOW(), 'admin', 1, UUID(),68), -- 30 Days After Each Semi-annual
(246, 3, NOW(), 'admin', 1, UUID(),68), -- 30 Days After Each Semi-annual
(247, 4, NOW(), 'admin', 1, UUID(),68), -- 30 Days After Each Semi-annual
(248, 5, NOW(), 'admin', 1, UUID(),68), -- 30 Days After Each Semi-annual
(249, 6, NOW(), 'admin', 1, UUID(),68), -- 30 Days After Each Semi-annual
(250, 1, NOW(), 'admin', 1, UUID(),7),  -- Annual
(251, 2, NOW(), 'admin', 1, UUID(),7),  -- Annual
(252, 3, NOW(), 'admin', 1, UUID(),7),  -- Annual
(253, 4, NOW(), 'admin', 1, UUID(),7),  -- Annual
(254, 5, NOW(), 'admin', 1, UUID(),7),  -- Annual
(255, 6, NOW(), 'admin', 1, UUID(),7),  -- Annual
(256, 1, NOW(), 'admin', 1, UUID(),69),  -- Annual-30 days before
(257, 2, NOW(), 'admin', 1, UUID(),69),  -- Annual-30 days before
(258, 3, NOW(), 'admin', 1, UUID(),69),  -- Annual-30 days before
(259, 4, NOW(), 'admin', 1, UUID(),69),  -- Annual-30 days before
(260, 5, NOW(), 'admin', 1, UUID(),69),  -- Annual-30 days before
(261, 6, NOW(), 'admin', 1, UUID(),69),  -- Annual-30 days before
(262, 1, NOW(), 'admin', 1, UUID(),32), -- 30 days after annual anniversary
(263, 2, NOW(), 'admin', 1, UUID(),32), -- 30 days after annual anniversary
(264, 3, NOW(), 'admin', 1, UUID(),32), -- 30 days after annual anniversary
(265, 4, NOW(), 'admin', 1, UUID(),32), -- 30 days after annual anniversary
(266, 5, NOW(), 'admin', 1, UUID(),32), -- 30 days after annual anniversary
(267, 6, NOW(), 'admin', 1, UUID(),32), -- 30 days after annual anniversary
(268, 1, NOW(), 'admin', 1, UUID(),70), -- Annual-45 days before days before
(269, 2, NOW(), 'admin', 1, UUID(),70), -- Annual-45 days before days before
(270, 3, NOW(), 'admin', 1, UUID(),70), -- Annual-45 days before days before
(271, 4, NOW(), 'admin', 1, UUID(),70), -- Annual-45 days before days before
(272, 5, NOW(), 'admin', 1, UUID(),70), -- Annual-45 days before days before
(273, 6, NOW(), 'admin', 1, UUID(),70), -- Annual-45 days before days before
(274, 1, NOW(), 'admin', 1, UUID(),71), -- Annual-45 days after
(275, 2, NOW(), 'admin', 1, UUID(),71), -- Annual-45 days after
(276, 3, NOW(), 'admin', 1, UUID(),71), -- Annual-45 days after
(277, 4, NOW(), 'admin', 1, UUID(),71), -- Annual-45 days after
(278, 5, NOW(), 'admin', 1, UUID(),71), -- Annual-45 days after
(279, 6, NOW(), 'admin', 1, UUID(),71), -- Annual-45 days after
(280, 1, NOW(), 'admin', 1, UUID(),72), -- Annual-60 days before
(281, 2, NOW(), 'admin', 1, UUID(),72), -- Annual-60 days before
(282, 3, NOW(), 'admin', 1, UUID(),72), -- Annual-60 days before
(283, 4, NOW(), 'admin', 1, UUID(),72), -- Annual-60 days before
(284, 5, NOW(), 'admin', 1, UUID(),72), -- Annual-60 days before
(285, 6, NOW(), 'admin', 1, UUID(),72), -- Annual-60 days before
(286, 1, NOW(), 'admin', 1, UUID(),31), -- 60 days after annual anniversary
(287, 2, NOW(), 'admin', 1, UUID(),31), -- 60 days after annual anniversary
(288, 3, NOW(), 'admin', 1, UUID(),31), -- 60 days after annual anniversary
(289, 4, NOW(), 'admin', 1, UUID(),31), -- 60 days after annual anniversary
(290, 5, NOW(), 'admin', 1, UUID(),31), -- 60 days after annual anniversary
(291, 6, NOW(), 'admin', 1, UUID(),31), -- 60 days after annual anniversary
(292, 1, NOW(), 'admin', 1, UUID(),55), -- 90 days prior to anniversaries
(293, 2, NOW(), 'admin', 1, UUID(),55), -- 90 days prior to anniversaries
(294, 3, NOW(), 'admin', 1, UUID(),55), -- 90 days prior to anniversaries
(295, 4, NOW(), 'admin', 1, UUID(),55), -- 90 days prior to anniversaries
(296, 5, NOW(), 'admin', 1, UUID(),55), -- 90 days prior to anniversaries
(297, 6, NOW(), 'admin', 1, UUID(),55), -- 90 days prior to anniversaries
(298, 1, NOW(), 'admin', 1, UUID(),75), -- Annual-90 days after
(299, 2, NOW(), 'admin', 1, UUID(),75), -- Annual-90 days after
(300, 3, NOW(), 'admin', 1, UUID(),75), -- Annual-90 days after
(301, 4, NOW(), 'admin', 1, UUID(),75), -- Annual-90 days after
(302, 5, NOW(), 'admin', 1, UUID(),75), -- Annual-90 days after
(303, 6, NOW(), 'admin', 1, UUID(),75), -- Annual-90 days after
(304, 1, NOW(), 'admin', 1, UUID(),73), -- Annual-120 days before
(305, 2, NOW(), 'admin', 1, UUID(),73), -- Annual-120 days before
(306, 3, NOW(), 'admin', 1, UUID(),73), -- Annual-120 days before
(307, 4, NOW(), 'admin', 1, UUID(),73), -- Annual-120 days before
(308, 5, NOW(), 'admin', 1, UUID(),73), -- Annual-120 days before
(309, 6, NOW(), 'admin', 1, UUID(),73), -- Annual-120 days before
(310, 1, NOW(), 'admin', 1, UUID(),74), -- Annual-120 days after
(311, 2, NOW(), 'admin', 1, UUID(),74), -- Annual-120 days after
(312, 3, NOW(), 'admin', 1, UUID(),74), -- Annual-120 days after
(313, 4, NOW(), 'admin', 1, UUID(),74), -- Annual-120 days after
(314, 5, NOW(), 'admin', 1, UUID(),74), -- Annual-120 days after
(315, 6, NOW(), 'admin', 1, UUID(),74); -- Annual-120 days after



TRUNCATE TABLE valid_class_report_freq;

INSERT REPORT(VER_NBR, REPORT_CODE, DESCRIPTION, FINAL_REPORT_FLAG, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID, ACTIVE_FLAG)
VALUES 
-- this is the Contracts area
(1,	100,	'Annual Certification',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	105,	'Annual Manpower See Contract 417F7001',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	110,	'Annual Rate Letter ',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	115,	'Assignment of Refunds, Rebates and Credits',	'Y',	NOW(),	'admin',	UUID(),	'Y'),-- Final
(1,	120,	'Audit Report 2 CFR 200.515',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	125,	'Closeout Summary Report',	'Y',	NOW(),	'admin',	UUID(),	'Y'),-- Final
(1,	130,	'Contractor\'s Release',	'Y',	NOW(),	'admin',	UUID(),	'Y'),-- Final
(1,	135,	'Contractor\'s Release and Assignment',	'Y',	NOW(),	'admin',	UUID(),	'Y'),-- Final
(1,	140,	'Human Subjects Verification Notice',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	145,	'Individual Summary Subcontract Report (ISR)',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	150,	'Individual Summary Subcontract Report (ISR)',	'Y',	NOW(),	'admin',	UUID(),	'Y'),-- Final
(1,	155,	'Intellectual Property -Sponsor Form (Contracts)',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	160,	'Intellectual Property -Sponsor Form',	'Y',	NOW(),	'admin',	UUID(),	'Y'),-- Final
(1,	165,	'Intellectual Property Report (Contracts)',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	170,	'Intellectual Property Report',	'Y',	NOW(),	'admin',	UUID(),	'Y'),-- Final
(1,	175,	'Migrated Award-Not Defined',	'Y',	NOW(),	'admin',	UUID(),	'Y'),-- Final
(1,	180,	'No Report Required',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1, 185,	'NSF Energy/Sustainability Report', 'N', NOW(),	'admin',	UUID(),	'Y'),
(1,	190,	'Patent Certification (DOE F 2050.11)',	'Y',	NOW(),	'admin',	UUID(),	'Y'),
(1,	195,	'Property-Inventions-Patents-Royalties (PIPR)',	'Y',	NOW(),	'admin',	UUID(),	'Y'),
(1,	200,	'Report of Inventions and Subcontracts (DD 882)',	'Y',	NOW(),	'admin',	UUID(),	'Y'),-- Final
(1,	205,	'Service Contract Act Reporting',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	210,	'Summary Subcontract Report (SSR)',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	215,	'Summary Subcontract Report (SSR)',	'Y',	NOW(),	'admin',	UUID(),	'Y'),-- Final

-- this is the Financials area
(1, 220, 	'Cost Share Report',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1, 225, 	'Cost Share Report',	'Y',	NOW(),	'admin',	UUID(),	'Y'),-- Final
(1,	230,	'Federal Financial Report (SF 425)',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	235,	'Federal Financial Report (SF 425)',	'Y',	NOW(),	'admin',	UUID(),	'Y'),-- Final
(1,	240,	'Final Financial Report',	'Y',	NOW(),	'admin',	UUID(),	'Y'), -- Final
(1,	245,	'Financial Report',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	250,	'NASA Monthly Contract Financial Management Report (NASA 533M)',	'N',	NOW(),	'admin',	UUID(),	'Y'),

--  This is Legal
(1,	255,	'Invention Disclosures',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	260,	'Patent Applications',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	265,	'Patent Documentation',	'N',	NOW(),	'admin',	UUID(),	'Y'),

-- Payments and Invoices
(1,	270,	'Invoice',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	275,	'Invoice',	'Y',	NOW(),	'admin',	UUID(),	'Y'), -- Final
(1,	280,	'Invoice with Supporting Documentation',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	285,	'Invoice with Supporting Documentation',	'Y',	NOW(),	'admin',	UUID(),	'Y'),-- Final
(1,	290,	'Invoice-Signature',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	295,	'Invoice-Signature',	'Y',	NOW(),	'admin',	UUID(),	'Y'),-- Final
(1,	300,	'Invoice-Signature with Supporting Documentation',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	305,	'Invoice-Signature with Supporting Documentation',	'Y',	NOW(),	'admin',	UUID(),	'Y'),-- Final
(1,	310,	'Invoice-Sponsor Form',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	315,	'Invoice-Sponsor Form',	'Y',	NOW(),	'admin',	UUID(),	'Y'),-- Final
(1,	320,	'Online Request for Payment',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	325,	'Public Voucher for Purchases and Services (SF1034)',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	330,	'Public Voucher for Purchases-Continuation Sheet (SF1035)',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	335,	'Request for Advance or Reimbursement (SF270)',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	340,	'Request for Advance or Reimbursement (SF270)',	'Y',	NOW(),	'admin',	UUID(),	'Y'),-- Final

-- this is property
(1,	345,	'Contractor Report of Government Property-DOT (F 4220.43)',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	350,	'Inventory Disposal Schedule (SF 1428)',	'Y',	NOW(),	'admin',	UUID(),	'Y'),-- Final
(1,	355,	'Property -Sponsor Form',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	360,	'Property -Sponsor Form',	'Y',	NOW(),	'admin',	UUID(),	'Y'),-- Final
(1,	365,	'Property in the Custody of Contractors-NASA (SF 1018)',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	370,	'Property in the Custody of Contractors-NASA (SF 1018)',	'Y',	NOW(),	'admin',	UUID(),	'Y'),-- Final
(1,	375,	'Property Report',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	380,	'Property Report',	'Y',	NOW(),	'admin',	UUID(),	'Y'),-- Final
(1,	385,	'Tangible Personal Property Report-DOE (SF 428-B)',	'Y',	NOW(),	'admin',	UUID(),	'Y'),-- Final

-- This is technical management
(1,	390,	'Administrative Financial Report',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	395,	'Administrative Financial Report',	'Y',	NOW(),	'admin',	UUID(),	'Y'),-- Final
(1,	400,	'Administrative Report',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	405,	'Administrative Report',	'Y',	NOW(),	'admin',	UUID(),	'Y'),-- Final
(1,	410,	'Data Management Plan',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	415,	'Data Management Plan',	'Y',	NOW(),	'admin',	UUID(),	'Y'),-- Final
(1,	420,	'Deliverable Documentation',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	425,	'Intellectual Property -Sponsor Form',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	430,	'Intellectual Property Report',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1, 435, 	'Internal Review Board (Human Subjects) Approval',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	440,	'Management Plan / Report',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	445,	'Milestone Deliverable Documentation',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	450,	'Milestone Report',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	455,	'NCAR Program Operating Plan (POP)',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	460,	'NCAR Program Operating Plan Progress Report (POPPR)',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	465,	'Online Technical Report',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	470,	'Online Technical Report',	'Y',	NOW(),	'admin',	UUID(),	'Y'),-- Final
(1,	475,	'Presentation',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	480,	'Proceedings',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	485,	'Publication',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	490,	'Report Documentation Page (SF 298)',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	495,	'Technical Report',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	500,	'Technical Report','Y',	NOW(),	'admin',	UUID(),	'Y'),-- Final
(1,	505,	'Technical Report-Sponsor Form',	'N',	NOW(),	'admin',	UUID(),	'Y'),
(1,	510,	'Technical Report-Sponsor Form',	'Y',	NOW(),	'admin',	UUID(),	'Y');-- Final

UPDATE report
SET DESCRIPTION = 'Migrated Award-Not Defined' 
WHERE REPORT_CODE = 1;

UPDATE report
SET Active_Flag = 'N'
WHERE REPORT_CODE = '1';

UPDATE award_template_report_terms
SET REPORT_CODE = 1 
WHERE REPORT_CODE BETWEEN 2 AND 99;

UPDATE award_report_terms
SET REPORT_CODE = 1 
WHERE REPORT_CODE BETWEEN 2 AND 99;

DELETE FROM REPORT 
WHERE REPORT_CODE BETWEEN 2 AND 99;

--  update the sort order of frequency.  This is the because the frequencies are alpha sorted.
-- two spaces in front of the description puts the values to the very top, one space will put it directly below the two spaces
-- an underscore in the beginning of the description field will send the values to the bottom for the alpha sort.
/*
Update Frequency
Set Description = '  1 year after expiration',
Active_flag = 'N'
where Frequency_code = 42;

Update Frequency
Set Description = '  4 months after expiration date',
Active_flag = 'N'
where Frequency_code = 28;

Update Frequency
Set Description = '  4 months prior to expiration date',
Active_flag = 'N'
where Frequency_code = 18;

Update Frequency
Set Description = ' 10 months after effective date',
Active_flag = 'N'
where Frequency_code = 57;

Update Frequency
Set Description = ' 10 months prior to expiration date',
Active_flag = 'N'
where Frequency_code = 34;

Update Frequency
Set Description = '  5 months after expiration date',
Active_flag = 'N'
where Frequency_code = 29;

Update Frequency
Set Description = '  5 months prior to expiration date',
Active_flag = 'N'
where Frequency_code = 19;

Update Frequency
Set Description = '  6 months after award effective date'
where Frequency_code = 39;

Update Frequency
Set Description = '  6 months after expiration date'
where Frequency_code = 30;

Update Frequency
Set Description = '  6 months prior to expiration date'
where Frequency_code = 20;

Update Frequency
Set Description = '  7 months prior to expiration date',
Active_flag = 'N'
where Frequency_code = 21;

Update Frequency
Set Description = '  8 months prior to expiration date',
Active_flag = 'N'
where Frequency_code = 22;

Update Frequency
Set Description = '  9 months after award effective date',
Active_flag = 'N'
where Frequency_code = 40;

Update Frequency
Set Description = '  9 months prior to expiration date',
Active_flag = 'N'
where Frequency_code = 23;

Update Frequency
Set Description = ' 15 days after each quarter'
where Frequency_code =56 ;

Update Frequency
Set Description = ' 15 days after expiration'
where Frequency_code =58 ;

Update Frequency
Set Description = ' 30 days after each quarter'
where Frequency_code = 62;

Update Frequency
Set Description = ' 30 days after each semi-annual'
where Frequency_code =61 ;

Update Frequency
Set Description = ' 30 days after annual anniversary'
where Frequency_code = 32;

Update Frequency
Set Description = ' 30 days after award effective date'
where Frequency_code =38 ;

Update Frequency
Set Description = ' 30 days after effective date'
where Frequency_code =27 ;

Update Frequency
Set Description = ' 30 days after expiration'
where Frequency_code = 10;

Update Frequency
Set Description = ' 30 days prior to expiration date'
where Frequency_code =15 ;

Update Frequency
Set Description = ' 45 days after expiration'
where Frequency_code =33 ;

Update Frequency
Set Description = ' 45 days prior to expiration'
where Frequency_code =36 ;

Update Frequency
Set Description = ' 60 days after annual anniversary'
where Frequency_code = 31;

Update Frequency
Set Description = ' 60 days after effective date'
where Frequency_code =45 ;

Update Frequency
Set Description = ' 60 days after expiration'
where Frequency_code =11 ;

Update Frequency
Set Description = ' 60 days prior to anniversary date'
where Frequency_code =59 ;

Update Frequency
Set Description = ' 60 days prior to expiration date'
where Frequency_code = 16;

Update Frequency
Set Description = ' 75 days after expiration'
where Frequency_code = 43;

Update Frequency
Set Description = ' 75 days prior to expiration date'
where Frequency_code = 37;

Update Frequency
Set Description = ' 90 days after effective date'
where Frequency_code = 44;

Update Frequency
Set Description = ' 90 days after expiration'
where Frequency_code =12 ;

Update Frequency
Set Description = ' 90 days prior to anniversaries'
where Frequency_code = 55;

Update Frequency
Set Description = ' 90 days prior to expiration date'
where Frequency_code =17 ;

*/

INSERT DISTRIBUTION(VER_NBR, OSP_DISTRIBUTION_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID, ACTIVE_FLAG)
VALUES(1,5,	'Not Applicable', NOW(), 'admin',	UUID(), 'Y');

UPDATE award_report_terms
SET OSP_DISTRIBUTION_CODE = 5
WHERE OSP_DISTRIBUTION_CODE < 5;

UPDATE award_template_report_terms
SET OSP_DISTRIBUTION_CODE = 5
WHERE OSP_DISTRIBUTION_CODE < 5;

DELETE FROM DISTRIBUTION 
WHERE OSP_DISTRIBUTION_CODE < 5;

Truncate Table valid_class_report_freq;

INSERT valid_class_report_freq(VALID_CLASS_REPORT_FREQ_ID, REPORT_CLASS_CODE, REPORT_CODE, FREQUENCY_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
VALUES 
(	1		,	3	, 100,	63	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, As Required
(	2		,	3	, 100,	2	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, Monthly
(	3		,	3	, 100,	9	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, Bi-monthly
(	4		,	3	, 100,	3	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, Quarterly
(	5		,	3	, 100,	64	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, Quarterly-15 days before
(	6		,	3	, 100,	56	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, Quarterly-15 days after
(	7		,	3	, 100,	65	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, Quarterly-30 days before
(	8		,	3	, 100,	66	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, Quarterly-30 days after
(	9		,	3	, 100,	6	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, Semi-annual
(	10		,	3	, 100,	67	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, Semi-annual-30 days before
(	11		,	3	, 100,	68	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, Semi-annual-30 days after
(	12		,	3	, 100,	7	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, Annual
(	13		,	3	, 100,	69	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, Annual-30 days before
(	14		,	3	, 100,	32	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, Annual-30 days after
(	15		,	3	, 100,	70	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, Annual-45 days before
(	16		,	3	, 100,	71	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, Annual-45 days after
(	17		,	3	, 100,	72	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, Annual-60 days before
(	18		,	3	, 100,	31	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, Annual-60 days after
(	19		,	3	, 100,	55	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, Annual-90 days before
(	20		,	3	, 100,	75	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, Annual-90 days after
(	21		,	3	, 100,	73	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, Annual-120 days before
(	22		,	3	, 100,	74	, NOW(),	'admin',	1, UUID()),  --  Annual Certification, Annual-120 days after
(	23		,	3	, 105,	63	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, As Required
(	24		,	3	, 105,	2	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, Monthly
(	25		,	3	, 105,	9	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, Bi-monthly
(	26		,	3	, 105,	3	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, Quarterly
(	27		,	3	, 105,	64	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, Quarterly-15 days before
(	28		,	3	, 105,	56	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, Quarterly-15 days after
(	29		,	3	, 105,	65	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, Quarterly-30 days before
(	30		,	3	, 105,	66	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, Quarterly-30 days after
(	31		,	3	, 105,	6	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, Semi-annual
(	32		,	3	, 105,	67	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, Semi-annual-30 days before
(	33		,	3	, 105,	68	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, Semi-annual-30 days after
(	34		,	3	, 105,	7	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, Annual
(	35		,	3	, 105,	69	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, Annual-30 days before
(	36		,	3	, 105,	32	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, Annual-30 days after
(	37		,	3	, 105,	70	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, Annual-45 days before
(	38		,	3	, 105,	71	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, Annual-45 days after
(	39		,	3	, 105,	72	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, Annual-60 days before
(	40		,	3	, 105,	31	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, Annual-60 days after
(	41		,	3	, 105,	55	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, Annual-90 days before
(	42		,	3	, 105,	75	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, Annual-90 days after
(	43		,	3	, 105,	73	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, Annual-120 days before
(	44		,	3	, 105,	74	, NOW(),	'admin',	1, UUID()),  --  Annual Manpower See Contract 417F7001, Annual-120 days after
(	45		,	3	, 110,	63	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , As Required
(	46		,	3	, 110,	2	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , Monthly
(	47		,	3	, 110,	9	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , Bi-monthly
(	48		,	3	, 110,	3	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , Quarterly
(	49		,	3	, 110,	64	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , Quarterly-15 days before
(	50		,	3	, 110,	56	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , Quarterly-15 days after
(	51		,	3	, 110,	65	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , Quarterly-30 days before
(	52		,	3	, 110,	66	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , Quarterly-30 days after
(	53		,	3	, 110,	6	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , Semi-annual
(	54		,	3	, 110,	67	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , Semi-annual-30 days before
(	55		,	3	, 110,	68	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , Semi-annual-30 days after
(	56		,	3	, 110,	7	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , Annual
(	57		,	3	, 110,	69	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , Annual-30 days before
(	58		,	3	, 110,	32	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , Annual-30 days after
(	59		,	3	, 110,	70	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , Annual-45 days before
(	60		,	3	, 110,	71	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , Annual-45 days after
(	61		,	3	, 110,	72	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , Annual-60 days before
(	62		,	3	, 110,	31	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , Annual-60 days after
(	63		,	3	, 110,	55	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , Annual-90 days before
(	64		,	3	, 110,	75	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , Annual-90 days after
(	65		,	3	, 110,	73	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , Annual-120 days before
(	66		,	3	, 110,	74	, NOW(),	'admin',	1, UUID()),  --  Annual Rate Letter , Annual-120 days after
(	67		,	3	, 115,	14	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, As required
(	68		,	3	, 115,	61	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, 15 days before
(	69		,	3	, 115,	58	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, 15 days after
(	70		,	3	, 115,	15	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, 30 days before
(	71		,	3	, 115,	38	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, 30 days after
(	72		,	3	, 115,	36	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, 45 days before
(	73		,	3	, 115,	33	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, 45 days after
(	74		,	3	, 115,	59	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, 60 days before
(	75		,	3	, 115,	45	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, 60 days after
(	76		,	3	, 115,	17	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, 90 days before
(	77		,	3	, 115,	44	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, 90 days after
(	78		,	3	, 115,	35	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, 120 days before
(	79		,	3	, 115,	62	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, 120 days after 
(	80		,	3	, 115,	42	, NOW(),	'admin',	1, UUID()),  --  Assignment of Refunds, Rebates and Credits, 1 year after
(	81		,	3	, 120,	63	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , As Required
(	82		,	3	, 120,	2	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , Monthly
(	83		,	3	, 120,	9	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , Bi-monthly
(	84		,	3	, 120,	3	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , Quarterly
(	85		,	3	, 120,	64	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , Quarterly-15 days before
(	86		,	3	, 120,	56	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , Quarterly-15 days after
(	87		,	3	, 120,	65	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , Quarterly-30 days before
(	88		,	3	, 120,	66	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , Quarterly-30 days after
(	89		,	3	, 120,	6	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , Semi-annual
(	90		,	3	, 120,	67	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , Semi-annual-30 days before
(	91		,	3	, 120,	68	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , Semi-annual-30 days after
(	92		,	3	, 120,	7	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , Annual
(	93		,	3	, 120,	69	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , Annual-30 days before
(	94		,	3	, 120,	32	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , Annual-30 days after
(	95		,	3	, 120,	70	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , Annual-45 days before
(	96		,	3	, 120,	71	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , Annual-45 days after
(	97		,	3	, 120,	72	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , Annual-60 days before
(	98		,	3	, 120,	31	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , Annual-60 days after
(	99		,	3	, 120,	55	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , Annual-90 days before
(	100		,	3	, 120,	75	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , Annual-90 days after
(	101		,	3	, 120,	73	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , Annual-120 days before
(	102		,	3	, 120,	74	, NOW(),	'admin',	1, UUID()),  --  Audit Report 2 CFR 200.515 , Annual-120 days after
(	103		,	3	, 125,	14	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, As required
(	104		,	3	, 125,	61	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, 15 days before
(	105		,	3	, 125,	58	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, 15 days after
(	106		,	3	, 125,	15	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, 30 days before
(	107		,	3	, 125,	38	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, 30 days after
(	108		,	3	, 125,	36	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, 45 days before
(	109		,	3	, 125,	33	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, 45 days after
(	110		,	3	, 125,	59	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, 60 days before
(	111		,	3	, 125,	45	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, 60 days after
(	112		,	3	, 125,	17	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, 90 days before
(	113		,	3	, 125,	44	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, 90 days after
(	114		,	3	, 125,	35	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, 120 days before
(	115		,	3	, 125,	62	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, 120 days after 
(	116		,	3	, 125,	42	, NOW(),	'admin',	1, UUID()),  --  Closeout Summary Report, 1 year after
(	117		,	3	, 130,	14	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , As required
(	118		,	3	, 130,	61	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , 15 days before
(	119		,	3	, 130,	58	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , 15 days after
(	120		,	3	, 130,	15	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , 30 days before
(	121		,	3	, 130,	38	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , 30 days after
(	122		,	3	, 130,	36	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , 45 days before
(	123		,	3	, 130,	33	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , 45 days after
(	124		,	3	, 130,	59	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , 60 days before
(	125		,	3	, 130,	45	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , 60 days after
(	126		,	3	, 130,	17	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , 90 days before
(	127		,	3	, 130,	44	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , 90 days after
(	128		,	3	, 130,	35	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , 120 days before
(	129		,	3	, 130,	62	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , 120 days after 
(	130		,	3	, 130,	42	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release , 1 year after
(	131		,	3	, 135,	14	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, As required
(	132		,	3	, 135,	61	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, 15 days before
(	133		,	3	, 135,	58	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, 15 days after
(	134		,	3	, 135,	15	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, 30 days before
(	135		,	3	, 135,	38	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, 30 days after
(	136		,	3	, 135,	36	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, 45 days before
(	137		,	3	, 135,	33	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, 45 days after
(	138		,	3	, 135,	59	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, 60 days before
(	139		,	3	, 135,	45	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, 60 days after
(	140		,	3	, 135,	17	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, 90 days before
(	141		,	3	, 135,	44	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, 90 days after
(	142		,	3	, 135,	35	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, 120 days before
(	143		,	3	, 135,	62	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, 120 days after 
(	144		,	3	, 135,	42	, NOW(),	'admin',	1, UUID()),  --  Contractor's Release and Assignment, 1 year after
(	145		,	3	, 140,	63	, NOW(),	'admin',	1, UUID()),  --  Human Subjects Verification Notice, As Required
(	146		,	3	, 140,	2	, NOW(),	'admin',	1, UUID()),  --  Human Subjects Verification Notice, Monthly
(	147		,	3	, 140,	9	, NOW(),	'admin',	1, UUID()),  --  Human Subjects Verification Notice, Bi-monthly
(	148		,	3	, 140,	3	, NOW(),	'admin',	1, UUID()),  --  Human Subjects Verification Notice, Quarterly
(	149		,	3	, 140,	64	, NOW(),	'admin',	1, UUID()),  --  Human Subjects Verification Notice, Quarterly-15 days before
(	150		,	3	, 140,	56	, NOW(),	'admin',	1, UUID()),  --  Human Subjects Verification Notice, Quarterly-15 days after
(	151		,	3	, 140,	65	, NOW(),	'admin',	1, UUID()),  --  Human Subjects Verification Notice, Quarterly-30 days before
(	152		,	3	, 140,	66	, NOW(),	'admin',	1, UUID()),  --  Human Subjects Verification Notice, Quarterly-30 days after
(	153		,	3	, 140,	6	, NOW(),	'admin',	1, UUID()),  --  Human Subjects Verification Notice, Semi-annual
(	154		,	3	, 140,	67	, NOW(),	'admin',	1, UUID()),  --  Human Subjects Verification Notice, Semi-annual-30 days before
(	155		,	3	, 140,	68	, NOW(),	'admin',	1, UUID()),  --  Human Subjects Verification Notice, Semi-annual-30 days after
(	156		,	3	, 140,	7	, NOW(),	'admin',	1, UUID()),  --  Human Subjects Verification Notice, Annual
(	157		,	3	, 140,	69	, NOW(),	'admin',	1, UUID()),  --  Human Subjects Verification Notice, Annual-30 days before
(	158		,	3	, 140,	32	, NOW(),	'admin',	1, UUID()),  --  Human Subjects Verification Notice, Annual-30 days after
(	159		,	3	, 140,	70	, NOW(),	'admin',	1, UUID()),  --  Human Subjects Verification Notice, Annual-45 days before
(	160		,	3	, 140,	71	, NOW(),	'admin',	1, UUID()),  --  Human Subjects Verification Notice, Annual-45 days after
(	161		,	3	, 140,	72	, NOW(),	'admin',	1, UUID()),  --  Human Subjects Verification Notice, Annual-60 days before
(	162		,	3	, 140,	31	, NOW(),	'admin',	1, UUID()),  --  Human Subjects Verification Notice, Annual-60 days after
(	163		,	3	, 140,	55	, NOW(),	'admin',	1, UUID()),  --  Human Subjects Verification Notice, Annual-90 days before
(	164		,	3	, 140,	75	, NOW(),	'admin',	1, UUID()),  --  Human Subjects Verification Notice, Annual-90 days after
(	165		,	3	, 140,	73	, NOW(),	'admin',	1, UUID()),  --  Human Subjects Verification Notice, Annual-120 days before
(	166		,	3	, 140,	74	, NOW(),	'admin',	1, UUID()),  --  Human Subjects Verification Notice, Annual-120 days after
(	167		,	3	, 145,	63	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), As Required
(	168		,	3	, 145,	2	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), Monthly
(	169		,	3	, 145,	9	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), Bi-monthly
(	170		,	3	, 145,	3	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), Quarterly
(	171		,	3	, 145,	64	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), Quarterly-15 days before
(	172		,	3	, 145,	56	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), Quarterly-15 days after
(	173		,	3	, 145,	65	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), Quarterly-30 days before
(	174		,	3	, 145,	66	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), Quarterly-30 days after
(	175		,	3	, 145,	6	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), Semi-annual
(	176		,	3	, 145,	67	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), Semi-annual-30 days before
(	177		,	3	, 145,	68	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), Semi-annual-30 days after
(	178		,	3	, 145,	7	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), Annual
(	179		,	3	, 145,	69	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), Annual-30 days before
(	180		,	3	, 145,	32	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), Annual-30 days after
(	181		,	3	, 145,	70	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), Annual-45 days before
(	182		,	3	, 145,	71	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), Annual-45 days after
(	183		,	3	, 145,	72	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), Annual-60 days before
(	184		,	3	, 145,	31	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), Annual-60 days after
(	185		,	3	, 145,	55	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), Annual-90 days before
(	186		,	3	, 145,	75	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), Annual-90 days after
(	187		,	3	, 145,	73	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), Annual-120 days before
(	188		,	3	, 145,	74	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR), Annual-120 days after
(	189		,	3	, 150,	14	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, As required
(	190		,	3	, 150,	61	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, 15 days before
(	191		,	3	, 150,	58	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, 15 days after
(	192		,	3	, 150,	15	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, 30 days before
(	193		,	3	, 150,	38	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, 30 days after
(	194		,	3	, 150,	36	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, 45 days before
(	195		,	3	, 150,	33	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, 45 days after
(	196		,	3	, 150,	59	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, 60 days before
(	197		,	3	, 150,	45	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, 60 days after
(	198		,	3	, 150,	17	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, 90 days before
(	199		,	3	, 150,	44	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, 90 days after
(	200		,	3	, 150,	35	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, 120 days before
(	201		,	3	, 150,	62	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, 120 days after
(	202		,	3	, 150,	42	, NOW(),	'admin',	1, UUID()),  --  Individual Summary Subcontract Report (ISR)-Final, 1 year after
(	203		,	3	, 155,	63	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , As Required
(	204		,	3	, 155,	2	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Monthly
(	205		,	3	, 155,	9	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Bi-monthly
(	206		,	3	, 155,	3	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Quarterly
(	207		,	3	, 155,	64	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Quarterly-15 days before
(	208		,	3	, 155,	56	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Quarterly-15 days after
(	209		,	3	, 155,	65	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Quarterly-30 days before
(	210		,	3	, 155,	66	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Quarterly-30 days after
(	211		,	3	, 155,	6	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Semi-annual
(	212		,	3	, 155,	67	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Semi-annual-30 days before
(	213		,	3	, 155,	68	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Semi-annual-30 days after
(	214		,	3	, 155,	7	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Annual
(	215		,	3	, 155,	69	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Annual-30 days before
(	216		,	3	, 155,	32	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Annual-30 days after
(	217		,	3	, 155,	70	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Annual-45 days before
(	218		,	3	, 155,	71	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Annual-45 days after
(	219		,	3	, 155,	72	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Annual-60 days before
(	220		,	3	, 155,	31	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Annual-60 days after
(	221		,	3	, 155,	55	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Annual-90 days before
(	222		,	3	, 155,	75	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Annual-90 days after
(	223		,	3	, 155,	73	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Annual-120 days before
(	224		,	3	, 155,	74	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Annual-120 days after
(	225		,	3	, 160,	14	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form  - Final, As required
(	226		,	3	, 160,	61	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form  - Final, 15 days before
(	227		,	3	, 160,	58	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form  - Final, 15 days after
(	228		,	3	, 160,	15	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form  - Final, 30 days before
(	229		,	3	, 160,	38	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form  - Final, 30 days after
(	230		,	3	, 160,	36	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form  - Final, 45 days before
(	231		,	3	, 160,	33	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form  - Final, 45 days after
(	232		,	3	, 160,	59	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form  - Final, 60 days before
(	233		,	3	, 160,	45	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form  - Final, 60 days after
(	234		,	3	, 160,	17	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form  - Final, 90 days before
(	235		,	3	, 160,	44	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form  - Final, 90 days after
(	236		,	3	, 160,	35	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form  - Final, 120 days before
(	237		,	3	, 160,	62	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form  - Final, 120 days after
(	238		,	3	, 160,	42	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form  - Final, 1 year after
(	239		,	3	, 165,	63	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, As Required
(	240		,	3	, 165,	2	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Monthly
(	241		,	3	, 165,	9	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Bi-monthly
(	242		,	3	, 165,	3	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Quarterly
(	243		,	3	, 165,	64	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Quarterly-15 days before
(	244		,	3	, 165,	56	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Quarterly-15 days after
(	245		,	3	, 165,	65	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Quarterly-30 days before
(	246		,	3	, 165,	66	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Quarterly-30 days after
(	247		,	3	, 165,	6	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Semi-annual
(	248		,	3	, 165,	67	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Semi-annual-30 days before
(	249		,	3	, 165,	68	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Semi-annual-30 days after
(	250		,	3	, 165,	7	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Annual
(	251		,	3	, 165,	69	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Annual-30 days before
(	252		,	3	, 165,	32	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Annual-30 days after
(	253		,	3	, 165,	70	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Annual-45 days before
(	254		,	3	, 165,	71	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Annual-45 days after
(	255		,	3	, 165,	72	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Annual-60 days before
(	256		,	3	, 165,	31	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Annual-60 days after
(	257		,	3	, 165,	55	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Annual-90 days before
(	258		,	3	, 165,	75	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Annual-90 days after
(	259		,	3	, 165,	73	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Annual-120 days before
(	260		,	3	, 165,	74	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Annual-120 days after
(	261		,	3	,170,	14	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report - Final, As required
(	262		,	3	, 170,	61	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report - Final, 15 days before
(	263		,	3	, 170,	58	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report - Final, 15 days after
(	264		,	3	, 170,	15	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report - Final, 30 days before
(	265		,	3	, 170,	38	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report - Final, 30 days after
(	266		,	3	, 170,	36	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report - Final, 45 days before
(	267		,	3	, 170,	33	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report - Final, 45 days after
(	268		,	3	, 170,	59	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report - Final, 60 days before
(	269		,	3	, 170,	45	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report - Final, 60 days after
(	270		,	3	, 170,	17	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report - Final, 90 days before
(	271		,	3	, 170,	44	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report - Final, 90 days after
(	272		,	3	, 170,	35	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report - Final, 120 days before
(	273		,	3	, 170,	62	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report - Final, 120 days after
(	274		,	3	, 170,	42	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report - Final, 1 year after
(	275		,	3	, 1,	63	, NOW(),	'admin',	1, UUID()),  --  Migrated Award-Not Defined, As Required
(	276		,	3	, 1,	2	, NOW(),	'admin',	1, UUID()),  --  Migrated Award-Not Defined, Monthly
(	277		,	3	, 1,	9	, NOW(),	'admin',	1, UUID()),  --  Migrated Award-Not Defined, Bi-monthly
(	278		,	3	, 1,	3	, NOW(),	'admin',	1, UUID()),  --  Migrated Award-Not Defined, Quarterly
(	279		,	3	, 1,	64	, NOW(),	'admin',	1, UUID()),  --  Migrated Award-Not Defined, Quarterly-15 days before
(	280		,	3	, 1,	56	, NOW(),	'admin',	1, UUID()),  --  Migrated Award-Not Defined, Quarterly-15 days after
(	281		,	3	, 1,	65	, NOW(),	'admin',	1, UUID()),  --  Migrated Award-Not Defined, Quarterly-30 days before
(	282		,	3	, 1,	66	, NOW(),	'admin',	1, UUID()),  --  Migrated Award-Not Defined, Quarterly-30 days after
(	283		,	3	, 1,	6	, NOW(),	'admin',	1, UUID()),  --  Migrated Award-Not Defined, Semi-annual
(	284		,	3	, 1,	67	, NOW(),	'admin',	1, UUID()),  --  Migrated Award-Not Defined, Semi-annual-30 days before
(	285		,	3	, 1,	68	, NOW(),	'admin',	1, UUID()),  --  Migrated Award-Not Defined, Semi-annual-30 days after
(	286		,	3	, 1,	7	, NOW(),	'admin',	1, UUID()),  --  Migrated Award-Not Defined, Annual
(	287		,	3	, 1,	69	, NOW(),	'admin',	1, UUID()),  --  Migrated Award-Not Defined, Annual-30 days before
(	288		,	3	, 1,	32	, NOW(),	'admin',	1, UUID()),  --  Migrated Award-Not Defined, Annual-30 days after
(	289		,	3	, 1,	70	, NOW(),	'admin',	1, UUID()),  --  Migrated Award-Not Defined, Annual-45 days before
(	290		,	3	, 1,	71	, NOW(),	'admin',	1, UUID()),  --  Migrated Award-Not Defined, Annual-45 days after
(	291		,	3	, 1,	72	, NOW(),	'admin',	1, UUID()),  --  Migrated Award-Not Defined, Annual-60 days before
(	292		,	3	, 1,	31	, NOW(),	'admin',	1, UUID()),  --  Migrated Award-Not Defined, Annual-60 days after
(	293		,	3	, 1,	55	, NOW(),	'admin',	1, UUID()),  --  Migrated Award-Not Defined, Annual-90 days before
(	294		,	3	, 1,	75	, NOW(),	'admin',	1, UUID()),  --  Migrated Award-Not Defined, Annual-90 days after
(	295		,	3	, 1,	73	, NOW(),	'admin',	1, UUID()),  --  Migrated Award-Not Defined, Annual-120 days before
(	296		,	3	, 1,	74	, NOW(),	'admin',	1, UUID()),  --  Migrated Award-Not Defined, Annual-120 days after
(	297		,	3	, 180,	63	, NOW(),	'admin',	1, UUID()),  --  No Report Required, As Required
(	298		,	3	, 180,	2	, NOW(),	'admin',	1, UUID()),  --  No Report Required, Monthly
(	299		,	3	, 180,	9	, NOW(),	'admin',	1, UUID()),  --  No Report Required, Bi-monthly
(	300		,	3	, 180,	3	, NOW(),	'admin',	1, UUID()),  --  No Report Required, Quarterly
(	301		,	3	, 180,	64	, NOW(),	'admin',	1, UUID()),  --  No Report Required, Quarterly-15 days before
(	302		,	3	, 180,	56	, NOW(),	'admin',	1, UUID()),  --  No Report Required, Quarterly-15 days after
(	303		,	3	, 180,	65	, NOW(),	'admin',	1, UUID()),  --  No Report Required, Quarterly-30 days before
(	304		,	3	, 180,	66	, NOW(),	'admin',	1, UUID()),  --  No Report Required, Quarterly-30 days after
(	305		,	3	, 180,	6	, NOW(),	'admin',	1, UUID()),  --  No Report Required, Semi-annual
(	306		,	3	, 180,	67	, NOW(),	'admin',	1, UUID()),  --  No Report Required, Semi-annual-30 days before
(	307		,	3	, 180,	68	, NOW(),	'admin',	1, UUID()),  --  No Report Required, Semi-annual-30 days after
(	308		,	3	, 180,	7	, NOW(),	'admin',	1, UUID()),  --  No Report Required, Annual
(	309		,	3	, 180,	69	, NOW(),	'admin',	1, UUID()),  --  No Report Required, Annual-30 days before
(	310		,	3	, 180,	32	, NOW(),	'admin',	1, UUID()),  --  No Report Required, Annual-30 days after
(	311		,	3	, 180,	70	, NOW(),	'admin',	1, UUID()),  --  No Report Required, Annual-45 days before
(	312		,	3	, 180,	71	, NOW(),	'admin',	1, UUID()),  --  No Report Required, Annual-45 days after
(	313		,	3	, 180,	72	, NOW(),	'admin',	1, UUID()),  --  No Report Required, Annual-60 days before
(	314		,	3	, 180,	31	, NOW(),	'admin',	1, UUID()),  --  No Report Required, Annual-60 days after
(	315		,	3	, 180,	55	, NOW(),	'admin',	1, UUID()),  --  No Report Required, Annual-90 days before
(	316		,	3	, 180,	75	, NOW(),	'admin',	1, UUID()),  --  No Report Required, Annual-90 days after
(	317		,	3	, 180,	73	, NOW(),	'admin',	1, UUID()),  --  No Report Required, Annual-120 days before
(	318		,	3	, 180,	74	, NOW(),	'admin',	1, UUID()),  --  No Report Required, Annual-120 days after
(	319		,	3	, 185,	63	, NOW(),	'admin',	1, UUID()),  --  NSF Energy/Sustainability Report, As Required
(	320		,	3	, 185,	2	, NOW(),	'admin',	1, UUID()),  --  NSF Energy/Sustainability Report, Monthly
(	321		,	3	, 185,	9	, NOW(),	'admin',	1, UUID()),  --  NSF Energy/Sustainability Report, Bi-monthly
(	322		,	3	, 185,	3	, NOW(),	'admin',	1, UUID()),  --  NSF Energy/Sustainability Report, Quarterly
(	323		,	3	, 185,	64	, NOW(),	'admin',	1, UUID()),  --  NSF Energy/Sustainability Report, Quarterly-15 days before
(	324		,	3	, 185,	56	, NOW(),	'admin',	1, UUID()),  --  NSF Energy/Sustainability Report, Quarterly-15 days after
(	325		,	3	, 185,	65	, NOW(),	'admin',	1, UUID()),  --  NSF Energy/Sustainability Report, Quarterly-30 days before
(	326		,	3	, 185,	66	, NOW(),	'admin',	1, UUID()),  --  NSF Energy/Sustainability Report, Quarterly-30 days after
(	327		,	3	, 185,	6	, NOW(),	'admin',	1, UUID()),  --  NSF Energy/Sustainability Report, Semi-annual
(	328		,	3	, 185,	67	, NOW(),	'admin',	1, UUID()),  --  NSF Energy/Sustainability Report, Semi-annual-30 days before
(	329		,	3	, 185,	68	, NOW(),	'admin',	1, UUID()),  --  NSF Energy/Sustainability Report, Semi-annual-30 days after
(	330		,	3	, 185,	7	, NOW(),	'admin',	1, UUID()),  --  NSF Energy/Sustainability Report, Annual
(	331		,	3	, 185,	69	, NOW(),	'admin',	1, UUID()),  --  NSF Energy/Sustainability Report, Annual-30 days before
(	332		,	3	, 185,	32	, NOW(),	'admin',	1, UUID()),  --  NSF Energy/Sustainability Report, Annual-30 days after
(	333		,	3	, 185,	70	, NOW(),	'admin',	1, UUID()),  --  NSF Energy/Sustainability Report, Annual-45 days before
(	334		,	3	, 185,	71	, NOW(),	'admin',	1, UUID()),  --  NSF Energy/Sustainability Report, Annual-45 days after
(	335		,	3	, 185,	72	, NOW(),	'admin',	1, UUID()),  --  NSF Energy/Sustainability Report, Annual-60 days before
(	336		,	3	, 185,	31	, NOW(),	'admin',	1, UUID()),  --  NSF Energy/Sustainability Report, Annual-60 days after
(	337		,	3	, 185,	55	, NOW(),	'admin',	1, UUID()),  --  NSF Energy/Sustainability Report, Annual-90 days before
(	338		,	3	, 185,	75	, NOW(),	'admin',	1, UUID()),  --  NSF Energy/Sustainability Report, Annual-90 days after
(	339		,	3	, 185,	73	, NOW(),	'admin',	1, UUID()),  --  NSF Energy/Sustainability Report, Annual-120 days before
(	340		,	3	, 185,	74	, NOW(),	'admin',	1, UUID()),  --  NSF Energy/Sustainability Report, Annual-120 days after
(	341		,	3	, 190,	14	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), As required
(	342		,	3	, 190,	61	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), 15 days before
(	343		,	3	, 190,	58	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), 15 days after
(	344		,	3	, 190,	15	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), 30 days before
(	345		,	3	, 190,	38	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), 30 days after
(	346		,	3	, 190,	36	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), 45 days before
(	347		,	3	, 190,	33	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), 45 days after
(	348		,	3	, 190,	59	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), 60 days before
(	349		,	3	, 190,	45	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), 60 days after
(	350		,	3	, 190,	17	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), 90 days before
(	351		,	3	, 190,	44	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), 90 days after
(	352		,	3	, 190,	35	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), 120 days before
(	353		,	3	, 190,	62	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), 120 days after
(	354		,	3	, 190,	42	, NOW(),	'admin',	1, UUID()),  --  Patent Certification (DOE F 2050.11), 1 year after
(	355		,	3	, 195,	14	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), As required
(	356		,	3	, 195,	61	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), 15 days before
(	357		,	3	, 195,	58	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), 15 days after
(	358		,	3	, 195,	15	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), 30 days before
(	359		,	3	, 195,	38	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), 30 days after
(	360		,	3	, 195,	36	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), 45 days before
(	361		,	3	, 195,	33	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), 45 days after
(	362		,	3	, 195,	59	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), 60 days before
(	363		,	3	, 195,	45	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), 60 days after
(	364		,	3	, 195,	17	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), 90 days before
(	365		,	3	, 195,	44	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), 90 days after
(	366		,	3	, 195,	35	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), 120 days before
(	367		,	3	, 195,	62	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), 120 days after 
(	368		,	3	, 195,	42	, NOW(),	'admin',	1, UUID()),  --  Property-Inventions-Patents-Royalties (PIPR), 1 year after
(	369		,	3	, 200,	14	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), As required
(	370		,	3	, 200,	61	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), 15 days before
(	371		,	3	, 200,	58	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), 15 days after
(	372		,	3	, 200,	15	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), 30 days before
(	373		,	3	, 200,	38	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), 30 days after
(	374		,	3	, 200,	36	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), 45 days before
(	375		,	3	, 200,	33	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), 45 days after
(	376		,	3	, 200,	59	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), 60 days before
(	377		,	3	, 200,	45	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), 60 days after
(	378		,	3	, 200,	17	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), 90 days before
(	379		,	3	, 200,	44	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), 90 days after
(	380		,	3	, 200,	35	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), 120 days before
(	381		,	3	, 200,	62	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), 120 days after
(	382		,	3	, 200,	42	, NOW(),	'admin',	1, UUID()),  --  Report of Inventions and Subcontracts (DD 882), 1 year after
(	383		,	3	, 205,	63	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, As Required
(	384		,	3	, 205,	2	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, Monthly
(	385		,	3	, 205,	9	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, Bi-monthly
(	386		,	3	, 205,	3	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, Quarterly
(	387		,	3	, 205,	64	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, Quarterly-15 days before
(	388		,	3	, 205,	56	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, Quarterly-15 days after
(	389		,	3	, 205,	65	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, Quarterly-30 days before
(	390		,	3	, 205,	66	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, Quarterly-30 days after
(	391		,	3	, 205,	6	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, Semi-annual
(	392		,	3	, 205,	67	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, Semi-annual-30 days before
(	393		,	3	, 205,	68	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, Semi-annual-30 days after
(	394		,	3	, 205,	7	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, Annual
(	395		,	3	, 205,	69	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, Annual-30 days before
(	396		,	3	, 205,	32	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, Annual-30 days after
(	397		,	3	, 205,	70	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, Annual-45 days before
(	398		,	3	, 205,	71	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, Annual-45 days after
(	399		,	3	, 205,	72	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, Annual-60 days before
(	400		,	3	, 205,	31	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, Annual-60 days after
(	401		,	3	, 205,	55	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, Annual-90 days before
(	402		,	3	, 205,	75	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, Annual-90 days after
(	403		,	3	, 205,	73	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, Annual-120 days before
(	404		,	3	, 205,	74	, NOW(),	'admin',	1, UUID()),  --  Service Contract Act Reporting, Annual-120 days after
(	405		,	3	, 210,	63	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), As Required
(	406		,	3	, 210,	2	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), Monthly
(	407		,	3	, 210,	9	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), Bi-monthly
(	408		,	3	, 210,	3	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), Quarterly
(	409		,	3	, 210,	64	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), Quarterly-15 days before
(	410		,	3	, 210,	56	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), Quarterly-15 days after
(	411		,	3	, 210,	65	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), Quarterly-30 days before
(	412		,	3	, 210,	66	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), Quarterly-30 days after
(	413		,	3	, 210,	6	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), Semi-annual
(	414		,	3	, 210,	67	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), Semi-annual-30 days before
(	415		,	3	, 210,	68	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), Semi-annual-30 days after
(	416		,	3	, 210,	7	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), Annual
(	417		,	3	, 210,	69	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), Annual-30 days before
(	418		,	3	, 210,	32	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), Annual-30 days after
(	419		,	3	, 210,	70	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), Annual-45 days before
(	420		,	3	, 210,	71	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), Annual-45 days after
(	421		,	3	, 210,	72	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), Annual-60 days before
(	422		,	3	, 210,	31	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), Annual-60 days after
(	423		,	3	, 210,	55	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), Annual-90 days before
(	424		,	3	, 210,	75	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), Annual-90 days after
(	425		,	3	, 210,	73	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), Annual-120 days before
(	426		,	3	, 210,	74	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR), Annual-120 days after
(	427		,	3	, 215,	14	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-Final, As required
(	428		,	3	, 215,	61	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-Final, 15 days before
(	429		,	3	, 215,	58	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-Final, 15 days after
(	430		,	3	, 215,	15	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-Final, 30 days before
(	431		,	3	, 215,	38	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-Final, 30 days after
(	432		,	3	, 215,	36	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-Final, 45 days before
(	433		,	3	, 215,	33	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-Final, 45 days after
(	434		,	3	, 215,	59	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-Final, 60 days before
(	435		,	3	, 215,	45	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-Final, 60 days after
(	436		,	3	, 215,	17	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-Final, 90 days before
(	437		,	3	, 215,	44	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-Final, 90 days after
(	438		,	3	, 215,	35	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-Final, 120 days before
(	439		,	3	, 215,	62	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-Final, 120 days after
(	440		,	3	, 215,	42	, NOW(),	'admin',	1, UUID()),  --  Summary Subcontract Report (SSR)-Final, 1 year after
(	441		,	1	, 220,	63	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report, As Required
(	442		,	1	, 220,	2	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report, Monthly
(	443		,	1	, 220,	9	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report, Bi-monthly
(	444		,	1	, 220,	3	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report, Quarterly
(	445		,	1	, 220,	64	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report, Quarterly-15 days before
(	446		,	1	, 220,	56	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report, Quarterly-15 days after
(	447		,	1	, 220,	65	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report, Quarterly-30 days before
(	448		,	1	, 220,	66	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report, Quarterly-30 days after
(	449		,	1	, 220,	6	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report, Semi-annual
(	450		,	1	, 220,	67	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report, Semi-annual-30 days before
(	451		,	1	, 220,	68	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report, Semi-annual-30 days after
(	452		,	1	, 220,	7	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report, Annual
(	453		,	1	, 220,	69	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report, Annual-30 days before
(	454		,	1	, 220,	32	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report, Annual-30 days after
(	455		,	1	, 220,	70	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report, Annual-45 days before
(	456		,	1	, 220,	71	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report, Annual-45 days after
(	457		,	1	, 220,	72	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report, Annual-60 days before
(	458		,	1	, 220,	31	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report, Annual-60 days after
(	459		,	1	, 220,	55	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report, Annual-90 days before
(	460		,	1	, 220,	75	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report, Annual-90 days after
(	461		,	1	, 220,	73	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report, Annual-120 days before
(	462		,	1	, 220,	74	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report, Annual-120 days after
(	463		,	1	, 225,	14	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report-Final , As required
(	464		,	1	, 225,	61	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report-Final , 15 days before
(	465		,	1	, 225,	58	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report-Final , 15 days after
(	466		,	1	, 225,	15	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report-Final , 30 days before
(	467		,	1	, 225,	38	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report-Final , 30 days after
(	468		,	1	, 225,	36	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report-Final , 45 days before
(	469		,	1	, 225,	33	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report-Final , 45 days after
(	470		,	1	, 225,	59	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report-Final , 60 days before
(	471		,	1	, 225,	45	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report-Final , 60 days after
(	472		,	1	, 225,	17	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report-Final , 90 days before
(	473		,	1	, 225,	44	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report-Final , 90 days after
(	474		,	1	, 225,	35	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report-Final , 120 days before
(	475		,	1	, 225,	62	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report-Final , 120 days after
(	476		,	1	, 225,	42	, NOW(),	'admin',	1, UUID()),  --  Cost Share Report-Final , 1 year after
(	477		,	1	, 230,	63	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425), As Required
(	478		,	1	, 230,	2	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425), Monthly
(	479		,	1	, 230,	9	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425), Bi-monthly
(	480		,	1	, 230,	3	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425), Quarterly
(	481		,	1	, 230,	64	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425), Quarterly-15 days before
(	482		,	1	, 230,	56	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425), Quarterly-15 days after
(	483		,	1	, 230,	65	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425), Quarterly-30 days before
(	484		,	1	, 230,	66	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425), Quarterly-30 days after
(	485		,	1	, 230,	6	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425), Semi-annual
(	486		,	1	, 230,	67	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425), Semi-annual-30 days before
(	487		,	1	, 230,	68	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425), Semi-annual-30 days after
(	488		,	1	, 230,	7	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425), Annual
(	489		,	1	, 230,	69	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425), Annual-30 days before
(	490		,	1	, 230,	32	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425), Annual-30 days after
(	491		,	1	, 230,	70	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425), Annual-45 days before
(	492		,	1	, 230,	71	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425), Annual-45 days after
(	493		,	1	, 230,	72	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425), Annual-60 days before
(	494		,	1	, 230,	31	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425), Annual-60 days after
(	495		,	1	, 230,	55	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425), Annual-90 days before
(	496		,	1	, 230,	75	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425), Annual-90 days after
(	497		,	1	, 230,	73	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425), Annual-120 days before
(	498		,	1	, 230,	74	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425), Annual-120 days after
(	499		,	1	, 235,	14	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final , As required
(	500		,	1	, 235,	61	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final , 15 days before
(	501		,	1	, 235,	58	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final , 15 days after
(	502		,	1	, 235,	15	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final , 30 days before
(	503		,	1	, 235,	38	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final , 30 days after
(	504		,	1	, 235,	36	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final , 45 days before
(	505		,	1	, 235,	33	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final , 45 days after
(	506		,	1	, 235,	59	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final , 60 days before
(	507		,	1	, 235,	45	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final , 60 days after
(	508		,	1	, 235,	17	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final , 90 days before
(	509		,	1	, 235,	44	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final , 90 days after
(	510		,	1	, 235,	35	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final , 120 days before
(	511		,	1	, 235,	62	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final , 120 days after
(	512		,	1	, 235,	42	, NOW(),	'admin',	1, UUID()),  --  Federal Financial Report (SF 425)-Final , 1 year after
(	513		,	1	, 240,	14	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final , As required
(	514		,	1	, 240,	61	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final , 15 days before
(	515		,	1	, 240,	58	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final , 15 days after
(	516		,	1	, 240,	15	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final , 30 days before
(	517		,	1	, 240,	38	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final , 30 days after
(	518		,	1	, 240,	36	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final , 45 days before
(	519		,	1	, 240,	33	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final , 45 days after
(	520		,	1	, 240,	59	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final , 60 days before
(	521		,	1	, 240,	45	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final , 60 days after
(	522		,	1	, 240,	17	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final , 90 days before
(	523		,	1	, 240,	44	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final , 90 days after
(	524		,	1	, 240,	35	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final , 120 days before
(	525		,	1	, 240,	62	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final , 120 days after
(	526		,	1	, 240,	42	, NOW(),	'admin',	1, UUID()),  --  Final Financial Report-Final , 1 year after
(	527		,	1	, 245,	63	, NOW(),	'admin',	1, UUID()),  --  Financial Report, As Required
(	528		,	1	, 245,	2	, NOW(),	'admin',	1, UUID()),  --  Financial Report, Monthly
(	529		,	1	, 245,	9	, NOW(),	'admin',	1, UUID()),  --  Financial Report, Bi-monthly
(	530		,	1	, 245,	3	, NOW(),	'admin',	1, UUID()),  --  Financial Report, Quarterly
(	531		,	1	, 245,	64	, NOW(),	'admin',	1, UUID()),  --  Financial Report, Quarterly-15 days before
(	532		,	1	, 245,	56	, NOW(),	'admin',	1, UUID()),  --  Financial Report, Quarterly-15 days after
(	533		,	1	, 245,	65	, NOW(),	'admin',	1, UUID()),  --  Financial Report, Quarterly-30 days before
(	534		,	1	, 245,	66	, NOW(),	'admin',	1, UUID()),  --  Financial Report, Quarterly-30 days after
(	535		,	1	, 245,	6	, NOW(),	'admin',	1, UUID()),  --  Financial Report, Semi-annual
(	536		,	1	, 245,	67	, NOW(),	'admin',	1, UUID()),  --  Financial Report, Semi-annual-30 days before
(	537		,	1	, 245,	68	, NOW(),	'admin',	1, UUID()),  --  Financial Report, Semi-annual-30 days after
(	538		,	1	, 245,	7	, NOW(),	'admin',	1, UUID()),  --  Financial Report, Annual
(	539		,	1	, 245,	69	, NOW(),	'admin',	1, UUID()),  --  Financial Report, Annual-30 days before
(	540		,	1	, 245,	32	, NOW(),	'admin',	1, UUID()),  --  Financial Report, Annual-30 days after
(	541		,	1	, 245,	70	, NOW(),	'admin',	1, UUID()),  --  Financial Report, Annual-45 days before
(	542		,	1	, 245,	71	, NOW(),	'admin',	1, UUID()),  --  Financial Report, Annual-45 days after
(	543		,	1	, 245,	72	, NOW(),	'admin',	1, UUID()),  --  Financial Report, Annual-60 days before
(	544		,	1	, 245,	31	, NOW(),	'admin',	1, UUID()),  --  Financial Report, Annual-60 days after
(	545		,	1	, 245,	55	, NOW(),	'admin',	1, UUID()),  --  Financial Report, Annual-90 days before
(	546		,	1	, 245,	75	, NOW(),	'admin',	1, UUID()),  --  Financial Report, Annual-90 days after
(	547		,	1	, 245,	73	, NOW(),	'admin',	1, UUID()),  --  Financial Report, Annual-120 days before
(	548		,	1	, 245,	74	, NOW(),	'admin',	1, UUID()),  --  Financial Report, Annual-120 days after
(	549		,	1	, 250,	63	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M), As Required
(	550		,	1	, 250,	2	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M), Monthly
(	551		,	1	, 250,	9	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M), Bi-monthly
(	552		,	1	, 250,	3	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M), Quarterly
(	553		,	1	, 250,	64	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M), Quarterly-15 days before
(	554		,	1	, 250,	56	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M), Quarterly-15 days after
(	555		,	1	, 250,	65	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M), Quarterly-30 days before
(	556		,	1	, 250,	66	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M), Quarterly-30 days after
(	557		,	1	, 250,	6	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M), Semi-annual
(	558		,	1	, 250,	67	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M), Semi-annual-30 days before
(	559		,	1	, 250,	68	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M), Semi-annual-30 days after
(	560		,	1	, 250,	7	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M), Annual
(	561		,	1	, 250,	69	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M), Annual-30 days before
(	562		,	1	, 250,	32	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M), Annual-30 days after
(	563		,	1	, 250,	70	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M), Annual-45 days before
(	564		,	1	, 250,	71	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M), Annual-45 days after
(	565		,	1	, 250,	72	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M), Annual-60 days before
(	566		,	1	, 250,	31	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M), Annual-60 days after
(	567		,	1	, 250,	55	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M), Annual-90 days before
(	568		,	1	, 250,	75	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M), Annual-90 days after
(	569		,	1	, 250,	73	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M), Annual-120 days before
(	570		,	1	, 250,	74	, NOW(),	'admin',	1, UUID()),  --  NASA Monthly Contract Financial Management Report (NASA 533M), Annual-120 days after
(	571		,	7	, 255,	63	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, As Required
(	572		,	7	, 255,	2	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, Monthly
(	573		,	7	, 255,	9	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, Bi-monthly
(	574		,	7	, 255,	3	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, Quarterly
(	575		,	7	, 255,	64	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, Quarterly-15 days before
(	576		,	7	, 255,	56	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, Quarterly-15 days after
(	577		,	7	, 255,	65	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, Quarterly-30 days before
(	578		,	7	, 255,	66	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, Quarterly-30 days after
(	579		,	7	, 255,	6	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, Semi-annual
(	580		,	7	, 255,	67	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, Semi-annual-30 days before
(	581		,	7	, 255,	68	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, Semi-annual-30 days after
(	582		,	7	, 255,	7	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, Annual
(	583		,	7	, 255,	69	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, Annual-30 days before
(	584		,	7	, 255,	32	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, Annual-30 days after
(	585		,	7	, 255,	70	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, Annual-45 days before
(	586		,	7	, 255,	71	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, Annual-45 days after
(	587		,	7	, 255,	72	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, Annual-60 days before
(	588		,	7	, 255,	31	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, Annual-60 days after
(	589		,	7	, 255,	55	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, Annual-90 days before
(	590		,	7	, 255,	75	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, Annual-90 days after
(	591		,	7	, 255,	73	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, Annual-120 days before
(	592		,	7	, 255,	74	, NOW(),	'admin',	1, UUID()),  --  Invention Disclosures, Annual-120 days after
(	593		,	7	, 260,	63	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, As Required
(	594		,	7	, 260,	2	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, Monthly
(	595		,	7	, 260,	9	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, Bi-monthly
(	596		,	7	, 260,	3	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, Quarterly
(	597		,	7	, 260,	64	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, Quarterly-15 days before
(	598		,	7	, 260,	56	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, Quarterly-15 days after
(	599		,	7	, 260,	65	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, Quarterly-30 days before
(	600		,	7	, 260,	66	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, Quarterly-30 days after
(	601		,	7	, 260,	6	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, Semi-annual
(	602		,	7	, 260,	67	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, Semi-annual-30 days before
(	603		,	7	, 260,	68	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, Semi-annual-30 days after
(	604		,	7	, 260,	7	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, Annual
(	605		,	7	, 260,	69	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, Annual-30 days before
(	606		,	7	, 260,	32	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, Annual-30 days after
(	607		,	7	, 260,	70	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, Annual-45 days before
(	608		,	7	, 260,	71	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, Annual-45 days after
(	609		,	7	, 260,	72	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, Annual-60 days before
(	610		,	7	, 260,	31	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, Annual-60 days after
(	611		,	7	, 260,	55	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, Annual-90 days before
(	612		,	7	, 260,	75	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, Annual-90 days after
(	613		,	7	, 260,	73	, NOW(),	'admin',	1, UUID()),  --  Patent Applications, Annual-120 days before
(	614		,	7	, 260,	74	, NOW(),	'admin',	1, UUID()), --  Patent Applications, Annual-120 days after*/
(	615		,	7	,265,	63	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, As Required
(	616		,	7	,265,	2	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, Monthly
(	617		,	7	,265,	9	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, Bi-monthly
(	618		,	7	,265,	3	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, Quarterly
(	619		,	7	,265,	64	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, Quarterly-15 days before
(	620		,	7	,265,	56	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, Quarterly-15 days after
(	621		,	7	,265,	65	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, Quarterly-30 days before
(	622		,	7	,265,	66	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, Quarterly-30 days after
(	623		,	7	,265,	6	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, Semi-annual
(	624		,	7	,265,	67	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, Semi-annual-30 days before
(	625		,	7	,265,	68	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, Semi-annual-30 days after
(	626		,	7	,265,	7	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, Annual
(	627		,	7	,265,	69	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, Annual-30 days before
(	628		,	7	,265,	32	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, Annual-30 days after
(	629		,	7	,265,	70	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, Annual-45 days before
(	630		,	7	,265,	71	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, Annual-45 days after
(	631		,	7	,265,	72	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, Annual-60 days before
(	632		,	7	,265,	31	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, Annual-60 days after
(	633		,	7	,265,	55	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, Annual-90 days before
(	634		,	7	,265,	75	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, Annual-90 days after
(	635		,	7	,265,	73	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, Annual-120 days before
(	636		,	7	,265,	74	, NOW(),	'admin',	1, UUID()),  --  Patent Documentation, Annual-120 days after
(	637		,	6	, 270,	63	, NOW(),	'admin',	1, UUID()),  --  Invoice, As Required
(	638		,	6	, 270,	2	, NOW(),	'admin',	1, UUID()),  --  Invoice, Monthly
(	639		,	6	, 270,	9	, NOW(),	'admin',	1, UUID()),  --  Invoice, Bi-monthly
(	640		,	6	, 270,	3	, NOW(),	'admin',	1, UUID()),  --  Invoice, Quarterly
(	641		,	6	, 270,	64	, NOW(),	'admin',	1, UUID()),  --  Invoice, Quarterly-15 days before
(	642		,	6	, 270,	56	, NOW(),	'admin',	1, UUID()),  --  Invoice, Quarterly-15 days after
(	643		,	6	, 270,	65	, NOW(),	'admin',	1, UUID()),  --  Invoice, Quarterly-30 days before
(	644		,	6	, 270,	66	, NOW(),	'admin',	1, UUID()),  --  Invoice, Quarterly-30 days after
(	645		,	6	, 270,	6	, NOW(),	'admin',	1, UUID()),  --  Invoice, Semi-annual
(	646		,	6	, 270,	67	, NOW(),	'admin',	1, UUID()),  --  Invoice, Semi-annual-30 days before
(	647		,	6	, 270,	68	, NOW(),	'admin',	1, UUID()),  --  Invoice, Semi-annual-30 days after
(	648		,	6	, 270,	7	, NOW(),	'admin',	1, UUID()),  --  Invoice, Annual
(	649		,	6	, 270,	69	, NOW(),	'admin',	1, UUID()),  --  Invoice, Annual-30 days before
(	650		,	6	, 270,	32	, NOW(),	'admin',	1, UUID()),  --  Invoice, Annual-30 days after
(	651		,	6	, 270,	70	, NOW(),	'admin',	1, UUID()),  --  Invoice, Annual-45 days before
(	652		,	6	, 270,	71	, NOW(),	'admin',	1, UUID()),  --  Invoice, Annual-45 days after
(	653		,	6	, 270,	72	, NOW(),	'admin',	1, UUID()),  --  Invoice, Annual-60 days before
(	654		,	6	, 270,	31	, NOW(),	'admin',	1, UUID()),  --  Invoice, Annual-60 days after
(	655		,	6	, 270,	55	, NOW(),	'admin',	1, UUID()),  --  Invoice, Annual-90 days before
(	656		,	6	, 270,	75	, NOW(),	'admin',	1, UUID()),  --  Invoice, Annual-90 days after
(	657		,	6	, 270,	73	, NOW(),	'admin',	1, UUID()),  --  Invoice, Annual-120 days before
(	658		,	6	, 270,	74	, NOW(),	'admin',	1, UUID()),  --  Invoice, Annual-120 days after
(	659		,	6	, 275,	14	, NOW(),	'admin',	1, UUID()),  --  Invoice-Final , As required
(	660		,	6	, 275,	61	, NOW(),	'admin',	1, UUID()),  --  Invoice-Final , 15 days before
(	661		,	6	, 275,	58	, NOW(),	'admin',	1, UUID()),  --  Invoice-Final , 15 days after
(	662		,	6	, 275,	15	, NOW(),	'admin',	1, UUID()),  --  Invoice-Final , 30 days before
(	663		,	6	, 275,	38	, NOW(),	'admin',	1, UUID()),  --  Invoice-Final , 30 days after
(	664		,	6	, 275,	36	, NOW(),	'admin',	1, UUID()),  --  Invoice-Final , 45 days before
(	665		,	6	, 275,	33	, NOW(),	'admin',	1, UUID()),  --  Invoice-Final , 45 days after
(	666		,	6	, 275,	59	, NOW(),	'admin',	1, UUID()),  --  Invoice-Final , 60 days before
(	667		,	6	, 275,	45	, NOW(),	'admin',	1, UUID()),  --  Invoice-Final , 60 days after
(	668		,	6	, 275,	17	, NOW(),	'admin',	1, UUID()),  --  Invoice-Final , 90 days before
(	669		,	6	, 275,	44	, NOW(),	'admin',	1, UUID()),  --  Invoice-Final , 90 days after
(	670		,	6	, 275,	35	, NOW(),	'admin',	1, UUID()),  --  Invoice-Final , 120 days before
(	671		,	6	, 275,	62	, NOW(),	'admin',	1, UUID()),  --  Invoice-Final , 120 days after
(	672		,	6	, 275,	42	, NOW(),	'admin',	1, UUID()),  --  Invoice-Final , 1 year after
(	673		,	6	, 280,	63	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation, As Required
(	674		,	6	, 280,	2	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation, Monthly
(	675		,	6	, 280,	9	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation, Bi-monthly
(	676		,	6	, 280,	3	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation, Quarterly
(	677		,	6	, 280,	64	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation, Quarterly-15 days before
(	678		,	6	, 280,	56	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation, Quarterly-15 days after
(	679		,	6	, 280,	65	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation, Quarterly-30 days before
(	680		,	6	, 280,	66	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation, Quarterly-30 days after
(	681		,	6	, 280,	6	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation, Semi-annual
(	682		,	6	, 280,	67	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation, Semi-annual-30 days before
(	683		,	6	, 280,	68	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation, Semi-annual-30 days after
(	684		,	6	, 280,	7	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation, Annual
(	685		,	6	, 280,	69	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation, Annual-30 days before
(	686		,	6	, 280,	32	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation, Annual-30 days after
(	687		,	6	, 280,	70	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation, Annual-45 days before
(	688		,	6	, 280,	71	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation, Annual-45 days after
(	689		,	6	, 280,	72	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation, Annual-60 days before
(	690		,	6	, 280,	31	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation, Annual-60 days after
(	691		,	6	, 280,	55	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation, Annual-90 days before
(	692		,	6	, 280,	75	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation, Annual-90 days after
(	693		,	6	, 280,	73	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation, Annual-120 days before
(	694		,	6	, 280,	74	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation, Annual-120 days after
(	695		,	6	, 285,	14	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final , As required
(	696		,	6	, 285,	61	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final , 15 days before
(	697		,	6	, 285,	58	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final , 15 days after
(	698		,	6	, 285,	15	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final , 30 days before
(	699		,	6	, 285,	38	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final , 30 days after
(	700		,	6	, 285,	36	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final , 45 days before
(	701		,	6	, 285,	33	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final , 45 days after
(	702		,	6	, 285,	59	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final , 60 days before
(	703		,	6	, 285,	45	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final , 60 days after
(	704		,	6	, 285,	17	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final , 90 days before
(	705		,	6	, 285,	44	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final , 90 days after
(	706		,	6	, 285,	35	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final , 120 days before
(	707		,	6	, 285,	62	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final , 120 days after
(	708		,	6	, 285,	42	, NOW(),	'admin',	1, UUID()),  --  Invoice with Supporting Documentation-Final , 1 year after
(	709		,	6	, 290,	63	, NOW(),	'admin',	1, UUID()),  --  Invoice Signature, As Required
(	710		,	6	, 290,	2	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature , Monthly
(	711		,	6	, 290,	9	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature , Bi-monthly
(	712		,	6	, 290,	3	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature , Quarterly
(	713		,	6	, 290,	64	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature , Quarterly-15 days before
(	714		,	6	, 290,	56	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature , Quarterly-15 days after
(	715		,	6	, 290,	65	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature , Quarterly-30 days before
(	716		,	6	, 290,	66	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature , Quarterly-30 days after
(	717		,	6	, 290,	6	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature , Semi-annual
(	718		,	6	, 290,	67	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature , Semi-annual-30 days before
(	719		,	6	, 290,	68	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature , Semi-annual-30 days after
(	720		,	6	, 290,	7	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature , Annual
(	721		,	6	, 290,	69	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature , Annual-30 days before
(	722		,	6	, 290,	32	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature , Annual-30 days after
(	723		,	6	, 290,	70	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature , Annual-45 days before
(	724		,	6	, 290,	71	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature , Annual-45 days after
(	725		,	6	, 290,	72	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature , Annual-60 days before
(	726		,	6	, 290,	31	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature , Annual-60 days after
(	727		,	6	, 290,	55	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature , Annual-90 days before
(	728		,	6	, 290,	75	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature , Annual-90 days after
(	729		,	6	, 290,	73	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature , Annual-120 days before
(	730		,	6	, 290,	74	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature , Annual-120 days after
(	731		,	6	, 295,	14	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature -Final , As required
(	732		,	6	, 295,	61	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature -Final , 15 days before
(	733		,	6	, 295,	58	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature -Final , 15 days after
(	734		,	6	, 295,	15	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature -Final , 30 days before
(	735		,	6	, 295,	38	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature -Final , 30 days after
(	736		,	6	, 295,	36	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature -Final , 45 days before
(	737		,	6	, 295,	33	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature -Final , 45 days after
(	738		,	6	, 295,	59	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature -Final , 60 days before
(	739		,	6	, 295,	45	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature -Final , 60 days after
(	740		,	6	, 295,	17	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature -Final , 90 days before
(	741		,	6	, 295,	44	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature -Final , 90 days after
(	742		,	6	, 295,	35	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature -Final , 120 days before
(	743		,	6	, 295,	62	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature -Final , 120 days after
(	744		,	6	, 295,	42	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature -Final , 1 year after
(	745		,	6	, 300,	63	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation, As Required
(	746		,	6	, 300,	2	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation , Monthly
(	747		,	6	, 300,	9	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation , Bi-monthly
(	748		,	6	, 300,	3	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation , Quarterly
(	749		,	6	, 300,	64	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation , Quarterly-15 days before
(	750		,	6	, 300,	56	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation , Quarterly-15 days after
(	751		,	6	, 300,	65	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation , Quarterly-30 days before
(	752		,	6	, 300,	66	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation , Quarterly-30 days after
(	753		,	6	, 300,	6	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation , Semi-annual
(	754		,	6	, 300,	67	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation , Semi-annual-30 days before
(	755		,	6	, 300,	68	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation , Semi-annual-30 days after
(	756		,	6	, 300,	7	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation , Annual
(	757		,	6	, 300,	69	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation , Annual-30 days before
(	758		,	6	, 300,	32	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation , Annual-30 days after
(	759		,	6	, 300,	70	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation , Annual-45 days before
(	760		,	6	, 300,	71	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation , Annual-45 days after
(	761		,	6	, 300,	72	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation , Annual-60 days before
(	762		,	6	, 300,	31	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation , Annual-60 days after
(	763		,	6	, 300,	55	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation , Annual-90 days before
(	764		,	6	, 300,	75	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation , Annual-90 days after
(	765		,	6	, 300,	73	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation , Annual-120 days before
(	766		,	6	, 300,	74	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation , Annual-120 days after
(	767		,	6	, 305,	14	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation -Final , As required
(	768		,	6	, 305,	61	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation -Final , 15 days before
(	769		,	6	, 305,	58	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation -Final , 15 days after
(	770		,	6	, 305,	15	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation -Final , 30 days before
(	771		,	6	, 305,	38	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation -Final , 30 days after
(	772		,	6	, 305,	36	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation -Final , 45 days before
(	773		,	6	, 305,	33	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation -Final , 45 days after
(	774		,	6	, 305,	59	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation -Final , 60 days before
(	775		,	6	, 305,	45	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation -Final , 60 days after
(	776		,	6	, 305,	17	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation -Final , 90 days before
(	777		,	6	, 305,	44	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation -Final , 90 days after
(	778		,	6	, 305,	35	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation -Final , 120 days before
(	779		,	6	, 305,	62	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation -Final , 120 days after
(	780		,	6	, 305,	42	, NOW(),	'admin',	1, UUID()),  --  Invoice-Signature with Supporting Documentation -Final , 1 year after
(	781		,	6	, 310,	63	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form , As Required
(	782		,	6	, 310,	2	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form , Monthly
(	783		,	6	, 310,	9	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form , Bi-monthly
(	784		,	6	, 310,	3	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form , Quarterly
(	785		,	6	, 310,	64	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form , Quarterly-15 days before
(	786		,	6	, 310,	56	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form , Quarterly-15 days after
(	787		,	6	, 310,	65	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form , Quarterly-30 days before
(	788		,	6	, 310,	66	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form , Quarterly-30 days after
(	789		,	6	, 310,	6	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form , Semi-annual
(	790		,	6	, 310,	67	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form , Semi-annual-30 days before
(	791		,	6	, 310,	68	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form , Semi-annual-30 days after
(	792		,	6	, 310,	7	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form , Annual
(	793		,	6	, 310,	69	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form , Annual-30 days before
(	794		,	6	, 310,	32	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form , Annual-30 days after
(	795		,	6	, 310,	70	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form , Annual-45 days before
(	796		,	6	, 310,	71	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form , Annual-45 days after
(	797		,	6	, 310,	72	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form , Annual-60 days before
(	798		,	6	, 310,	31	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form , Annual-60 days after
(	799		,	6	, 310,	55	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form , Annual-90 days before
(	800		,	6	, 310,	75	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form , Annual-90 days after
(	801		,	6	, 310,	73	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form , Annual-120 days before
(	802		,	6	, 310,	74	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form , Annual-120 days after
(	803		,	6	, 315,	14	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form -Final , As required
(	804		,	6	, 315,	61	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form -Final , 15 days before
(	805		,	6	, 315,	58	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form -Final , 15 days after
(	806		,	6	, 315,	15	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form -Final , 30 days before
(	807		,	6	, 315,	38	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form -Final , 30 days after
(	808		,	6	, 315,	36	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form -Final , 45 days before
(	809		,	6	, 315,	33	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form -Final , 45 days after
(	810		,	6	, 315,	59	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form -Final , 60 days before
(	811		,	6	, 315,	45	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form -Final , 60 days after
(	812		,	6	, 315,	17	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form -Final , 90 days before
(	813		,	6	, 315,	44	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form -Final , 90 days after
(	814		,	6	, 315,	35	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form -Final , 120 days before
(	815		,	6	, 315,	62	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form -Final , 120 days after
(	816		,	6	, 315,	42	, NOW(),	'admin',	1, UUID()),  --  Invoice-Sponsor Form -Final , 1 year after
(	817		,	6	, 320,	63	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment , As Required
(	818		,	6	, 320,	2	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment , Monthly
(	819		,	6	, 320,	9	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment , Bi-monthly
(	820		,	6	, 320,	3	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment , Quarterly
(	821		,	6	, 320,	64	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment , Quarterly-15 days before
(	822		,	6	, 320,	56	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment , Quarterly-15 days after
(	823		,	6	, 320,	65	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment , Quarterly-30 days before
(	824		,	6	, 320,	66	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment , Quarterly-30 days after
(	825		,	6	, 320,	6	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment , Semi-annual
(	826		,	6	, 320,	67	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment , Semi-annual-30 days before
(	827		,	6	, 320,	68	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment , Semi-annual-30 days after
(	828		,	6	, 320,	7	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment , Annual
(	829		,	6	, 320,	69	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment , Annual-30 days before
(	830		,	6	, 320,	32	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment , Annual-30 days after
(	831		,	6	, 320,	70	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment , Annual-45 days before
(	832		,	6	, 320,	71	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment , Annual-45 days after
(	833		,	6	, 320,	72	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment , Annual-60 days before
(	834		,	6	, 320,	31	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment , Annual-60 days after
(	835		,	6	, 320,	55	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment , Annual-90 days before
(	836		,	6	, 320,	75	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment , Annual-90 days after
(	837		,	6	, 320,	73	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment , Annual-120 days before
(	838		,	6	, 320,	74	, NOW(),	'admin',	1, UUID()),  --  Online Request for Payment , Annual-120 days after
(	839		,	6	,325,	63	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034) , As Required
(	840		,	6	,325,	2	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034) , Monthly
(	841		,	6	,325,	9	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034) , Bi-monthly
(	842		,	6	,325,	3	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034) , Quarterly
(	843		,	6	,325,	64	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034) , Quarterly-15 days before
(	844		,	6	,325,	56	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034) , Quarterly-15 days after
(	845		,	6	,325,	65	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034) , Quarterly-30 days before
(	846		,	6	,325,	66	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034) , Quarterly-30 days after
(	847		,	6	,325,	6	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034) , Semi-annual
(	848		,	6	,325,	67	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034) , Semi-annual-30 days before
(	849		,	6	,325,	68	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034) , Semi-annual-30 days after
(	850		,	6	,325,	7	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034) , Annual
(	851		,	6	,325,	69	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034) , Annual-30 days before
(	852		,	6	,325,	32	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034) , Annual-30 days after
(	853		,	6	,325,	70	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034) , Annual-45 days before
(	854		,	6	,325,	71	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034) , Annual-45 days after
(	855		,	6	,325,	72	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034) , Annual-60 days before
(	856		,	6	,325,	31	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034) , Annual-60 days after
(	857		,	6	,325,	55	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034) , Annual-90 days before
(	858		,	6	,325,	75	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034) , Annual-90 days after
(	859		,	6	,325,	73	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034) , Annual-120 days before
(	860		,	6	,325,	74	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases and Services (SF1034) , Annual-120 days after
(	861		,	6	, 330,	63	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035) , As Required
(	862		,	6	, 330,	2	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035) , Monthly
(	863		,	6	, 330,	9	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035) , Bi-monthly
(	864		,	6	, 330,	3	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035) , Quarterly
(	865		,	6	, 330,	64	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035) , Quarterly-15 days before
(	866		,	6	, 330,	56	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035) , Quarterly-15 days after
(	867		,	6	, 330,	65	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035) , Quarterly-30 days before
(	868		,	6	, 330,	66	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035) , Quarterly-30 days after
(	869		,	6	, 330,	6	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035) , Semi-annual
(	870		,	6	, 330,	67	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035) , Semi-annual-30 days before
(	871		,	6	, 330,	68	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035) , Semi-annual-30 days after
(	872		,	6	, 330,	7	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035) , Annual
(	873		,	6	, 330,	69	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035) , Annual-30 days before
(	874		,	6	, 330,	32	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035) , Annual-30 days after
(	875		,	6	, 330,	70	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035) , Annual-45 days before
(	876		,	6	, 330,	71	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035) , Annual-45 days after
(	877		,	6	, 330,	72	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035) , Annual-60 days before
(	878		,	6	, 330,	31	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035) , Annual-60 days after
(	879		,	6	, 330,	55	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035) , Annual-90 days before
(	880		,	6	, 330,	75	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035) , Annual-90 days after
(	881		,	6	, 330,	73	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035) , Annual-120 days before
(	882		,	6	, 330,	74	, NOW(),	'admin',	1, UUID()),  --  Public Voucher for Purchases-Continuation Sheet (SF1035) , Annual-120 days after
(	883		,	6	,335,	63	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) , As Required
(	884		,	6	,335,	2	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) , Monthly
(	885		,	6	,335,	9	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) , Bi-monthly
(	886		,	6	,335,	3	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) , Quarterly
(	887		,	6	,335,	64	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) , Quarterly-15 days before
(	888		,	6	,335,	56	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) , Quarterly-15 days after
(	889		,	6	,335,	65	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) , Quarterly-30 days before
(	890		,	6	,335,	66	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) , Quarterly-30 days after
(	891		,	6	,335,	6	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) , Semi-annual
(	892		,	6	,335,	67	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) , Semi-annual-30 days before
(	893		,	6	,335,	68	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) , Semi-annual-30 days after
(	894		,	6	,335,	7	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) , Annual
(	895		,	6	,335,	69	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) , Annual-30 days before
(	896		,	6	,335,	32	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) , Annual-30 days after
(	897		,	6	,335,	70	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) , Annual-45 days before
(	898		,	6	,335,	71	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) , Annual-45 days after
(	899		,	6	,335,	72	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) , Annual-60 days before
(	900		,	6	,335,	31	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) , Annual-60 days after
(	901		,	6	,335,	55	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) , Annual-90 days before
(	902		,	6	,335,	75	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) , Annual-90 days after
(	903		,	6	,335,	73	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) , Annual-120 days before
(	904		,	6	,335,	74	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) , Annual-120 days after
(	905		,	6	, 340,	14	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) - Final , As required
(	906		,	6	, 340,	61	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) - Final , 15 days before
(	907		,	6	, 340,	58	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) - Final , 15 days after
(	908		,	6	, 340,	15	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) - Final , 30 days before
(	909		,	6	, 340,	38	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) - Final , 30 days after
(	910		,	6	, 340,	36	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) - Final , 45 days before
(	911		,	6	, 340,	33	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) - Final , 45 days after
(	912		,	6	, 340,	59	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) - Final , 60 days before
(	913		,	6	, 340,	45	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) - Final , 60 days after
(	914		,	6	, 340,	17	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) - Final , 90 days before
(	915		,	6	, 340,	44	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) - Final , 90 days after
(	916		,	6	, 340,	35	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) - Final , 120 days before
(	917		,	6	, 340,	62	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) - Final , 120 days after
(	918		,	6	, 340,	42	, NOW(),	'admin',	1, UUID()),  --  Request for Advance or Reimbursement (SF270) - Final , 1 year after
(	919		,	2	, 345,	63	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43) , As Required
(	920		,	2	, 345,	2	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43) , Monthly
(	921		,	2	, 345,	9	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43) , Bi-monthly
(	922		,	2	, 345,	3	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43) , Quarterly
(	923		,	2	, 345,	64	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43) , Quarterly-15 days before
(	924		,	2	, 345,	56	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43) , Quarterly-15 days after
(	925		,	2	, 345,	65	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43) , Quarterly-30 days before
(	926		,	2	, 345,	66	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43) , Quarterly-30 days after
(	927		,	2	, 345,	6	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43) , Semi-annual
(	928		,	2	, 345,	67	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43) , Semi-annual-30 days before
(	929		,	2	, 345,	68	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43) , Semi-annual-30 days after
(	930		,	2	, 345,	7	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43) , Annual
(	931		,	2	, 345,	69	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43) , Annual-30 days before
(	932		,	2	, 345,	32	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43) , Annual-30 days after
(	933		,	2	, 345,	70	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43) , Annual-45 days before
(	934		,	2	, 345,	71	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43) , Annual-45 days after
(	935		,	2	, 345,	72	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43) , Annual-60 days before
(	936		,	2	, 345,	31	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43) , Annual-60 days after
(	937		,	2	, 345,	55	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43) , Annual-90 days before
(	938		,	2	, 345,	75	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43) , Annual-90 days after
(	939		,	2	, 345,	73	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43) , Annual-120 days before
(	940		,	2	, 345,	74	, NOW(),	'admin',	1, UUID()),  --  Contractor Report of Government Property-DOT (F 4220.43) , Annual-120 days after
(	941		,	2	, 350,	14	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428) , As required
(	942		,	2	, 350,	61	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428) , 15 days before
(	943		,	2	, 350,	58	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428) , 15 days after
(	944		,	2	, 350,	15	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428) , 30 days before
(	945		,	2	, 350,	38	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428) , 30 days after
(	946		,	2	, 350,	36	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428) , 45 days before
(	947		,	2	, 350,	33	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428) , 45 days after
(	948		,	2	, 350,	59	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428) , 60 days before
(	949		,	2	, 350,	45	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428) , 60 days after
(	950		,	2	, 350,	17	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428) , 90 days before
(	951		,	2	, 350,	44	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428) , 90 days after
(	952		,	2	, 350,	35	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428) , 120 days before
(	953		,	2	, 350,	62	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428) , 120 days after
(	954		,	2	, 350,	42	, NOW(),	'admin',	1, UUID()),  --  Inventory Disposal Schedule (SF 1428) , 1 year after
(	955		,	2	, 355,	63	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form, As Required
(	956		,	2	, 355,	2	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form , Monthly
(	957		,	2	, 355,	9	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form , Bi-monthly
(	958		,	2	, 355,	3	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form , Quarterly
(	959		,	2	, 355,	64	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form , Quarterly-15 days before
(	960		,	2	, 355,	56	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form , Quarterly-15 days after
(	961		,	2	, 355,	65	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form , Quarterly-30 days before
(	962		,	2	, 355,	66	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form , Quarterly-30 days after
(	963		,	2	, 355,	6	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form , Semi-annual
(	964		,	2	, 355,	67	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form , Semi-annual-30 days before
(	965		,	2	, 355,	68	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form , Semi-annual-30 days after
(	966		,	2	, 355,	7	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form , Annual
(	967		,	2	, 355,	69	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form , Annual-30 days before
(	968		,	2	, 355,	32	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form , Annual-30 days after
(	969		,	2	, 355,	70	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form , Annual-45 days before
(	970		,	2	, 355,	71	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form , Annual-45 days after
(	971		,	2	, 355,	72	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form , Annual-60 days before
(	972		,	2	, 355,	31	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form , Annual-60 days after
(	973		,	2	, 355,	55	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form , Annual-90 days before
(	974		,	2	, 355,	75	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form , Annual-90 days after
(	975		,	2	, 355,	73	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form , Annual-120 days before
(	976		,	2	, 355,	74	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form , Annual-120 days after
(	977		,	2	, 360,	14	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form-Final , As required
(	978		,	2	, 360,	61	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form-Final , 15 days before
(	979		,	2	, 360,	58	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form-Final , 15 days after
(	980		,	2	, 360,	15	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form-Final , 30 days before
(	981		,	2	, 360,	38	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form-Final , 30 days after
(	982		,	2	, 360,	36	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form-Final , 45 days before
(	983		,	2	, 360,	33	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form-Final , 45 days after
(	984		,	2	, 360,	59	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form-Final , 60 days before
(	985		,	2	, 360,	45	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form-Final , 60 days after
(	986		,	2	, 360,	17	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form-Final , 90 days before
(	987		,	2	, 360,	44	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form-Final , 90 days after
(	988		,	2	, 360,	35	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form-Final , 120 days before
(	989		,	2	, 360,	62	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form-Final , 120 days after
(	990		,	2	, 360,	42	, NOW(),	'admin',	1, UUID()),  --  Property -Sponsor Form-Final , 1 year after
(	991		,	2	, 365,	63	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018) , As Required
(	992		,	2	, 365,	2	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018) , Monthly
(	993		,	2	, 365,	9	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018) , Bi-monthly
(	994		,	2	, 365,	3	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018) , Quarterly
(	995		,	2	, 365,	64	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018) , Quarterly-15 days before
(	996		,	2	, 365,	56	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018) , Quarterly-15 days after
(	997		,	2	, 365,	65	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018) , Quarterly-30 days before
(	998		,	2	, 365,	66	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018) , Quarterly-30 days after
(	999		,	2	, 365,	6	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018) , Semi-annual
(	1000		,	2	, 365,	67	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018) , Semi-annual-30 days before
(	1001		,	2	, 365,	68	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018) , Semi-annual-30 days after
(	1002		,	2	, 365,	7	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018) , Annual
(	1003		,	2	, 365,	69	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018) , Annual-30 days before
(	1004		,	2	, 365,	32	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018) , Annual-30 days after
(	1005		,	2	, 365,	70	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018) , Annual-45 days before
(	1006		,	2	, 365,	71	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018) , Annual-45 days after
(	1007		,	2	, 365,	72	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018) , Annual-60 days before
(	1008		,	2	, 365,	31	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018) , Annual-60 days after
(	1009		,	2	, 365,	55	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018) , Annual-90 days before
(	1010		,	2	, 365,	75	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018) , Annual-90 days after
(	1011		,	2	, 365,	73	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018) , Annual-120 days before
(	1012		,	2	, 365,	74	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018) , Annual-120 days after
(	1013		,	2	, 370,	14	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018), As required
(	1014		,	2	, 370,	61	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018), 15 days before
(	1015		,	2	, 370,	58	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018), 15 days after
(	1016		,	2	, 370,	15	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018), 30 days before
(	1017		,	2	, 370,	38	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018), 30 days after
(	1018		,	2	, 370,	36	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018), 45 days before
(	1019		,	2	, 370,	33	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018), 45 days after
(	1020		,	2	, 370,	59	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018), 60 days before
(	1021		,	2	, 370,	45	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018), 60 days after
(	1022		,	2	, 370,	17	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018), 90 days before
(	1023		,	2	, 370,	44	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018), 90 days after
(	1024		,	2	, 370,	35	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018), 120 days before
(	1025		,	2	, 370,	62	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018), 120 days after
(	1026		,	2	, 370,	42	, NOW(),	'admin',	1, UUID()),  --  Property in the Custody of Contractors-NASA (SF 1018), 1 year after
(	1027		,	2	, 375,	63	, NOW(),	'admin',	1, UUID()),  --  Property Report , As Required
(	1028		,	2	, 375,	2	, NOW(),	'admin',	1, UUID()),  --  Property Report , Monthly
(	1029		,	2	, 375,	9	, NOW(),	'admin',	1, UUID()),  --  Property Report , Bi-monthly
(	1030		,	2	, 375,	3	, NOW(),	'admin',	1, UUID()),  --  Property Report , Quarterly
(	1031		,	2	, 375,	64	, NOW(),	'admin',	1, UUID()),  --  Property Report , Quarterly-15 days before
(	1032		,	2	, 375,	56	, NOW(),	'admin',	1, UUID()),  --  Property Report , Quarterly-15 days after
(	1033		,	2	, 375,	65	, NOW(),	'admin',	1, UUID()),  --  Property Report , Quarterly-30 days before
(	1034		,	2	, 375,	66	, NOW(),	'admin',	1, UUID()),  --  Property Report , Quarterly-30 days after
(	1035		,	2	, 375,	6	, NOW(),	'admin',	1, UUID()),  --  Property Report , Semi-annual
(	1036		,	2	, 375,	67	, NOW(),	'admin',	1, UUID()),  --  Property Report , Semi-annual-30 days before
(	1037		,	2	, 375,	68	, NOW(),	'admin',	1, UUID()),  --  Property Report , Semi-annual-30 days after
(	1038		,	2	, 375,	7	, NOW(),	'admin',	1, UUID()),  --  Property Report , Annual
(	1039		,	2	, 375,	69	, NOW(),	'admin',	1, UUID()),  --  Property Report , Annual-30 days before
(	1040		,	2	, 375,	32	, NOW(),	'admin',	1, UUID()),  --  Property Report , Annual-30 days after
(	1041		,	2	, 375,	70	, NOW(),	'admin',	1, UUID()),  --  Property Report , Annual-45 days before
(	1042		,	2	, 375,	71	, NOW(),	'admin',	1, UUID()),  --  Property Report , Annual-45 days after
(	1043		,	2	, 375,	72	, NOW(),	'admin',	1, UUID()),  --  Property Report , Annual-60 days before
(	1044		,	2	, 375,	31	, NOW(),	'admin',	1, UUID()),  --  Property Report , Annual-60 days after
(	1045		,	2	, 375,	55	, NOW(),	'admin',	1, UUID()),  --  Property Report , Annual-90 days before
(	1046		,	2	, 375,	75	, NOW(),	'admin',	1, UUID()),  --  Property Report , Annual-90 days after
(	1047		,	2	, 375,	73	, NOW(),	'admin',	1, UUID()),  --  Property Report , Annual-120 days before
(	1048		,	2	, 375,	74	, NOW(),	'admin',	1, UUID()),  --  Property Report , Annual-120 days after
(	1049		,	2	, 380,	14	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final , As required
(	1050		,	2	, 380,	61	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final , 15 days before
(	1051		,	2	, 380,	58	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final , 15 days after
(	1052		,	2	, 380,	15	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final , 30 days before
(	1053		,	2	, 380,	38	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final , 30 days after
(	1054		,	2	, 380,	36	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final , 45 days before
(	1055		,	2	, 380,	33	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final , 45 days after
(	1056		,	2	, 380,	59	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final , 60 days before
(	1057		,	2	, 380,	45	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final , 60 days after
(	1058		,	2	, 380,	17	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final , 90 days before
(	1059		,	2	, 380,	44	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final , 90 days after
(	1060		,	2	, 380,	35	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final , 120 days before
(	1061		,	2	, 380,	62	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final , 120 days after
(	1062		,	2	, 380,	42	, NOW(),	'admin',	1, UUID()),  --  Property Report-Final , 1 year after
(	1063		,	2	, 385,	14	, NOW(),	'admin',	1, UUID()),  -- Tangible Personal Property Report-DOE (SF 428-B), As required
(	1064		,	2	, 385,	61	, NOW(),	'admin',	1, UUID()),  -- Tangible Personal Property Report-DOE (SF 428-B) , 15 days before
(	1065		,	2	, 385,	58	, NOW(),	'admin',	1, UUID()),  --  Tangible Personal Property Report-DOE (SF 428-B), 15 days after
(	1066		,	2	, 385,	15	, NOW(),	'admin',	1, UUID()),  --  Tangible Personal Property Report-DOE (SF 428-B) , 30 days before
(	1067		,	2	, 385,	38	, NOW(),	'admin',	1, UUID()),  --  Tangible Personal Property Report-DOE (SF 428-B), 30 days after
(	1068		,	2	, 385,	36	, NOW(),	'admin',	1, UUID()),  --  Tangible Personal Property Report-DOE (SF 428-B) , 45 days before
(	1069		,	2	, 385,	33	, NOW(),	'admin',	1, UUID()),  --  Tangible Personal Property Report-DOE (SF 428-B) , 45 days after
(	1070		,	2	, 385,	59	, NOW(),	'admin',	1, UUID()),  --  Tangible Personal Property Report-DOE (SF 428-B) , 60 days before
(	1071		,	2	, 385,	45	, NOW(),	'admin',	1, UUID()),  --  Tangible Personal Property Report-DOE (SF 428-B) , 60 days after
(	1072		,	2	, 385,	17	, NOW(),	'admin',	1, UUID()),  --  Tangible Personal Property Report-DOE (SF 428-B) , 90 days before
(	1073		,	2	, 385,	44	, NOW(),	'admin',	1, UUID()),  --  Tangible Personal Property Report-DOE (SF 428-B) , 90 days after
(	1074		,	2	, 385,	35	, NOW(),	'admin',	1, UUID()),  --  Tangible Personal Property Report-DOE (SF 428-B) , 120 days before
(	1075		,	2	, 385,	62	, NOW(),	'admin',	1, UUID()),  --  Tangible Personal Property Report-DOE (SF 428-B) , 120 days after
(	1076		,	2	, 385,	42	, NOW(),	'admin',	1, UUID()),  --  Tangible Personal Property Report-DOE (SF 428-B) , 1 year after
(	1077		,	4	, 390,	63	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, As Required
(	1078		,	4	, 390,	2	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, Monthly
(	1079		,	4	, 390,	9	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, Bi-monthly
(	1080		,	4	, 390,	3	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, Quarterly
(	1081		,	4	, 390,	64	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, Quarterly-15 days before
(	1082		,	4	, 390,	56	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, Quarterly-15 days after
(	1083		,	4	, 390,	65	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, Quarterly-30 days before
(	1084		,	4	, 390,	66	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, Quarterly-30 days after
(	1085		,	4	, 390,	6	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, Semi-annual
(	1086		,	4	, 390,	67	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, Semi-annual-30 days before
(	1087		,	4	, 390,	68	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, Semi-annual-30 days after
(	1088		,	4	, 390,	7	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, Annual
(	1089		,	4	, 390,	69	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, Annual-30 days before
(	1090		,	4	, 390,	32	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, Annual-30 days after
(	1091		,	4	, 390,	70	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, Annual-45 days before
(	1092		,	4	, 390,	71	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, Annual-45 days after
(	1093		,	4	, 390,	72	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, Annual-60 days before
(	1094		,	4	, 390,	31	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, Annual-60 days after
(	1095		,	4	, 390,	55	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, Annual-90 days before
(	1096		,	4	, 390,	75	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, Annual-90 days after
(	1097		,	4	, 390,	73	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, Annual-120 days before
(	1098		,	4	, 390,	74	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report, Annual-120 days after
(	1099		,	4	, 395,	14	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, As required
(	1100		,	4	, 395,	61	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, 15 days before
(	1101		,	4	, 395,	58	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, 15 days after
(	1102		,	4	, 395,	15	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, 30 days before
(	1103		,	4	, 395,	38	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, 30 days after
(	1104		,	4	, 395,	36	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, 45 days before
(	1105		,	4	, 395,	33	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, 45 days after
(	1106		,	4	, 395,	59	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, 60 days before
(	1107		,	4	, 395,	45	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, 60 days after
(	1108		,	4	, 395,	17	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, 90 days before
(	1109		,	4	, 395,	44	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, 90 days after
(	1110		,	4	, 395,	35	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, 120 days before
(	1111		,	4	, 395,	62	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, 120 days after
(	1112		,	4	, 395,	42	, NOW(),	'admin',	1, UUID()),  --  Administrative Financial Report - Final, 1 year after
(	1113		,	4	, 400,	63	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, As Required
(	1114		,	4	, 400,	2	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, Monthly
(	1115		,	4	, 400,	9	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, Bi-monthly
(	1116		,	4	, 400,	3	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, Quarterly
(	1117		,	4	, 400,	64	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, Quarterly-15 days before
(	1118		,	4	, 400,	56	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, Quarterly-15 days after
(	1119		,	4	, 400,	65	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, Quarterly-30 days before
(	1120		,	4	, 400,	66	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, Quarterly-30 days after
(	1121		,	4	, 400,	6	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, Semi-annual
(	1122		,	4	, 400,	67	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, Semi-annual-30 days before
(	1123		,	4	, 400,	68	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, Semi-annual-30 days after
(	1124		,	4	, 400,	7	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, Annual
(	1125		,	4	, 400,	69	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, Annual-30 days before
(	1126		,	4	, 400,	32	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, Annual-30 days after
(	1127		,	4	, 400,	70	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, Annual-45 days before
(	1128		,	4	, 400,	71	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, Annual-45 days after
(	1129		,	4	, 400,	72	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, Annual-60 days before
(	1130		,	4	, 400,	31	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, Annual-60 days after
(	1131		,	4	, 400,	55	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, Annual-90 days before
(	1132		,	4	, 400,	75	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, Annual-90 days after
(	1133		,	4	, 400,	73	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, Annual-120 days before
(	1134		,	4	, 400,	74	, NOW(),	'admin',	1, UUID()),  --  Administrative Report, Annual-120 days after
(	1135		,	4	, 405,	14	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, As required
(	1136		,	4	, 405,	61	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, 15 days before
(	1137		,	4	, 405,	58	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, 15 days after
(	1138		,	4	, 405,	15	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, 30 days before
(	1139		,	4	, 405,	38	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, 30 days after
(	1140		,	4	, 405,	36	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, 45 days before
(	1141		,	4	, 405,	33	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, 45 days after
(	1142		,	4	, 405,	59	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, 60 days before
(	1143		,	4	, 405,	45	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, 60 days after
(	1144		,	4	, 405,	17	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, 90 days before
(	1145		,	4	, 405,	44	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, 90 days after
(	1146		,	4	, 405,	35	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, 120 days before
(	1147		,	4	, 405,	62	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, 120 days after
(	1148		,	4	, 405,	42	, NOW(),	'admin',	1, UUID()),  --  Administrative Report - Final, 1 year after
(	1149		,	4	,410,	63	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, As Required
(	1150		,	4	,410,	2	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, Monthly
(	1151		,	4	,410,	9	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, Bi-monthly
(	1152		,	4	,410,	3	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, Quarterly
(	1153		,	4	,410,	64	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, Quarterly-15 days before
(	1154		,	4	,410,	56	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, Quarterly-15 days after
(	1155		,	4	,410,	65	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, Quarterly-30 days before
(	1156		,	4	,410,	66	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, Quarterly-30 days after
(	1157		,	4	,410,	6	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, Semi-annual
(	1158		,	4	,410,	67	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, Semi-annual-30 days before
(	1159		,	4	,410,	68	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, Semi-annual-30 days after
(	1160		,	4	,410,	7	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, Annual
(	1161		,	4	,410,	69	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, Annual-30 days before
(	1162		,	4	,410,	32	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, Annual-30 days after
(	1163		,	4	,410,	70	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, Annual-45 days before
(	1164		,	4	,410,	71	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, Annual-45 days after
(	1165		,	4	,410,	72	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, Annual-60 days before
(	1166		,	4	,410,	31	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, Annual-60 days after
(	1167		,	4	,410,	55	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, Annual-90 days before
(	1168		,	4	,410,	75	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, Annual-90 days after
(	1169		,	4	,410,	73	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, Annual-120 days before
(	1170		,	4	,410,	74	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan, Annual-120 days after
(	1171		,	4	, 415,	14	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan - Final, As required
(	1172		,	4	, 415,	61	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan - Final, 15 days before
(	1173		,	4	, 415,	58	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan - Final, 15 days after
(	1174		,	4	, 415,	15	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan - Final, 30 days before
(	1175		,	4	, 415,	38	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan - Final, 30 days after
(	1176		,	4	, 415,	36	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan - Final, 45 days before
(	1177		,	4	, 415,	33	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan - Final, 45 days after
(	1178		,	4	, 415,	59	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan - Final, 60 days before
(	1179		,	4	, 415,	45	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan - Final, 60 days after
(	1180		,	4	, 415,	17	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan - Final, 90 days before
(	1181		,	4	, 415,	44	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan - Final, 90 days after
(	1182		,	4	, 415,	35	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan - Final, 120 days before
(	1183		,	4	, 415,	62	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan - Final, 120 days after
(	1184		,	4	, 415,	42	, NOW(),	'admin',	1, UUID()),  --  Data Management Plan - Final, 1 year after
(	1185		,	4	,420,	63	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, As Required
(	1186		,	4	,420,	2	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, Monthly
(	1187		,	4	,420,	9	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, Bi-monthly
(	1188		,	4	,420,	3	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, Quarterly
(	1189		,	4	,420,	64	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, Quarterly-15 days before
(	1190		,	4	,420,	56	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, Quarterly-15 days after
(	1191		,	4	,420,	65	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, Quarterly-30 days before
(	1192		,	4	,420,	66	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, Quarterly-30 days after
(	1193		,	4	,420,	6	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, Semi-annual
(	1194		,	4	,420,	67	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, Semi-annual-30 days before
(	1195		,	4	,420,	68	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, Semi-annual-30 days after
(	1196		,	4	,420,	7	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, Annual
(	1197		,	4	,420,	69	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, Annual-30 days before
(	1198		,	4	,420,	32	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, Annual-30 days after
(	1199		,	4	,420,	70	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, Annual-45 days before
(	1200		,	4	,420,	71	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, Annual-45 days after
(	1201		,	4	,420,	72	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, Annual-60 days before
(	1202		,	4	,420,	31	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, Annual-60 days after
(	1203		,	4	,420,	55	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, Annual-90 days before
(	1204		,	4	,420,	75	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, Annual-90 days after
(	1205		,	4	,420,	73	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, Annual-120 days before
(	1206		,	4	,420,	74	, NOW(),	'admin',	1, UUID()),  --  Deliverable Documentation, Annual-120 days after
(	1207		,	4	,425,	63	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , As Required
(	1208		,	4	,425,	2	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Monthly
(	1209		,	4	,425,	9	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Bi-monthly
(	1210		,	4	,425,	3	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Quarterly
(	1211		,	4	,425,	64	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Quarterly-15 days before
(	1212		,	4	,425,	56	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Quarterly-15 days after
(	1213		,	4	,425,	65	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Quarterly-30 days before
(	1214		,	4	,425,	66	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Quarterly-30 days after
(	1215		,	4	,425,	6	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Semi-annual
(	1216		,	4	,425,	67	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Semi-annual-30 days before
(	1217		,	4	,425,	68	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Semi-annual-30 days after
(	1218		,	4	,425,	7	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Annual
(	1219		,	4	,425,	69	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Annual-30 days before
(	1220		,	4	,425,	32	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Annual-30 days after
(	1221		,	4	,425,	70	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Annual-45 days before
(	1222		,	4	,425,	71	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Annual-45 days after
(	1223		,	4	,425,	72	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Annual-60 days before
(	1224		,	4	,425,	31	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Annual-60 days after
(	1225		,	4	,425,	55	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Annual-90 days before
(	1226		,	4	,425,	75	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Annual-90 days after
(	1227		,	4	,425,	73	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Annual-120 days before
(	1228		,	4	,425,	74	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property -Sponsor Form , Annual-120 days after
(	1229		,	4	, 430,	63	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, As Required
(	1230		,	4	, 430,	2	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Monthly
(	1231		,	4	, 430,	9	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Bi-monthly
(	1232		,	4	, 430,	3	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Quarterly
(	1233		,	4	, 430,	64	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Quarterly-15 days before
(	1234		,	4	, 430,	56	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Quarterly-15 days after
(	1235		,	4	, 430,	65	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Quarterly-30 days before
(	1236		,	4	, 430,	66	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Quarterly-30 days after
(	1237		,	4	, 430,	6	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Semi-annual
(	1238		,	4	, 430,	67	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Semi-annual-30 days before
(	1239		,	4	, 430,	68	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Semi-annual-30 days after
(	1240		,	4	, 430,	7	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Annual
(	1241		,	4	, 430,	69	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Annual-30 days before
(	1242		,	4	, 430,	32	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Annual-30 days after
(	1243		,	4	, 430,	70	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Annual-45 days before
(	1244		,	4	, 430,	71	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Annual-45 days after
(	1245		,	4	, 430,	72	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Annual-60 days before
(	1246		,	4	, 430,	31	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Annual-60 days after
(	1247		,	4	, 430,	55	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Annual-90 days before
(	1248		,	4	, 430,	75	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Annual-90 days after
(	1249		,	4	, 430,	73	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Annual-120 days before
(	1250		,	4	, 430,	74	, NOW(),	'admin',	1, UUID()),  --  Intellectual Property Report, Annual-120 days after
(	1251		,	4	, 435,	63	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (Human Subjects) Approval, As Required
(	1252		,	4	, 435,	2	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (Human Subjects) Approval, Monthly
(	1253		,	4	, 435,	9	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (Human Subjects) Approval, Bi-monthly
(	1254		,	4	, 435,	3	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (Human Subjects) Approval, Quarterly
(	1255		,	4	, 435,	64	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (Human Subjects) Approval, Quarterly-15 days before
(	1256		,	4	, 435,	56	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (Human Subjects) Approval, Quarterly-15 days after
(	1257		,	4	, 435,	65	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (Human Subjects) Approval, Quarterly-30 days before
(	1258		,	4	, 435,	66	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (Human Subjects) Approval, Quarterly-30 days after
(	1259		,	4	, 435,	6	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (Human Subjects) Approval, Semi-annual
(	1260		,	4	, 435,	67	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (Human Subjects) Approval, Semi-annual-30 days before
(	1261		,	4	, 435,	68	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (Human Subjects) Approval, Semi-annual-30 days after
(	1262		,	4	, 435,	7	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (Human Subjects) Approval, Annual
(	1263		,	4	, 435,	69	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (Human Subjects) Approval, Annual-30 days before
(	1264		,	4	, 435,	32	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (Human Subjects) Approval, Annual-30 days after
(	1265		,	4	, 435,	70	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (Human Subjects) Approval, Annual-45 days before
(	1266		,	4	, 435,	71	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (Human Subjects) Approval, Annual-45 days after
(	1267		,	4	, 435,	72	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (Human Subjects) Approval, Annual-60 days before
(	1268		,	4	, 435,	31	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (Human Subjects) Approval, Annual-60 days after
(	1269		,	4	, 435,	55	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (Human Subjects) Approval, Annual-90 days before
(	1270		,	4	, 435,	75	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (Human Subjects) Approval, Annual-90 days after
(	1271		,	4	, 435,	73	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (Human Subjects) Approval, Annual-120 days before
(	1272		,	4	, 435,	74	, NOW(),	'admin',	1, UUID()),  --  Internal Review Board (Human Subjects) Approval, Annual-120 days after
(	1273		,	4	, 440,	63	, NOW(),	'admin',	1, UUID()),  --  Management Plan / Report, As Required
(	1274		,	4	, 440,	2	, NOW(),	'admin',	1, UUID()),  --  Management Plan / Report, Monthly
(	1275		,	4	, 440,	9	, NOW(),	'admin',	1, UUID()),  --  Management Plan / Report, Bi-monthly
(	1276		,	4	, 440,	3	, NOW(),	'admin',	1, UUID()),  --  Management Plan / Report, Quarterly
(	1277		,	4	, 440,	64	, NOW(),	'admin',	1, UUID()),  --  Management Plan / Report, Quarterly-15 days before
(	1278		,	4	, 440,	56	, NOW(),	'admin',	1, UUID()),  --  Management Plan / Report, Quarterly-15 days after
(	1279		,	4	, 440,	65	, NOW(),	'admin',	1, UUID()),  --  Management Plan / Report, Quarterly-30 days before
(	1280		,	4	, 440,	66	, NOW(),	'admin',	1, UUID()),  --  Management Plan / Report, Quarterly-30 days after
(	1281		,	4	, 440,	6	, NOW(),	'admin',	1, UUID()),  --  Management Plan / Report, Semi-annual
(	1282		,	4	, 440,	67	, NOW(),	'admin',	1, UUID()),  --  Management Plan / Report, Semi-annual-30 days before
(	1283		,	4	, 440,	68	, NOW(),	'admin',	1, UUID()),  --  Management Plan / Report, Semi-annual-30 days after
(	1284		,	4	, 440,	7	, NOW(),	'admin',	1, UUID()),  --  Management Plan / Report, Annual
(	1285		,	4	, 440,	69	, NOW(),	'admin',	1, UUID()),  --  Management Plan / Report, Annual-30 days before
(	1286		,	4	, 440,	32	, NOW(),	'admin',	1, UUID()),  --  Management Plan / Report, Annual-30 days after
(	1287		,	4	, 440,	70	, NOW(),	'admin',	1, UUID()),  --  Management Plan / Report, Annual-45 days before
(	1288		,	4	, 440,	71	, NOW(),	'admin',	1, UUID()),  --  Management Plan / Report, Annual-45 days after
(	1289		,	4	, 440,	72	, NOW(),	'admin',	1, UUID()),  --  Management Plan / Report, Annual-60 days before
(	1290		,	4	, 440,	31	, NOW(),	'admin',	1, UUID()),  --  Management Plan / Report, Annual-60 days after
(	1291		,	4	, 440,	55	, NOW(),	'admin',	1, UUID()),  --  Management Plan / Report, Annual-90 days before
(	1292		,	4	, 440,	75	, NOW(),	'admin',	1, UUID()),  --  Management Plan / Report, Annual-90 days after
(	1293		,	4	, 440,	73	, NOW(),	'admin',	1, UUID()),  --  Management Plan / Report, Annual-120 days before
(	1294		,	4	, 440,	74	, NOW(),	'admin',	1, UUID()),  --  Management Plan / Report, Annual-120 days after
(	1295		,	4	, 445,	63	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, As Required
(	1296		,	4	, 445,	2	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, Monthly
(	1297		,	4	, 445,	9	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, Bi-monthly
(	1298		,	4	, 445,	3	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, Quarterly
(	1299		,	4	, 445,	64	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, Quarterly-15 days before
(	1300		,	4	, 445,	56	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, Quarterly-15 days after
(	1301		,	4	, 445,	65	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, Quarterly-30 days before
(	1302		,	4	, 445,	66	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, Quarterly-30 days after
(	1303		,	4	, 445,	6	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, Semi-annual
(	1304		,	4	, 445,	67	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, Semi-annual-30 days before
(	1305		,	4	, 445,	68	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, Semi-annual-30 days after
(	1306		,	4	, 445,	7	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, Annual
(	1307		,	4	, 445,	69	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, Annual-30 days before
(	1308		,	4	, 445,	32	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, Annual-30 days after
(	1309		,	4	, 445,	70	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, Annual-45 days before
(	1310		,	4	, 445,	71	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, Annual-45 days after
(	1311		,	4	, 445,	72	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, Annual-60 days before
(	1312		,	4	, 445,	31	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, Annual-60 days after
(	1313		,	4	, 445,	55	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, Annual-90 days before
(	1314		,	4	, 445,	75	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, Annual-90 days after
(	1315		,	4	, 445,	73	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, Annual-120 days before
(	1316		,	4	, 445,	74	, NOW(),	'admin',	1, UUID()),  --  Milestone Deliverable Documentation, Annual-120 days after
(	1317		,	4	, 450,	63	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, As Required
(	1318		,	4	, 450,	2	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, Monthly
(	1319		,	4	, 450,	9	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, Bi-monthly
(	1320		,	4	, 450,	3	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, Quarterly
(	1321		,	4	, 450,	64	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, Quarterly-15 days before
(	1322		,	4	, 450,	56	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, Quarterly-15 days after
(	1323		,	4	, 450,	65	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, Quarterly-30 days before
(	1324		,	4	, 450,	66	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, Quarterly-30 days after
(	1325		,	4	, 450,	6	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, Semi-annual
(	1326		,	4	, 450,	67	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, Semi-annual-30 days before
(	1327		,	4	, 450,	68	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, Semi-annual-30 days after
(	1328		,	4	, 450,	7	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, Annual
(	1329		,	4	, 450,	69	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, Annual-30 days before
(	1330		,	4	, 450,	32	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, Annual-30 days after
(	1331		,	4	, 450,	70	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, Annual-45 days before
(	1332		,	4	, 450,	71	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, Annual-45 days after
(	1333		,	4	, 450,	72	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, Annual-60 days before
(	1334		,	4	, 450,	31	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, Annual-60 days after
(	1335		,	4	, 450,	55	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, Annual-90 days before
(	1336		,	4	, 450,	75	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, Annual-90 days after
(	1337		,	4	, 450,	73	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, Annual-120 days before
(	1338		,	4	, 450,	74	, NOW(),	'admin',	1, UUID()),  --  Milestone Report, Annual-120 days after
(	1339		,	4	,455,	63	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), As Required
(	1340		,	4	,455,	2	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), Monthly
(	1341		,	4	,455,	9	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), Bi-monthly
(	1342		,	4	,455,	3	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), Quarterly
(	1343		,	4	,455,	64	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), Quarterly-15 days before
(	1344		,	4	,455,	56	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), Quarterly-15 days after
(	1345		,	4	,455,	65	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), Quarterly-30 days before
(	1346		,	4	,455,	66	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), Quarterly-30 days after
(	1347		,	4	,455,	6	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), Semi-annual
(	1348		,	4	,455,	67	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), Semi-annual-30 days before
(	1349		,	4	,455,	68	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), Semi-annual-30 days after
(	1350		,	4	,455,	7	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), Annual
(	1351		,	4	,455,	69	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), Annual-30 days before
(	1352		,	4	,455,	32	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), Annual-30 days after
(	1353		,	4	,455,	70	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), Annual-45 days before
(	1354		,	4	,455,	71	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), Annual-45 days after
(	1355		,	4	,455,	72	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), Annual-60 days before
(	1356		,	4	,455,	31	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), Annual-60 days after
(	1357		,	4	,455,	55	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), Annual-90 days before
(	1358		,	4	,455,	75	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), Annual-90 days after
(	1359		,	4	,455,	73	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), Annual-120 days before
(	1360		,	4	,455,	74	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan (POP), Annual-120 days after
(	1361		,	4	,460,	63	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), As Required
(	1362		,	4	,460,	2	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), Monthly
(	1363		,	4	,460,	9	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), Bi-monthly
(	1364		,	4	,460,	3	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), Quarterly
(	1365		,	4	,460,	64	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), Quarterly-15 days before
(	1366		,	4	,460,	56	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), Quarterly-15 days after
(	1367		,	4	,460,	65	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), Quarterly-30 days before
(	1368		,	4	,460,	66	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), Quarterly-30 days after
(	1369		,	4	,460,	6	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), Semi-annual
(	1370		,	4	,460,	67	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), Semi-annual-30 days before
(	1371		,	4	,460,	68	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), Semi-annual-30 days after
(	1372		,	4	,460,	7	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), Annual
(	1373		,	4	,460,	69	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), Annual-30 days before
(	1374		,	4	,460,	32	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), Annual-30 days after
(	1375		,	4	,460,	70	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), Annual-45 days before
(	1376		,	4	,460,	71	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), Annual-45 days after
(	1377		,	4	,460,	72	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), Annual-60 days before
(	1378		,	4	,460,	31	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), Annual-60 days after
(	1379		,	4	,460,	55	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), Annual-90 days before
(	1380		,	4	,460,	75	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), Annual-90 days after
(	1381		,	4	,460,	73	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), Annual-120 days before
(	1382		,	4	,460,	74	, NOW(),	'admin',	1, UUID()),  --  NCAR Program Operating Plan Progress Report (POPPR), Annual-120 days after
(	1383		,	4	, 465,	63	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, As Required
(	1384		,	4	, 465,	2	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, Monthly
(	1385		,	4	, 465,	9	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, Bi-monthly
(	1386		,	4	, 465,	3	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, Quarterly
(	1387		,	4	, 465,	64	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, Quarterly-15 days before
(	1388		,	4	, 465,	56	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, Quarterly-15 days after
(	1389		,	4	, 465,	65	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, Quarterly-30 days before
(	1390		,	4	, 465,	66	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, Quarterly-30 days after
(	1391		,	4	, 465,	6	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, Semi-annual
(	1392		,	4	, 465,	67	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, Semi-annual-30 days before
(	1393		,	4	, 465,	68	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, Semi-annual-30 days after
(	1394		,	4	, 465,	7	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, Annual
(	1395		,	4	, 465,	69	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, Annual-30 days before
(	1396		,	4	, 465,	32	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, Annual-30 days after
(	1397		,	4	, 465,	70	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, Annual-45 days before
(	1398		,	4	, 465,	71	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, Annual-45 days after
(	1399		,	4	, 465,	72	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, Annual-60 days before
(	1400		,	4	, 465,	31	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, Annual-60 days after
(	1401		,	4	, 465,	55	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, Annual-90 days before
(	1402		,	4	, 465,	75	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, Annual-90 days after
(	1403		,	4	, 465,	73	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, Annual-120 days before
(	1404		,	4	, 465,	74	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report, Annual-120 days after
(	1405		,	4	, 470,	14	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report - Final, As required
(	1406		,	4	, 470,	61	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report - Final, 15 days before
(	1407		,	4	, 470,	58	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report - Final, 15 days after
(	1408		,	4	, 470,	15	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report - Final, 30 days before
(	1409		,	4	, 470,	38	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report - Final, 30 days after
(	1410		,	4	, 470,	36	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report - Final, 45 days before
(	1411		,	4	, 470,	33	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report - Final, 45 days after
(	1412		,	4	, 470,	59	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report - Final, 60 days before
(	1413		,	4	, 470,	45	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report - Final, 60 days after
(	1414		,	4	, 470,	17	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report - Final, 90 days before
(	1415		,	4	, 470,	44	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report - Final, 90 days after
(	1416		,	4	, 470,	35	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report - Final, 120 days before
(	1417		,	4	, 470,	62	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report - Final, 120 days after
(	1418		,	4	, 470,	42	, NOW(),	'admin',	1, UUID()),  --  Online Technical Report - Final, 1 year after
(	1419		,	4	, 475,	63	, NOW(),	'admin',	1, UUID()),  --  Presentation, As Required
(	1420		,	4	, 475,	2	, NOW(),	'admin',	1, UUID()),  --  Presentation, Monthly
(	1421		,	4	, 475,	9	, NOW(),	'admin',	1, UUID()),  --  Presentation, Bi-monthly
(	1422		,	4	, 475,	3	, NOW(),	'admin',	1, UUID()),  --  Presentation, Quarterly
(	1423		,	4	, 475,	64	, NOW(),	'admin',	1, UUID()),  --  Presentation, Quarterly-15 days before
(	1424		,	4	, 475,	56	, NOW(),	'admin',	1, UUID()),  --  Presentation, Quarterly-15 days after
(	1425		,	4	, 475,	65	, NOW(),	'admin',	1, UUID()),  --  Presentation, Quarterly-30 days before
(	1426		,	4	, 475,	66	, NOW(),	'admin',	1, UUID()),  --  Presentation, Quarterly-30 days after
(	1427		,	4	, 475,	6	, NOW(),	'admin',	1, UUID()),  --  Presentation, Semi-annual
(	1428		,	4	, 475,	67	, NOW(),	'admin',	1, UUID()),  --  Presentation, Semi-annual-30 days before
(	1429		,	4	, 475,	68	, NOW(),	'admin',	1, UUID()),  --  Presentation, Semi-annual-30 days after
(	1430		,	4	, 475,	7	, NOW(),	'admin',	1, UUID()),  --  Presentation, Annual
(	1431		,	4	, 475,	69	, NOW(),	'admin',	1, UUID()),  --  Presentation, Annual-30 days before
(	1432		,	4	, 475,	32	, NOW(),	'admin',	1, UUID()),  --  Presentation, Annual-30 days after
(	1433		,	4	, 475,	70	, NOW(),	'admin',	1, UUID()),  --  Presentation, Annual-45 days before
(	1434		,	4	, 475,	71	, NOW(),	'admin',	1, UUID()),  --  Presentation, Annual-45 days after
(	1435		,	4	, 475,	72	, NOW(),	'admin',	1, UUID()),  --  Presentation, Annual-60 days before
(	1436		,	4	, 475,	31	, NOW(),	'admin',	1, UUID()),  --  Presentation, Annual-60 days after
(	1437		,	4	, 475,	55	, NOW(),	'admin',	1, UUID()),  --  Presentation, Annual-90 days before
(	1438		,	4	, 475,	75	, NOW(),	'admin',	1, UUID()),  --  Presentation, Annual-90 days after
(	1439		,	4	, 475,	73	, NOW(),	'admin',	1, UUID()),  --  Presentation, Annual-120 days before
(	1440		,	4	, 475,	74	, NOW(),	'admin',	1, UUID()),  --  Presentation, Annual-120 days after
(	1441		,	4	,480,	63	, NOW(),	'admin',	1, UUID()),  --  Proceedings, As Required
(	1442		,	4	,480,	2	, NOW(),	'admin',	1, UUID()),  --  Proceedings, Monthly
(	1443		,	4	,480,	9	, NOW(),	'admin',	1, UUID()),  --  Proceedings, Bi-monthly
(	1444		,	4	,480,	3	, NOW(),	'admin',	1, UUID()),  --  Proceedings, Quarterly
(	1445		,	4	,480,	64	, NOW(),	'admin',	1, UUID()),  --  Proceedings, Quarterly-15 days before
(	1446		,	4	,480,	56	, NOW(),	'admin',	1, UUID()),  --  Proceedings, Quarterly-15 days after
(	1447		,	4	,480,	65	, NOW(),	'admin',	1, UUID()),  --  Proceedings, Quarterly-30 days before
(	1448		,	4	,480,	66	, NOW(),	'admin',	1, UUID()),  --  Proceedings, Quarterly-30 days after
(	1449		,	4	,480,	6	, NOW(),	'admin',	1, UUID()),  --  Proceedings, Semi-annual
(	1450		,	4	,480,	67	, NOW(),	'admin',	1, UUID()),  --  Proceedings, Semi-annual-30 days before
(	1451		,	4	,480,	68	, NOW(),	'admin',	1, UUID()),  --  Proceedings, Semi-annual-30 days after
(	1452		,	4	,480,	7	, NOW(),	'admin',	1, UUID()),  --  Proceedings, Annual
(	1453		,	4	,480,	69	, NOW(),	'admin',	1, UUID()),  --  Proceedings, Annual-30 days before
(	1454		,	4	,480,	32	, NOW(),	'admin',	1, UUID()),  --  Proceedings, Annual-30 days after
(	1455		,	4	,480,	70	, NOW(),	'admin',	1, UUID()),  --  Proceedings, Annual-45 days before
(	1456		,	4	,480,	71	, NOW(),	'admin',	1, UUID()),  --  Proceedings, Annual-45 days after
(	1457		,	4	,480,	72	, NOW(),	'admin',	1, UUID()),  --  Proceedings, Annual-60 days before
(	1458		,	4	,480,	31	, NOW(),	'admin',	1, UUID()),  --  Proceedings, Annual-60 days after
(	1459		,	4	,480,	55	, NOW(),	'admin',	1, UUID()),  --  Proceedings, Annual-90 days before
(	1460		,	4	,480,	75	, NOW(),	'admin',	1, UUID()),  --  Proceedings, Annual-90 days after
(	1461		,	4	,480,	73	, NOW(),	'admin',	1, UUID()),  --  Proceedings, Annual-120 days before
(	1462		,	4	,480,	74	, NOW(),	'admin',	1, UUID()),  --  Proceedings, Annual-120 days after
(	1463		,	4	, 485,	63	, NOW(),	'admin',	1, UUID()),  --  Publication, As Required
(	1464		,	4	, 485,	2	, NOW(),	'admin',	1, UUID()),  --  Publication, Monthly
(	1465		,	4	, 485,	9	, NOW(),	'admin',	1, UUID()),  --  Publication, Bi-monthly
(	1466		,	4	, 485,	3	, NOW(),	'admin',	1, UUID()),  --  Publication, Quarterly
(	1467		,	4	, 485,	64	, NOW(),	'admin',	1, UUID()),  --  Publication, Quarterly-15 days before
(	1468		,	4	, 485,	56	, NOW(),	'admin',	1, UUID()),  --  Publication, Quarterly-15 days after
(	1469		,	4	, 485,	65	, NOW(),	'admin',	1, UUID()),  --  Publication, Quarterly-30 days before
(	1470		,	4	, 485,	66	, NOW(),	'admin',	1, UUID()),  --  Publication, Quarterly-30 days after
(	1471		,	4	, 485,	6	, NOW(),	'admin',	1, UUID()),  --  Publication, Semi-annual
(	1472		,	4	, 485,	67	, NOW(),	'admin',	1, UUID()),  --  Publication, Semi-annual-30 days before
(	1473		,	4	, 485,	68	, NOW(),	'admin',	1, UUID()),  --  Publication, Semi-annual-30 days after
(	1474		,	4	, 485,	7	, NOW(),	'admin',	1, UUID()),  --  Publication, Annual
(	1475		,	4	, 485,	69	, NOW(),	'admin',	1, UUID()),  --  Publication, Annual-30 days before
(	1476		,	4	, 485,	32	, NOW(),	'admin',	1, UUID()),  --  Publication, Annual-30 days after
(	1477		,	4	, 485,	70	, NOW(),	'admin',	1, UUID()),  --  Publication, Annual-45 days before
(	1478		,	4	, 485,	71	, NOW(),	'admin',	1, UUID()),  --  Publication, Annual-45 days after
(	1479		,	4	, 485,	72	, NOW(),	'admin',	1, UUID()),  --  Publication, Annual-60 days before
(	1480		,	4	, 485,	31	, NOW(),	'admin',	1, UUID()),  --  Publication, Annual-60 days after
(	1481		,	4	, 485,	55	, NOW(),	'admin',	1, UUID()),  --  Publication, Annual-90 days before
(	1482		,	4	, 485,	75	, NOW(),	'admin',	1, UUID()),  --  Publication, Annual-90 days after
(	1483		,	4	, 485,	73	, NOW(),	'admin',	1, UUID()),  --  Publication, Annual-120 days before
(	1484		,	4	, 485,	74	, NOW(),	'admin',	1, UUID()),  --  Publication, Annual-120 days after
(	1485		,	4	, 490,	63	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), As Required
(	1486		,	4	, 490,	2	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), Monthly
(	1487		,	4	, 490,	9	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), Bi-monthly
(	1488		,	4	, 490,	3	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), Quarterly
(	1489		,	4	, 490,	64	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), Quarterly-15 days before
(	1490		,	4	, 490,	56	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), Quarterly-15 days after
(	1491		,	4	, 490,	65	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), Quarterly-30 days before
(	1492		,	4	, 490,	66	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), Quarterly-30 days after
(	1493		,	4	, 490,	6	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), Semi-annual
(	1494		,	4	, 490,	67	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), Semi-annual-30 days before
(	1495		,	4	, 490,	68	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), Semi-annual-30 days after
(	1496		,	4	, 490,	7	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), Annual
(	1497		,	4	, 490,	69	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), Annual-30 days before
(	1498		,	4	, 490,	32	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), Annual-30 days after
(	1499		,	4	, 490,	70	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), Annual-45 days before
(	1500		,	4	, 490,	71	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), Annual-45 days after
(	1501		,	4	, 490,	72	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), Annual-60 days before
(	1502		,	4	, 490,	31	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), Annual-60 days after
(	1503		,	4	, 490,	55	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), Annual-90 days before
(	1504		,	4	, 490,	75	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), Annual-90 days after
(	1505		,	4	, 490,	73	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), Annual-120 days before
(	1506		,	4	, 490,	74	, NOW(),	'admin',	1, UUID()),  --  Report Documentation Page (SF 298), Annual-120 days after
(	1507		,	4	, 495,	63	, NOW(),	'admin',	1, UUID()),  --  Technical Report, As Required
(	1508		,	4	, 495,	2	, NOW(),	'admin',	1, UUID()),  --  Technical Report, Monthly
(	1509		,	4	, 495,	9	, NOW(),	'admin',	1, UUID()),  --  Technical Report, Bi-monthly
(	1510		,	4	, 495,	3	, NOW(),	'admin',	1, UUID()),  --  Technical Report, Quarterly
(	1511		,	4	, 495,	64	, NOW(),	'admin',	1, UUID()),  --  Technical Report, Quarterly-15 days before
(	1512		,	4	, 495,	56	, NOW(),	'admin',	1, UUID()),  --  Technical Report, Quarterly-15 days after
(	1513		,	4	, 495,	65	, NOW(),	'admin',	1, UUID()),  --  Technical Report, Quarterly-30 days before
(	1514		,	4	, 495,	66	, NOW(),	'admin',	1, UUID()),  --  Technical Report, Quarterly-30 days after
(	1515		,	4	, 495,	6	, NOW(),	'admin',	1, UUID()),  --  Technical Report, Semi-annual
(	1516		,	4	, 495,	67	, NOW(),	'admin',	1, UUID()),  --  Technical Report, Semi-annual-30 days before
(	1517		,	4	, 495,	68	, NOW(),	'admin',	1, UUID()),  --  Technical Report, Semi-annual-30 days after
(	1518		,	4	, 495,	7	, NOW(),	'admin',	1, UUID()),  --  Technical Report, Annual
(	1519		,	4	, 495,	69	, NOW(),	'admin',	1, UUID()),  --  Technical Report, Annual-30 days before
(	1520		,	4	, 495,	32	, NOW(),	'admin',	1, UUID()),  --  Technical Report, Annual-30 days after
(	1521		,	4	, 495,	70	, NOW(),	'admin',	1, UUID()),  --  Technical Report, Annual-45 days before
(	1522		,	4	, 495,	71	, NOW(),	'admin',	1, UUID()),  --  Technical Report, Annual-45 days after
(	1523		,	4	, 495,	72	, NOW(),	'admin',	1, UUID()),  --  Technical Report, Annual-60 days before
(	1524		,	4	, 495,	31	, NOW(),	'admin',	1, UUID()),  --  Technical Report, Annual-60 days after
(	1525		,	4	, 495,	55	, NOW(),	'admin',	1, UUID()),  --  Technical Report, Annual-90 days before
(	1526		,	4	, 495,	75	, NOW(),	'admin',	1, UUID()),  --  Technical Report, Annual-90 days after
(	1527		,	4	, 495,	73	, NOW(),	'admin',	1, UUID()),  --  Technical Report, Annual-120 days before
(	1528		,	4	, 495,	74	, NOW(),	'admin',	1, UUID()),  --  Technical Report, Annual-120 days after
(	1529		,	4	, 500,	14	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, As required
(	1530		,	4	, 500,	61	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, 15 days before
(	1531		,	4	, 500,	58	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, 15 days after
(	1532		,	4	, 500,	15	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, 30 days before
(	1533		,	4	, 500,	38	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, 30 days after
(	1534		,	4	, 500,	36	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, 45 days before
(	1535		,	4	, 500,	33	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, 45 days after
(	1536		,	4	, 500,	59	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, 60 days before
(	1537		,	4	, 500,	45	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, 60 days after
(	1538		,	4	, 500,	17	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, 90 days before
(	1539		,	4	, 500,	44	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, 90 days after
(	1540		,	4	, 500,	35	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, 120 days before
(	1541		,	4	, 500,	62	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, 120 days after
(	1542		,	4	, 500,	42	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Final, 1 year after
(	1543		,	4	, 505,	63	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, As Required
(	1544		,	4	, 505,	2	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, Monthly
(	1545		,	4	, 505,	9	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, Bi-monthly
(	1546		,	4	, 505,	3	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, Quarterly
(	1547		,	4	, 505,	64	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, Quarterly-15 days before
(	1548		,	4	, 505,	56	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, Quarterly-15 days after
(	1549		,	4	, 505,	65	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, Quarterly-30 days before
(	1550		,	4	, 505,	66	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, Quarterly-30 days after
(	1551		,	4	, 505,	6	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, Semi-annual
(	1552		,	4	, 505,	67	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, Semi-annual-30 days before
(	1553		,	4	, 505,	68	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, Semi-annual-30 days after
(	1554		,	4	, 505,	7	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, Annual
(	1555		,	4	, 505,	69	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, Annual-30 days before
(	1556		,	4	, 505,	32	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, Annual-30 days after
(	1557		,	4	, 505,	70	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, Annual-45 days before
(	1558		,	4	, 505,	71	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, Annual-45 days after
(	1559		,	4	, 505,	72	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, Annual-60 days before
(	1560		,	4	, 505,	31	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, Annual-60 days after
(	1561		,	4	, 505,	55	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, Annual-90 days before
(	1562		,	4	, 505,	75	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, Annual-90 days after
(	1563		,	4	, 505,	73	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, Annual-120 days before
(	1564		,	4	, 505,	74	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form, Annual-120 days after
(	1565		,	4	, 510,	14	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form-Final, As required
(	1566		,	4	, 510,	61	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form-Final, 15 days before
(	1567		,	4	, 510,	58	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form-Final, 15 days after
(	1568		,	4	, 510,	15	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form-Final, 30 days before
(	1569		,	4	, 510,	38	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form-Final, 30 days after
(	1570		,	4	, 510,	36	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form-Final, 45 days before
(	1571		,	4	, 510,	33	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form-Final, 45 days after
(	1572		,	4	, 510,	59	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form-Final, 60 days before
(	1573		,	4	, 510,	45	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form-Final, 60 days after
(	1574		,	4	, 510,	17	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form-Final, 90 days before
(	1575		,	4	, 510,	44	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form-Final, 90 days after
(	1576		,	4	, 510,	35	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form-Final, 120 days before
(	1577		,	4	, 510,	62	, NOW(),	'admin',	1, UUID()),  --  Technical Report-Sponsor Form-Final, 120 days after
(	1578		,	4	, 510,	42	, NOW(),	'admin',	1, UUID());  --  Technical Report-Sponsor Form-Final, 1 year after


INSERT seq_valid_class_report_freq (ID)
SELECT VALID_CLASS_REPORT_FREQ_ID FROM valid_class_report_freq
WHERE VALID_CLASS_REPORT_FREQ_ID NOT IN (SELECT ID FROM seq_valid_class_report_freq);

COMMIT;   

/*

SELECT * FROM frequency;
SELECT * FROM REPORT_CLASS;
SELECT * FROM REPORT_STATUS;
select * from closeout_report_type;
select * from krcr_parm_t
order by 3;
select * from award_closeout;
select * from frequency_base;
select * from valid_frequency_base;
select * from report;
SELECT * FROM valid_class_report_freq;
select * from report;

*/
  

			