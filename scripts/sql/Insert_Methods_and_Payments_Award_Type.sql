-- all these tables could be involved

SELECT * FROM award;
SELECT * FROM award_type;
SELECT * FROM award_template;
SELECT * FROM award_basis_of_payment;
SELECT * FROM award_method_of_payment;
SELECT * FROM valid_award_basis_payment;
SELECT * FROM valid_basis_method_pmt;
SELECT * FROM proposal;

START TRANSACTION;

SELECT * FROM Award_Type;  

-- Blanket Order
INSERT Award_Type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 100, 'Blanket Order', NOW(), 'admin', 1, UUID() FROM Coeus.Award_Type;

-- Blanket Order Release
INSERT Award_Type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 110, 'Blanket Order Release', NOW(), 'admin', 1, UUID() FROM Coeus.Award_Type;

-- Contract-Funded
INSERT Award_Type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 120, 'Contract-Funded', NOW(), 'admin', 1, UUID() FROM Coeus.Award_Type;

-- Cooperative Agreement
INSERT Award_Type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 130, 'Cooperative Agreement', NOW(), 'admin', 1, UUID() FROM Coeus.Award_Type;

-- Cooperative Support Agreement
INSERT Award_Type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 140, 'Cooperative Support Agreement', NOW(), 'admin', 1, UUID() FROM Coeus.Award_Type;

-- Cooperative Support Agreement
INSERT Award_Type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 142, 'Cooperative Support Agreement-Base', NOW(), 'admin', 1, UUID() FROM Coeus.Award_Type;

-- Cooperative Support Agreement
INSERT Award_Type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 144, 'Cooperative Support Agreement-Base Supplemental', NOW(), 'admin', 1, UUID() FROM Coeus.Award_Type;

-- Cooperative Support Agreement
INSERT Award_Type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 146, 'Cooperative Support Agreement-Deployment', NOW(), 'admin', 1, UUID() FROM Coeus.Award_Type;

-- Cooperative Support Agreement
INSERT Award_Type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 148, 'Cooperative Support Agreement-Special', NOW(), 'admin', 1, UUID() FROM Coeus.Award_Type;

-- Cost Share Agreement
INSERT Award_Type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 150, 'Cost Share Agreement', NOW(), 'admin', 1, UUID() FROM Coeus.Award_Type;

-- Grant-Foundation
INSERT Award_Type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 160, 'Grant-Foundation', NOW(), 'admin', 1, UUID() FROM Coeus.Award_Type;

-- Grant-Government
INSERT Award_Type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 170, 'Grant-Government', NOW(), 'admin', 1, UUID() FROM Coeus.Award_Type;

-- Indefinite Delivery Indefinite Quantity Contract
INSERT Award_Type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 180, 'Indefinite Delivery Indefinite Quantity Contract', NOW(), 'admin', 1, UUID() FROM Coeus.Award_Type;

-- Interagency Award
INSERT Award_Type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 190, 'Interagency Award', NOW(), 'admin', 1, UUID() FROM Coeus.Award_Type;

-- Interagency Personnel Assignment
INSERT Award_Type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 200, 'Interagency Personnel Assignment', NOW(), 'admin', 1, UUID() FROM Coeus.Award_Type;

-- Letter Contract
INSERT Award_Type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 210, 'Letter Contract', NOW(), 'admin', 1, UUID() FROM Coeus.Award_Type;

-- Memorandum of Understanding
INSERT Award_Type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 220, 'Memorandum of Understanding', NOW(), 'admin', 1, UUID() FROM Coeus.Award_Type;

-- Other Agreement
INSERT Award_Type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 230, 'Other Agreement', NOW(), 'admin', 1, UUID() FROM Coeus.Award_Type;

-- Purchase Order
INSERT Award_Type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 240, 'Purchase Order', NOW(), 'admin', 1, UUID() FROM Coeus.Award_Type;

-- Subaward-US Government
INSERT Award_Type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 250, 'Subaward-US Government', NOW(), 'admin', 1, UUID() FROM Coeus.Award_Type;

-- Subcontract
INSERT Award_Type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 260, 'Subcontract', NOW(), 'admin', 1, UUID() FROM Coeus.Award_Type;

-- Subgrant-Foundation
INSERT Award_Type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 270, 'Subgrant-Foundation', NOW(), 'admin', 1, UUID() FROM Coeus.Award_Type;

-- Task Order
INSERT Award_Type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 280, 'Task Order', NOW(), 'admin', 1, UUID() FROM Coeus.Award_Type;

