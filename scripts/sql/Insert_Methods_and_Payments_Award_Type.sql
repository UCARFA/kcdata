-- all these tables could be involved


-- SELECT * FROM award_type;
-- SELECT * FROM award_basis_of_payment;
-- SELECT * FROM award_method_of_payment;
-- SELECT * FROM valid_award_basis_payment;
-- SELECT * FROM valid_basis_method_pmt;
-- SELECT * FROM seq_valid_basis_method_pmt_id


START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS tmp_award_type;
  CREATE TEMPORARY TABLE tmp_award_type (
  AWARD_TYPE_CODE decimal(3,0) NOT NULL DEFAULT '0',
  DESCRIPTION varchar(200) COLLATE utf8_bin NOT NULL,
  UPDATE_TIMESTAMP datetime NOT NULL,
  UPDATE_USER varchar(60) COLLATE utf8_bin NOT NULL,
  VER_NBR decimal(8,0) NOT NULL DEFAULT '1',
  OBJ_ID varchar(36) COLLATE utf8_bin NOT NULL);
  
DROP TEMPORARY TABLE IF EXISTS tmp_award_method_of_payment;
  CREATE TEMPORARY TABLE tmp_award_method_of_payment (
  VER_NBR decimal(8,0) NOT NULL DEFAULT '1',
  METHOD_OF_PAYMENT_CODE varchar(3) COLLATE utf8_bin NOT NULL DEFAULT '',
  DESCRIPTION varchar(200) COLLATE utf8_bin NOT NULL,
  UPDATE_TIMESTAMP datetime NOT NULL,
  UPDATE_USER varchar(60) COLLATE utf8_bin NOT NULL,
  OBJ_ID varchar(36) COLLATE utf8_bin NOT NULL);
  
DROP TEMPORARY TABLE IF EXISTS tmp_award_basis_of_payment;
  CREATE TEMPORARY TABLE tmp_award_basis_of_payment (
  VER_NBR decimal(8,0) NOT NULL DEFAULT '1',
  BASIS_OF_PAYMENT_CODE varchar(3) COLLATE utf8_bin NOT NULL DEFAULT '',
  DESCRIPTION varchar(200) COLLATE utf8_bin NOT NULL,
  UPDATE_TIMESTAMP datetime NOT NULL,
  UPDATE_USER varchar(60) COLLATE utf8_bin NOT NULL,
  OBJ_ID varchar(36) COLLATE utf8_bin NOT NULL);
  
DROP TEMPORARY TABLE IF EXISTS tmp_valid_award_basis_payment;
  CREATE TEMPORARY TABLE tmp_valid_award_basis_payment (
  ID INT NOT NULL AUTO_INCREMENT,
  AWARD_TYPE_CODE decimal(3,0) NOT NULL,
  BASIS_OF_PAYMENT_CODE varchar(3) COLLATE utf8_bin NOT NULL,
  UPDATE_TIMESTAMP datetime NOT NULL,
  UPDATE_USER varchar(60) COLLATE utf8_bin NOT NULL,
  VER_NBR decimal(8,0) NOT NULL DEFAULT '1',
  OBJ_ID varchar(36) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (ID));
  
DROP TEMPORARY TABLE IF EXISTS tmp_valid_basis_method_pmt;
  CREATE TEMPORARY TABLE tmp_valid_basis_method_pmt (
  ID INT NOT NULL AUTO_INCREMENT,
  BASIS_OF_PAYMENT_CODE varchar(3) COLLATE utf8_bin NOT NULL,
  METHOD_OF_PAYMENT_CODE varchar(3) COLLATE utf8_bin NOT NULL,
  frequency_indicator char(1) COLLATE utf8_bin DEFAULT NULL,
  INV_INSTRUCTIONS_INDICATOR char(1) COLLATE utf8_bin NOT NULL,
  UPDATE_TIMESTAMP datetime NOT NULL,
  UPDATE_USER varchar(60) COLLATE utf8_bin NOT NULL,
  VER_NBR decimal(8,0) NOT NULL DEFAULT '1',
  OBJ_ID varchar(36) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (ID));
  
  TRUNCATE TABLE valid_award_basis_payment;
  TRUNCATE TABLE valid_basis_method_pmt;
  TRUNCATE TABLE seq_valid_basis_method_pmt_id;
  
DELETE FROM AWARD_METHOD_OF_PAYMENT
  WHERE METHOD_OF_PAYMENT_CODE < 100;

DELETE FROM AWARD_BASIS_OF_PAYMENT
  WHERE BASIS_OF_PAYMENT_CODE < 100;
  
DELETE FROM AWARD_TYPE
  WHERE AWARD_TYPE_CODE < 100;
  
  /*
 SELECT @Max_valid_award_basis_payment:= Max(VALID_AWARD_BASIS_PAYMENT_ID) from valid_award_basis_payment
													WHERE VALID_AWARD_BASIS_PAYMENT_ID IS NOT NULL
                                                    UNION
													SELECT 0 
													from valid_award_basis_payment
													WHERE VALID_AWARD_BASIS_PAYMENT_ID IS NULL;
 
  
 SELECT @Max_valid_basis_method_pmt:= Max(id) from seq_valid_basis_method_pmt_id
													WHERE ID IS NOT NULL
                                                    UNION
													SELECT 0 
													from seq_valid_basis_method_pmt_id
													WHERE ID IS NULL;
                                                    
                                                    */
 
  -- Update the award_type
-- Blanket Order
INSERT tmp_award_type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 100, 'Blanket Order', NOW(), 'admin', 1, UUID() FROM Award_Type;

-- Blanket Order Release
INSERT tmp_award_type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 110, 'Blanket Order Release', NOW(), 'admin', 1, UUID() FROM Award_Type;

-- Contract-Funded
INSERT tmp_award_type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 120, 'Contract-Funded', NOW(), 'admin', 1, UUID() FROM Award_Type;

-- Cooperative Agreement
INSERT tmp_award_type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 130, 'Cooperative Agreement', NOW(), 'admin', 1, UUID() FROM Award_Type;

-- Cooperative Support Agreement
INSERT tmp_award_type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 140, 'Cooperative Support Agreement', NOW(), 'admin', 1, UUID() FROM Award_Type;

-- Cooperative Support Agreement
INSERT tmp_award_type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 142, 'Cooperative Support Agreement-Base', NOW(), 'admin', 1, UUID() FROM Award_Type;

-- Cooperative Support Agreement
INSERT tmp_award_type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 144, 'Cooperative Support Agreement-Base Supplemental', NOW(), 'admin', 1, UUID() FROM Award_Type;

-- Cooperative Support Agreement
INSERT tmp_award_type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 146, 'Cooperative Support Agreement-Deployment', NOW(), 'admin', 1, UUID() FROM Award_Type;

-- Cooperative Support Agreement-Holder
INSERT tmp_award_type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 147, 'Cooperative Support Agreement-Holder', NOW(), 'admin', 1, UUID() FROM Award_Type;

-- Cooperative Support Agreement
INSERT tmp_award_type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 148, 'Cooperative Support Agreement-Special', NOW(), 'admin', 1, UUID() FROM Award_Type;

-- Cost Share Agreement
INSERT tmp_award_type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 150, 'Cost Share Agreement', NOW(), 'admin', 1, UUID() FROM Award_Type;

-- Grant-Foundation
INSERT tmp_award_type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 160, 'Grant-Foundation', NOW(), 'admin', 1, UUID() FROM Award_Type;

-- Grant-Government
INSERT tmp_award_type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 170, 'Grant-Government', NOW(), 'admin', 1, UUID() FROM Award_Type;

-- Indefinite Delivery Indefinite Quantity Contract
INSERT tmp_award_type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 180, 'Indefinite Delivery Indefinite Quantity Contract', NOW(), 'admin', 1, UUID() FROM Award_Type;

-- Interagency Award
INSERT tmp_award_type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 190, 'Interagency Award', NOW(), 'admin', 1, UUID() FROM Award_Type;