-- Task Order Agreement
INSERT Award_Type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 290, 'Task Order Agreement', NOW(), 'admin', 1, UUID() FROM Coeus.Award_Type;

INSERT Award_Type (AWARD_TYPE_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)
SELECT DISTINCT 300, 'Teaming Agreement', NOW(), 'admin', 1, UUID() FROM Coeus.Award_Type;

--  Update the Award table
UPDATE AWARD
	SET AWARD_TYPE_CODE =   CASE 	
								WHEN AWARD_TYPE_CODE = 1 THEN 170 
								WHEN AWARD_TYPE_CODE = 3 THEN 120 
								WHEN AWARD_TYPE_CODE = 4 THEN 180 
								WHEN AWARD_TYPE_CODE = 5 THEN 130 
								WHEN AWARD_TYPE_CODE = 9 THEN 230 
							END;
                            
                            
SELECT * FROM AWARD;   

UPDATE PROPOSAL
SET AWARD_TYPE_CODE =   CASE 	
								WHEN AWARD_TYPE_CODE = 1 THEN 170 
								WHEN AWARD_TYPE_CODE = 3 THEN 120 
								WHEN AWARD_TYPE_CODE = 4 THEN 180 
								WHEN AWARD_TYPE_CODE = 5 THEN 130 
								WHEN AWARD_TYPE_CODE = 9 THEN 230 
							END;
                            
                          
                            
                            
SELECT * FROM valid_award_basis_payment;
TRUNCATE TABLE valid_award_basis_payment;
SELECT * FROM valid_award_basis_payment;

SELECT * FROM valid_basis_method_pmt;
TRUNCATE TABLE valid_basis_method_pmt;
SELECT * FROM valid_basis_method_pmt;


SELECT * 
FROM award_method_of_payment
ORDER BY 2;

--  Advanced payment invoice
INSERT award_method_of_payment (VER_NBR, METHOD_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
SELECT '1', '100', 'Advance Payment Invoice', NOW(), 'admin', UUID();

--  Automatic payment
INSERT award_method_of_payment (VER_NBR, METHOD_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
SELECT '1', '110', 'Automatic Payment', NOW(), 'admin', UUID();

--  cost invoice
INSERT award_method_of_payment (VER_NBR, METHOD_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
SELECT '1', '120', 'Cost Invoice', NOW(), 'admin', UUID();

-- Cost Invoice with Certification
INSERT award_method_of_payment (VER_NBR, METHOD_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
SELECT '1', '130', 'Cost Invoice with Certification', NOW(), 'admin', UUID();

--  CR Installment Payments
INSERT award_method_of_payment (VER_NBR, METHOD_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
SELECT '1', '140', 'CR Installment Payments', NOW(), 'admin', UUID();

-- 'Deliverable/Milestone Schedule'
INSERT award_method_of_payment (VER_NBR, METHOD_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
SELECT '1', '150', 'Deliverable/Milestone Schedule', NOW(), 'admin', UUID();

-- 'Finance To Select'
INSERT award_method_of_payment (VER_NBR, METHOD_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
SELECT '1', '160', 'Finance to Select', NOW(), 'admin', UUID();

-- 'FFP Advance Payment
INSERT award_method_of_payment (VER_NBR, METHOD_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
SELECT '1', '170', 'FFP Advance Payment', NOW(), 'admin', UUID();

-- 'FFP Installment Payments
INSERT award_method_of_payment (VER_NBR, METHOD_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
SELECT '1', '180', 'FFP Installment Payments', NOW(), 'admin', UUID();

-- 'Imported Award-Not Selected'
INSERT award_method_of_payment (VER_NBR, METHOD_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
SELECT '1', '190', 'Imported Award-Not Selected', NOW(), 'admin', UUID();

-- 'Line of Credit'
INSERT award_method_of_payment (VER_NBR, METHOD_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
SELECT '1', '200', 'Line of Credit', NOW(), 'admin', UUID();

-- No Payment
INSERT award_method_of_payment (VER_NBR, METHOD_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
SELECT '1', '210', 'No Payment', NOW(), 'admin', UUID();

-- 'Time and Material Invoice'
INSERT award_method_of_payment (VER_NBR, METHOD_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
SELECT '1', '220', 'Time and Material Invoice', NOW(), 'admin', UUID();


SELECT * 
FROM award_method_of_payment
ORDER BY 2;

SELECT * 
FROM award_basis_of_payment;

-- Insert new rows into the table

INSERT award_basis_of_payment
(VER_NBR, BASIS_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
SELECT '1', '100', 'Cost Reimbursable', NOW(), 'admin', UUID();

INSERT award_basis_of_payment
(VER_NBR, BASIS_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
 SELECT '1', '110', 'Cost Reimbursable/Firm Fixed Price', NOW(), 'admin', UUID();

INSERT award_basis_of_payment
(VER_NBR, BASIS_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
 SELECT '1', '120', 'Firm Fixed Price', NOW(), 'admin', UUID();

INSERT award_basis_of_payment
(VER_NBR, BASIS_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
 SELECT '1', '130', 'Fixed Price Level of Effort', NOW(), 'admin', UUID();

INSERT award_basis_of_payment
(VER_NBR, BASIS_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
 SELECT '1', '140', 'Labor Hour', NOW(), 'admin', UUID();

INSERT award_basis_of_payment
(VER_NBR, BASIS_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
 SELECT '1', '150', 'No Cost Contract', NOW(), 'admin', UUID();

INSERT award_basis_of_payment
(VER_NBR, BASIS_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
 SELECT '1', '160', 'Other', NOW(), 'admin', UUID();

INSERT award_basis_of_payment
(VER_NBR, BASIS_OF_PAYMENT_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER, OBJ_ID)
 SELECT '1', '170', 'Time and Material', NOW(), 'admin', UUID();
 
SELECT * 
FROM award_basis_of_payment;


  UPDATE AWARD
	SET METHOD_OF_PAYMENT_CODE =   CASE 	
								WHEN METHOD_OF_PAYMENT_CODE = 1 THEN 200 
								WHEN METHOD_OF_PAYMENT_CODE = 2 THEN 120 
								WHEN METHOD_OF_PAYMENT_CODE = 3 THEN 170 
								WHEN METHOD_OF_PAYMENT_CODE = 4 THEN 150 
								WHEN METHOD_OF_PAYMENT_CODE = 7 THEN 100 
                                WHEN METHOD_OF_PAYMENT_CODE = 8 THEN 110 
								WHEN METHOD_OF_PAYMENT_CODE = 11 THEN 140 
								WHEN METHOD_OF_PAYMENT_CODE = 14 THEN 130 
								WHEN METHOD_OF_PAYMENT_CODE = 15 THEN 210 
								
							END;
                            
    UPDATE AWARD_TEMPLATE
	SET METHOD_OF_PAYMENT_CODE =   CASE 	
								WHEN METHOD_OF_PAYMENT_CODE = 1 THEN 200 
								WHEN METHOD_OF_PAYMENT_CODE = 2 THEN 120 
								WHEN METHOD_OF_PAYMENT_CODE = 3 THEN 170 
								WHEN METHOD_OF_PAYMENT_CODE = 4 THEN 150 
								WHEN METHOD_OF_PAYMENT_CODE = 7 THEN 100 
                                WHEN METHOD_OF_PAYMENT_CODE = 8 THEN 110 
								WHEN METHOD_OF_PAYMENT_CODE = 11 THEN 140 
								WHEN METHOD_OF_PAYMENT_CODE = 14 THEN 130 
								WHEN METHOD_OF_PAYMENT_CODE = 15 THEN 210 
								
							END;                         
                            
  UPDATE AWARD
	SET BASIS_OF_PAYMENT_CODE =   CASE 	
								WHEN BASIS_OF_PAYMENT_CODE = 1 THEN 120 
								WHEN BASIS_OF_PAYMENT_CODE = 2 THEN 100 
								WHEN BASIS_OF_PAYMENT_CODE = 3 THEN 130 
								WHEN BASIS_OF_PAYMENT_CODE = 4 THEN 160 
								WHEN BASIS_OF_PAYMENT_CODE = 6 THEN 150 
							END;                          
                            
  UPDATE AWARD_TEMPLATE
	SET BASIS_OF_PAYMENT_CODE =   CASE 	
								WHEN BASIS_OF_PAYMENT_CODE = 1 THEN 120 
								WHEN BASIS_OF_PAYMENT_CODE = 2 THEN 100 
								WHEN BASIS_OF_PAYMENT_CODE = 3 THEN 130 
								WHEN BASIS_OF_PAYMENT_CODE = 4 THEN 160 
								WHEN BASIS_OF_PAYMENT_CODE = 6 THEN 150 
							END; 


  DELETE FROM AWARD_METHOD_OF_PAYMENT
  WHERE METHOD_OF_PAYMENT_CODE < 100;
  
  DELETE FROM AWARD_BASIS_OF_PAYMENT
  WHERE BASIS_OF_PAYMENT_CODE < 100;
  

SELECT * FROM valid_award_basis_payment;
-- Insert the Blanket Order Values
INSERT valid_award_basis_payment (VALID_AWARD_BASIS_PAYMENT_ID,AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)

SELECT RIGHT(UUID_SHORT(),6),100, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID()
FROM award_basis_of_payment;

-- Insert the Blanket Order Release Values
INSERT valid_award_basis_payment (VALID_AWARD_BASIS_PAYMENT_ID,AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)

SELECT RIGHT(UUID_SHORT(),6),110, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID() 
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE <> '150';

-- Insert the Contracted-Funded Values 
INSERT valid_award_basis_payment (VALID_AWARD_BASIS_PAYMENT_ID,AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)

SELECT RIGHT(UUID_SHORT(),6),120, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID() 
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE <> '150';

-- Insert the Cooperative Agreement
INSERT valid_award_basis_payment (VALID_AWARD_BASIS_PAYMENT_ID,AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)

SELECT RIGHT(UUID_SHORT(),6),130, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID() 
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE IN ('160','100', '150');

-- Insert the Cooperative Support Agreement
INSERT valid_award_basis_payment (VALID_AWARD_BASIS_PAYMENT_ID,AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)

SELECT RIGHT(UUID_SHORT(),6), 140, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID() 
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE IN ('100','160');

-- Insert the Cooperative Support Agreement - Base
INSERT valid_award_basis_payment (VALID_AWARD_BASIS_PAYMENT_ID,AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)

SELECT RIGHT(UUID_SHORT(),6),142, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID() 
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE IN ('160','100');

-- Insert the Cooperative Support Agreement - Base Supplemental
INSERT valid_award_basis_payment (VALID_AWARD_BASIS_PAYMENT_ID,AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)

SELECT RIGHT(UUID_SHORT(),6),144, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID() 
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE IN ('160','100');

-- Insert the Cooperative Support Agreement - Deployment
INSERT valid_award_basis_payment (VALID_AWARD_BASIS_PAYMENT_ID,AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)

SELECT RIGHT(UUID_SHORT(),6),146, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID() 
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE IN ('160','100');

-- Insert the Cooperative Support Agreement - Special
INSERT valid_award_basis_payment (VALID_AWARD_BASIS_PAYMENT_ID,AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)

SELECT RIGHT(UUID_SHORT(),6),148, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID() 
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE IN ('160','100');

-- Insert the Cost Share Agreement
INSERT valid_award_basis_payment (VALID_AWARD_BASIS_PAYMENT_ID,AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)

SELECT RIGHT(UUID_SHORT(),6),150, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID()
FROM award_basis_of_payment;

-- Insert the Grant-Foundation
INSERT valid_award_basis_payment (VALID_AWARD_BASIS_PAYMENT_ID,AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)

SELECT RIGHT(UUID_SHORT(),6),160, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID()
FROM award_basis_of_payment;

-- Insert the Grant-Government
INSERT valid_award_basis_payment (VALID_AWARD_BASIS_PAYMENT_ID,AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)

SELECT RIGHT(UUID_SHORT(),6),170, BASIS_OF_PAYMENT_CODE, NOW(), 'admin', 1, UUID()
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE NOT IN ('140','150','170');

-- Insert the Indefinite Delivery Indefinite Quantity Contract
INSERT valid_award_basis_payment (VALID_AWARD_BASIS_PAYMENT_ID,AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)

SELECT 
RIGHT(UUID_SHORT(),6),
180, 
BASIS_OF_PAYMENT_CODE, 
NOW(), 
'admin', 
1, 
UUID()
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE  IN ( '150', '100');

-- Insert the Interagency Award
INSERT valid_award_basis_payment (VALID_AWARD_BASIS_PAYMENT_ID,AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)

SELECT 
RIGHT(UUID_SHORT(),6),
190, 
BASIS_OF_PAYMENT_CODE, 
NOW(), 
'admin', 
1, 
UUID()
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE  in ('100','160');

-- Insert the Interagency Personnel Assignment
INSERT valid_award_basis_payment (VALID_AWARD_BASIS_PAYMENT_ID,AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)

SELECT 
RIGHT(UUID_SHORT(),6),
200, 
BASIS_OF_PAYMENT_CODE, 
NOW(), 
'admin', 
1, 
UUID()
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE  = '100';

-- Insert the Letter Contract
INSERT valid_award_basis_payment (VALID_AWARD_BASIS_PAYMENT_ID,AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)

SELECT 
RIGHT(UUID_SHORT(),6),
210, 
BASIS_OF_PAYMENT_CODE, 
NOW(), 
'admin', 
1, 
UUID()
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE  <> '150';

-- Insert the Memorandum of Understanding
INSERT valid_award_basis_payment (VALID_AWARD_BASIS_PAYMENT_ID,AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)

SELECT 
RIGHT(UUID_SHORT(),6),
220, 
BASIS_OF_PAYMENT_CODE, 
NOW(), 
'admin', 
1, 
UUID()
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE  = '150';

-- Insert the Other Agreement (No Funds)
INSERT valid_award_basis_payment (VALID_AWARD_BASIS_PAYMENT_ID,AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)

SELECT 
RIGHT(UUID_SHORT(),6),
230, 
BASIS_OF_PAYMENT_CODE, 
NOW(), 
'admin', 
1, 
UUID()
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE  IN ('100','120','150','160');

-- Insert the Purchase Order
INSERT valid_award_basis_payment (VALID_AWARD_BASIS_PAYMENT_ID,AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)

SELECT 
RIGHT(UUID_SHORT(),6),
240, 
BASIS_OF_PAYMENT_CODE, 
NOW(), 
'admin', 
1, 
UUID()
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE  <> '150';

-- Insert the Subaward-US Government
INSERT valid_award_basis_payment (VALID_AWARD_BASIS_PAYMENT_ID,AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)

SELECT 
RIGHT(UUID_SHORT(),6),
250, 
BASIS_OF_PAYMENT_CODE, 
NOW(), 
'admin', 
1, 
UUID()
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE  NOT IN ('140','150','170');

-- Insert the Subcontract
INSERT valid_award_basis_payment (VALID_AWARD_BASIS_PAYMENT_ID,AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)

SELECT 
RIGHT(UUID_SHORT(),6),
260, 
BASIS_OF_PAYMENT_CODE, 
NOW(), 
'admin', 
1, 
UUID()
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE  <> '150';

-- Insert the Subgrant-Foundation
INSERT valid_award_basis_payment (VALID_AWARD_BASIS_PAYMENT_ID,AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)

SELECT 
RIGHT(UUID_SHORT(),6),
270, 
BASIS_OF_PAYMENT_CODE, 
NOW(), 
'admin', 
1, 
UUID()
FROM award_basis_of_payment;

-- Insert the Task Order
INSERT valid_award_basis_payment (VALID_AWARD_BASIS_PAYMENT_ID,AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)

SELECT 
RIGHT(UUID_SHORT(),6),
280, 
BASIS_OF_PAYMENT_CODE, 
NOW(), 
'admin', 
1, 
UUID()
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE  <> '150';

-- Insert the Task Order Agreement
INSERT valid_award_basis_payment (VALID_AWARD_BASIS_PAYMENT_ID,AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)

SELECT 
RIGHT(UUID_SHORT(),6),
290, 
BASIS_OF_PAYMENT_CODE, 
NOW(), 
'admin', 
1, 
UUID()
FROM award_basis_of_payment;

-- Insert the Teaming Agreement
INSERT valid_award_basis_payment (VALID_AWARD_BASIS_PAYMENT_ID,AWARD_TYPE_CODE, BASIS_OF_PAYMENT_CODE, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)

SELECT 
RIGHT(UUID_SHORT(),6),
300, 
BASIS_OF_PAYMENT_CODE, 
NOW(), 
'admin', 
1, 
UUID()
FROM award_basis_of_payment
WHERE BASIS_OF_PAYMENT_CODE  = '150';

SELECT * FROM valid_award_basis_payment ORDER BY 1;

-- Insert the Cost Reimbursable
INSERT valid_basis_method_pmt (VALID_BASIS_METHOD_PMT_ID,BASIS_OF_PAYMENT_CODE, METHOD_OF_PAYMENT_CODE, frequency_indicator, INV_INSTRUCTIONS_INDICATOR, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)

SELECT  
RIGHT(UUID_SHORT(),6),
100, 
METHOD_OF_PAYMENT_CODE, 
'O', 
'O', 
NOW(), 
'admin', 
1,
UUID()
FROM award_method_of_payment
WHERE METHOD_OF_PAYMENT_CODE NOT IN ('170','180');

-- Insert the Cost Reimbursable/Firm Fixed Price
INSERT valid_basis_method_pmt (VALID_BASIS_METHOD_PMT_ID,BASIS_OF_PAYMENT_CODE, METHOD_OF_PAYMENT_CODE, frequency_indicator, INV_INSTRUCTIONS_INDICATOR, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)


SELECT RIGHT(UUID_SHORT(),6),  
110, 
METHOD_OF_PAYMENT_CODE, 
'O', 
'O', 
NOW(), 
'admin', 
1,
UUID()
FROM award_method_of_payment;

-- Insert the Firm Fixed Price
INSERT valid_basis_method_pmt (VALID_BASIS_METHOD_PMT_ID,BASIS_OF_PAYMENT_CODE, METHOD_OF_PAYMENT_CODE, frequency_indicator, INV_INSTRUCTIONS_INDICATOR, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)

SELECT RIGHT(UUID_SHORT(),6),
120, 
METHOD_OF_PAYMENT_CODE, 
'O', 
'O', 
NOW(), 
'admin', 
1,
UUID()
FROM award_method_of_payment
WHERE METHOD_OF_PAYMENT_CODE <> 140;

-- Insert the Fixed Price Level of Effort
INSERT valid_basis_method_pmt (VALID_BASIS_METHOD_PMT_ID,BASIS_OF_PAYMENT_CODE, METHOD_OF_PAYMENT_CODE, frequency_indicator, INV_INSTRUCTIONS_INDICATOR, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)

SELECT RIGHT(UUID_SHORT(),6),
130, 
METHOD_OF_PAYMENT_CODE, 
'O', 
'O', 
NOW(), 
'admin', 
1,
UUID()
FROM award_method_of_payment
WHERE METHOD_OF_PAYMENT_CODE <> 200;

-- Insert the Labor Hour
INSERT valid_basis_method_pmt (VALID_BASIS_METHOD_PMT_ID,BASIS_OF_PAYMENT_CODE, METHOD_OF_PAYMENT_CODE, frequency_indicator, INV_INSTRUCTIONS_INDICATOR, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)

SELECT RIGHT(UUID_SHORT(),6),
140, 
METHOD_OF_PAYMENT_CODE, 
'O', 
'O', 
NOW(), 
'admin', 
1,
UUID()
FROM award_method_of_payment
WHERE METHOD_OF_PAYMENT_CODE <> 200;

-- Insert the No Cost Contract
INSERT valid_basis_method_pmt (VALID_BASIS_METHOD_PMT_ID,BASIS_OF_PAYMENT_CODE, METHOD_OF_PAYMENT_CODE, frequency_indicator, INV_INSTRUCTIONS_INDICATOR, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)

SELECT RIGHT(UUID_SHORT(),6), 
150, 
METHOD_OF_PAYMENT_CODE, 
'O', 
'O', 
NOW(), 
'admin', 
1,
UUID()
FROM award_method_of_payment;

-- Insert the Other
INSERT valid_basis_method_pmt (VALID_BASIS_METHOD_PMT_ID,BASIS_OF_PAYMENT_CODE, METHOD_OF_PAYMENT_CODE, frequency_indicator, INV_INSTRUCTIONS_INDICATOR, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)


SELECT RIGHT(UUID_SHORT(),6),
160, 
METHOD_OF_PAYMENT_CODE, 
'O', 
'O', 
NOW(), 
'admin', 
1,
UUID()
FROM award_method_of_payment;

-- Insert the Time and Material
INSERT valid_basis_method_pmt (VALID_BASIS_METHOD_PMT_ID,BASIS_OF_PAYMENT_CODE, METHOD_OF_PAYMENT_CODE, frequency_indicator, INV_INSTRUCTIONS_INDICATOR, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR, OBJ_ID)

SELECT RIGHT(UUID_SHORT(),6),
170, 
METHOD_OF_PAYMENT_CODE, 
'O', 
'O', 
NOW(), 
'admin', 
1,
UUID()
FROM award_method_of_payment
WHERE METHOD_OF_PAYMENT_CODE <> 200;

SELECT * FROM valid_basis_method_pmt;

SELECT * FROM AWARD_TYPE;

DELETE FROM AWARD_TYPE
WHERE AWARD_TYPE_CODE < 100;

SELECT * FROM AWARD_TYPE;

COMMIT;