-- Interagency Personnel Assignment
INSERT tmp_award_type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 200, 'Interagency Personnel Assignment', NOW(), 'admin', 1, UUID() FROM Award_Type;

-- Letter Contract
INSERT tmp_award_type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 210, 'Letter Contract', NOW(), 'admin', 1, UUID() FROM Award_Type;

-- Memorandum of Understanding
INSERT tmp_award_type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 220, 'Memorandum of Understanding', NOW(), 'admin', 1, UUID() FROM Award_Type;

-- Other Agreement
INSERT tmp_award_type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 230, 'Other Agreement', NOW(), 'admin', 1, UUID() FROM Award_Type;

-- Purchase Order
INSERT tmp_award_type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 240, 'Purchase Order', NOW(), 'admin', 1, UUID() FROM Award_Type;

-- Subaward-US Government
INSERT tmp_award_type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 250, 'Subaward-US Government', NOW(), 'admin', 1, UUID() FROM Award_Type;

-- Subcontract
INSERT tmp_award_type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 260, 'Subcontract', NOW(), 'admin', 1, UUID() FROM Award_Type;

-- Subgrant-Foundation
INSERT tmp_award_type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 270, 'Subgrant-Foundation', NOW(), 'admin', 1, UUID() FROM Award_Type;

-- Task Order
INSERT tmp_award_type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 280, 'Task Order', NOW(), 'admin', 1, UUID() FROM Award_Type;

-- Task Order Agreement
INSERT tmp_award_type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 290, 'Task Order Agreement', NOW(), 'admin', 1, UUID() FROM Award_Type;

-- Task Order Holder
INSERT tmp_award_type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 295, 'Task Order-Holder', NOW(), 'admin', 1, UUID() FROM Award_Type;

INSERT tmp_award_type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 300, 'Teaming Agreement', NOW(), 'admin', 1, UUID() FROM Award_Type;

INSERT award_type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID
FROM tmp_award_type WHERE AWARD_TYPE_CODE NOT IN (SELECT AWARD_TYPE_CODE FROM award_type);


  -- Update the award_method_of_payment

--  Advanced payment invoice
INSERT tmp_award_method_of_payment (VER_NBR, METHOD_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
SELECT '1', '100', 'Advance Payment Invoice', NOW(), 'admin', UUID();

--  Automatic payment
INSERT tmp_award_method_of_payment (VER_NBR, METHOD_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
SELECT '1', '110', 'Automatic Payment', NOW(), 'admin', UUID();

--  cost invoice
INSERT tmp_award_method_of_payment (VER_NBR, METHOD_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
SELECT '1', '120', 'Cost Invoice', NOW(), 'admin', UUID();

-- Cost Invoice with Certification
INSERT tmp_award_method_of_payment (VER_NBR, METHOD_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
SELECT '1', '130', 'Cost Invoice with Certification', NOW(), 'admin', UUID();

--  CR Installment Payments
INSERT tmp_award_method_of_payment (VER_NBR, METHOD_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
SELECT '1', '140', 'CR Installment Payments', NOW(), 'admin', UUID();

-- 'Deliverable/Milestone Schedule'
INSERT tmp_award_method_of_payment (VER_NBR, METHOD_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
SELECT '1', '150', 'Deliverable/Milestone Schedule', NOW(), 'admin', UUID();

-- 'Finance To Select'
INSERT tmp_award_method_of_payment (VER_NBR, METHOD_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
SELECT '1', '160', 'Finance to Select', NOW(), 'admin', UUID();

-- 'FFP Advance Payment
INSERT tmp_award_method_of_payment (VER_NBR, METHOD_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
SELECT '1', '170', 'FFP Advance Payment', NOW(), 'admin', UUID();

-- 'FFP Installment Payments
INSERT tmp_award_method_of_payment (VER_NBR, METHOD_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
SELECT '1', '180', 'FFP Installment Payments', NOW(), 'admin', UUID();

-- 'Imported Award-Not Selected'
INSERT tmp_award_method_of_payment (VER_NBR, METHOD_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
SELECT '1', '190', 'Imported Award-Not Selected', NOW(), 'admin', UUID();

-- 'Line of Credit'
INSERT tmp_award_method_of_payment (VER_NBR, METHOD_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
SELECT '1', '200', 'Line of Credit', NOW(), 'admin', UUID();

-- No Payment
INSERT tmp_award_method_of_payment (VER_NBR, METHOD_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
SELECT '1', '210', 'No Payment', NOW(), 'admin', UUID();

-- 'Time and Material Invoice'
INSERT tmp_award_method_of_payment (VER_NBR, METHOD_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
SELECT '1', '220', 'Time and Material Invoice', NOW(), 'admin', UUID();


INSERT award_method_of_payment (VER_NBR, METHOD_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
SELECT VER_NBR, METHOD_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID
FROM tmp_award_method_of_payment WHERE METHOD_OF_PAYMENT_CODE NOT IN (SELECT METHOD_OF_PAYMENT_CODE FROM award_method_of_payment);

-- Update the award_basis_of_payment

-- Insert new rows into the table

INSERT tmp_award_basis_of_payment (VER_NBR, BASIS_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
SELECT '1', '100', 'Cost Reimbursable', NOW(), 'admin', UUID();

INSERT tmp_award_basis_of_payment (VER_NBR, BASIS_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
 SELECT '1', '110', 'Cost Reimbursable/Firm Fixed Price', NOW(), 'admin', UUID();

INSERT tmp_award_basis_of_payment (VER_NBR, BASIS_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
 SELECT '1', '120', 'Firm Fixed Price', NOW(), 'admin', UUID();

INSERT tmp_award_basis_of_payment (VER_NBR, BASIS_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
 SELECT '1', '130', 'Fixed Price Level of Effort', NOW(), 'admin', UUID();

INSERT tmp_award_basis_of_payment (VER_NBR, BASIS_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
 SELECT '1', '140', 'Labor Hour', NOW(), 'admin', UUID();

INSERT tmp_award_basis_of_payment (VER_NBR, BASIS_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
 SELECT '1', '150', 'No Cost Contract', NOW(), 'admin', UUID();

INSERT tmp_award_basis_of_payment (VER_NBR, BASIS_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
 SELECT '1', '160', 'Other', NOW(), 'admin', UUID();

INSERT tmp_award_basis_of_payment (VER_NBR, BASIS_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
 SELECT '1', '170', 'Time and Material', NOW(), 'admin', UUID();
 
INSERT award_basis_of_payment (VER_NBR, BASIS_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
SELECT VER_NBR, BASIS_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID
FROM tmp_award_basis_of_payment WHERE BASIS_OF_PAYMENT_CODE NOT IN (SELECT BASIS_OF_PAYMENT_CODE FROM award_basis_of_payment);
 
-- Insert the valid_award_basis_payment values

-- Insert the Blanket Order Values
INSERT tmp_valid_award_basis_payment (AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT  100, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID()
FROM award_basis_of_payment;

-- Insert the Blanket Order Release Values
INSERT tmp_valid_award_basis_payment (AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT  110, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID() 
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE <> '150';

-- Insert the Contracted-Funded Values 
INSERT tmp_valid_award_basis_payment (AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT  120, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID() 
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE <> '150';

-- Insert the Cooperative Agreement
INSERT tmp_valid_award_basis_payment (AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT  130, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID() 
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE IN ('160','100', '150');

-- Insert the Cooperative Support Agreement
INSERT tmp_valid_award_basis_payment (AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT   140, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID() 
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE IN ('100','160');

-- Insert the Cooperative Support Agreement - Base
INSERT tmp_valid_award_basis_payment (AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT  142, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID() 
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE IN ('160','100');

-- Insert the Cooperative Support Agreement - Base Supplemental
INSERT tmp_valid_award_basis_payment (AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT  144, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID() 
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE IN ('160','100');

-- Insert the Cooperative Support Agreement - Deployment
INSERT tmp_valid_award_basis_payment (AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT  146, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID() 
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE IN ('160','100');

-- Insert the Cooperative Support Agreement - Holder
INSERT tmp_valid_award_basis_payment (AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT  147, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID() 
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE IN ('160','100');

-- Insert the Cooperative Support Agreement - Special
INSERT tmp_valid_award_basis_payment (AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT  148, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID() 
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE IN ('160','100');

-- Insert the Cost Share Agreement
INSERT tmp_valid_award_basis_payment (AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT  150, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID()
FROM award_basis_of_payment;

-- Insert the Grant-Foundation
INSERT tmp_valid_award_basis_payment (AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT  160, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID()
FROM award_basis_of_payment;

-- Insert the Grant-Government
INSERT tmp_valid_award_basis_payment (AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT  170, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID()
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE NOT IN ('140','150','170');

-- Insert the Indefinite Delivery Indefinite Quantity Contract
INSERT tmp_valid_award_basis_payment (AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT  180, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID()
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE  IN ( '150', '100');

-- Insert the Interagency Award
INSERT tmp_valid_award_basis_payment (AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT  190, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID()
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE  in ('100','160');

-- Insert the Interagency Personnel Assignment
INSERT tmp_valid_award_basis_payment (AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT  200, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID()
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE  = '100';

-- Insert the Letter Contract
INSERT tmp_valid_award_basis_payment (AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT  210, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID()
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE  <> '150';

-- Insert the Memorandum of Understanding
INSERT tmp_valid_award_basis_payment (AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT  220, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID()
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE  = '150';

-- Insert the Other Agreement (No Funds)
INSERT tmp_valid_award_basis_payment (AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT  230, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID()
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE  IN ('100','120','150','160');

-- Insert the Purchase Order
INSERT tmp_valid_award_basis_payment (AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT  240, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID()
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE  <> '150';

-- Insert the Subaward-US Government
INSERT tmp_valid_award_basis_payment (AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT  250, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID()
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE  NOT IN ('140','150','170');

-- Insert the Subcontract
INSERT tmp_valid_award_basis_payment (AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT  260, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID()
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE  <> '150';

-- Insert the Subgrant-Foundation
INSERT tmp_valid_award_basis_payment (AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT  270, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID()
FROM award_basis_of_payment;

-- Insert the Task Order
INSERT tmp_valid_award_basis_payment (AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT  280, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID()
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE  <> '150';

-- Insert the Task Order Agreement
INSERT tmp_valid_award_basis_payment (AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT  290, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID()
FROM award_basis_of_payment;

-- Insert the Task Order Holder
INSERT tmp_valid_award_basis_payment (AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT  295, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID()
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE  NOT IN ('150', '170');

-- Insert the Teaming Agreement
INSERT tmp_valid_award_basis_payment (AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT  300, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID()
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE  = '150';

INSERT valid_award_basis_payment (VALID_AWARD_BASIS_PAYMENT_ID, AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT ID, AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID
FROM tmp_valid_award_basis_payment;

-- Insert the valid_basis_method_payment values

-- Insert the Cost Reimbursable
INSERT tmp_valid_basis_method_pmt (BASIS_OF_PAYMENT_CODE, METHOD_OF_PAYMENT_CODE, frequency_indicator, INV_INSTRUCTIONS_INDICATOR, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT 100, METHOD_OF_PAYMENT_CODE, 'O', 'O', NOW(), 'admin', 1,UUID()
FROM award_method_of_payment
WHERE METHOD_OF_PAYMENT_CODE NOT IN ('170','180');

-- Insert the Cost Reimbursable/Firm Fixed Price
INSERT tmp_valid_basis_method_pmt (BASIS_OF_PAYMENT_CODE, METHOD_OF_PAYMENT_CODE, frequency_indicator, INV_INSTRUCTIONS_INDICATOR, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT    110, METHOD_OF_PAYMENT_CODE, 'O', 'O', NOW(), 'admin', 1,UUID()
FROM award_method_of_payment;

-- Insert the Firm Fixed Price
INSERT tmp_valid_basis_method_pmt (BASIS_OF_PAYMENT_CODE, METHOD_OF_PAYMENT_CODE, frequency_indicator, INV_INSTRUCTIONS_INDICATOR, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT  120, METHOD_OF_PAYMENT_CODE, 'O', 'O', NOW(), 'admin', 1,UUID()
FROM award_method_of_payment
WHERE METHOD_OF_PAYMENT_CODE <> 140;

-- Insert the Fixed Price Level of Effort
INSERT tmp_valid_basis_method_pmt (BASIS_OF_PAYMENT_CODE, METHOD_OF_PAYMENT_CODE, frequency_indicator, INV_INSTRUCTIONS_INDICATOR, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT  130, METHOD_OF_PAYMENT_CODE, 'O', 'O', NOW(), 'admin', 1,UUID()
FROM award_method_of_payment
WHERE METHOD_OF_PAYMENT_CODE <> 200;

-- Insert the Labor Hour
INSERT tmp_valid_basis_method_pmt (BASIS_OF_PAYMENT_CODE, METHOD_OF_PAYMENT_CODE, frequency_indicator, INV_INSTRUCTIONS_INDICATOR, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT  140, METHOD_OF_PAYMENT_CODE, 'O', 'O', NOW(), 'admin', 1,UUID()
FROM award_method_of_payment
WHERE METHOD_OF_PAYMENT_CODE <> 200;

-- Insert the No Cost Contract
INSERT tmp_valid_basis_method_pmt (BASIS_OF_PAYMENT_CODE, METHOD_OF_PAYMENT_CODE, frequency_indicator, INV_INSTRUCTIONS_INDICATOR, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT   150, METHOD_OF_PAYMENT_CODE, 'O', 'O', NOW(), 'admin', 1,UUID()
FROM award_method_of_payment;

-- Insert the Other
INSERT tmp_valid_basis_method_pmt (BASIS_OF_PAYMENT_CODE, METHOD_OF_PAYMENT_CODE, frequency_indicator, INV_INSTRUCTIONS_INDICATOR, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT  160, METHOD_OF_PAYMENT_CODE, 'O', 'O', NOW(), 'admin', 1,UUID()
FROM award_method_of_payment;

-- Insert the Time and Material
INSERT tmp_valid_basis_method_pmt (BASIS_OF_PAYMENT_CODE, METHOD_OF_PAYMENT_CODE, frequency_indicator, INV_INSTRUCTIONS_INDICATOR, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT  170, METHOD_OF_PAYMENT_CODE, 'O', 'O', NOW(), 'admin', 1,UUID()
FROM award_method_of_payment
WHERE METHOD_OF_PAYMENT_CODE <> 200;

INSERT valid_basis_method_pmt (VALID_BASIS_METHOD_PMT_ID, BASIS_OF_PAYMENT_CODE, METHOD_OF_PAYMENT_CODE, frequency_indicator, INV_INSTRUCTIONS_INDICATOR, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT ID, BASIS_OF_PAYMENT_CODE, METHOD_OF_PAYMENT_CODE, frequency_indicator, INV_INSTRUCTIONS_INDICATOR, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID
FROM tmp_valid_basis_method_pmt;


INSERT seq_valid_basis_method_pmt_id (ID)
SELECT DISTINCT VALID_BASIS_METHOD_PMT_ID
FROM valid_basis_method_pmt;



DROP TEMPORARY TABLE IF EXISTS tmp_award_type;
DROP TEMPORARY TABLE IF EXISTS tmp_award_method_of_payment;
DROP TEMPORARY TABLE IF EXISTS tmp_award_basis_of_payment;
DROP TEMPORARY TABLE IF EXISTS tmp_valid_award_basis_payment;
DROP TEMPORARY TABLE IF EXISTS tmp_valid_basis_method_pmt;

COMMIT;
