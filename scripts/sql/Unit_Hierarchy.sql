START TRANSACTION;

INSERT INTO UNIT (UNIT_NUMBER,PARENT_UNIT_NUMBER,UNIT_NAME,UPDATE_USER,UPDATE_TIMESTAMP,OBJ_ID,VER_NBR, ACTIVE_FLAG) 
VALUES ('UCAR', '000001', 'UCAR', 'admin', 	NOW(), UUID(), 1, 'Y'),
 ('NCAR', 'UCAR', 'NCAR', 'admin', 			NOW(), UUID(),1, 'Y'),
 ('UCP', 'UCAR', 'UCP', 'admin', 			NOW(), UUID(),1, 'Y'),
 ('COMET', 'UCP', 'UCP-COMET', 'admin', 	NOW(), UUID(),1, 'Y'),
 ('ACOM', 'NCAR', 'NCAR-ACOM', 'admin', 	NOW(), UUID(),1, 'Y'),
 ('CGD', 'NCAR', 'NCAR-CGD', 'admin', 		NOW(), UUID(),1, 'Y'),
 ('CISL', 'NCAR', 'NCAR-CISL', 'admin', 	NOW(), UUID(),1, 'Y'),
 ('COSMIC', 'UCP', 'UCP-COSMIC', 'admin', 	NOW(), UUID(),1, 'Y'),
 ('EOL', 'NCAR', 'NCAR-EOL', 'admin', 		NOW(), UUID(),1, 'Y'),
 ('HAO', 'NCAR', 'NCAR-HAO', 'admin', 		NOW(), UUID(),1, 'Y'),
 ('DLS', 'UCP', 'UCP-DLS', 'admin', 		NOW(), UUID(),1, 'Y'),
 ('MMM', 'NCAR', 'NCAR-MMM', 'admin', 		NOW(), UUID(),1, 'Y'),
 ('GLOBE', 'UCP', 'UCP-GLOBE', 'admin', 	NOW(), UUID(),1, 'Y'),
 ('NCARDIR', 'NCAR', 'NCAR-NCARDIR', 'admin', 				NOW(), UUID(),1, 'Y'),
 ('NCARDIVE', 'NCARDIR', 'NCAR-NCARDIR-NCARDIVEO', 'admin', NOW(), UUID(),1, 'Y'), -- updated by HCF on 6/8/17 Add NCARDIVEO under NCARDIR   Unit Number = "NCARDIVE"   Unit Name = "NCAR-NCARDIR-NCARDIVEO"    Parent Unit Number = "NCARDIR"
 ('JOSS', 'UCP', 'UCP-JOSS', 'admin', 		NOW(), UUID(), 1, 'N'),  --  Inactivate JOSS and VSP unit numbers updated by HCF on 6/8/17
 ('CPAESS', 'UCP', 'UCP-CPAESS', 'admin', 	NOW(), UUID(),1, 'Y'), -- updated by HCF on 6/8/17 Create CPAESS under UCP (JOSS and VSP have been "inactivated")  Unit Number = "CPAESS"  Unit Name = "UCP-CPAESS" Parent Unit Number = "UCP" 
 ('RAL', 'NCAR', 'NCAR-RAL', 'admin', 		NOW(), UUID(),1, 'Y'),
 ('NSDL', 'UCP', 'UCP-NSDL', 'admin', 		NOW(), UUID(),1, 'Y'),
 ('SCIED', 'UCP', 'UCP-SciED', 'admin', 	NOW(), UUID(),1, 'Y'),
 ('CHEMMOD', 'ACOM', 'NCAR-ACOM-CHEMMOD', 'admin', 			NOW(), UUID(),1, 'Y'),
 ('UCPDIR', 'UCP', 'UCP-UCPDIR', 'admin', 	NOW(), UUID(),1, 'Y'),
 ('AMP', 'CGD', 'NCAR-CGD-AMP', 'admin', 	NOW(), UUID(),1, 'Y'),
 ('CAS', 'CGD', 'NCAR-CGD-CAS', 'admin', 	NOW(), UUID(),1, 'Y'),
 ('CCR', 'CGD', 'NCAR-CGD-CCR', 'admin', 	NOW(), UUID(),1, 'Y'),
 ('UNIDATA', 'UCP', 'UCP-Unidata', 'admin', NOW(), UUID(),1, 'Y'),
 ('VSP', 'UCP', 'UCP-VSP', 'admin', 		NOW(), UUID(),1, 'N'),
 ('CSEG', 'CGD', 'NCAR-CGD-CSEG', 'admin', 	NOW(), UUID(),1, 'Y'),
 ('ISG', 'CGD', 'NCAR-CGD-ISG', 'admin', 	NOW(), UUID(),1, 'Y'),
 ('OS', 'CGD', 'NCAR-CGD-OS', 'admin', 		NOW(), UUID(),1, 'Y'),
 ('TSS', 'CGD', 'NCAR-CGD-TSS', 'admin', 	NOW(), UUID(),1, 'Y'),
 ('COMMINSI', 'ACOM', 'NCAR-ACOM-COMMINSITU', 'admin', NOW(), UUID(),1, 'Y'),
 ('SATREMOT', 'ACOM', 'NCAR-ACOM-SATREMOTE', 'admin', NOW(), UUID(),1, 'Y'),
 ('IMAGE', 'CISL', 'NCAR-CISL-IMAGe', 'admin', NOW(), UUID(),1, 'Y'),
 ('OSD', 'CISL', 'NCAR-CISL-OSD', 'admin', 	NOW(), UUID(),1, 'Y'),
 ('TDD', 'CISL', 'NCAR-CISL-TDD', 'admin', 	NOW(), UUID(),1, 'Y'),
 ('AOPMO', 'EOL', 'NCAR-EOL-AOPMO', 'admin', NOW(), UUID(),1, 'Y'),
 ('DMS', 'EOL', 'NCAR-EOL-DMS', 'admin', 	NOW(), UUID(),1, 'Y'), -- updated by HCF on 6/8/17  Update Unit Number from "CDS" to "DMS"      Update Unit Name from "NCAR-EOL-CDS" to "NCAR-EOL-DMS" 
 ('DFS', 'EOL', 'NCAR-EOL-DFS', 'admin', 	NOW(), UUID(),1, 'Y'),
 ('ISF', 'EOL', 'NCAR-EOL-ISF', 'admin', 	NOW(), UUID(),1, 'Y'),
 ('RAF', 'EOL', 'NCAR-EOL-RAF', 'admin', 	NOW(), UUID(),1, 'Y'),
 ('CSAP', 'RAL', 'NCAR-RAL-CSAP', 'admin', 	NOW(), UUID(),1, 'Y'),
 ('RSF', 'EOL', 'NCAR-EOL-RSF', 'admin', 	NOW(), UUID(),1, 'Y'),
 ('AIM', 'HAO', 'NCAR-HAO-AIM', 'admin', 	NOW(), UUID(),1, 'Y'),
 ('IG', 'HAO', 'NCAR-HAO-IG', 'admin', 		NOW(), UUID(),1, 'Y'),
 ('LSV', 'HAO', 'NCAR-HAO-LSV', 'admin', 	NOW(), UUID(),1, 'Y'),
 ('MLSO', 'HAO', 'NCAR-HAO-MLSO', 'admin', 	NOW(), UUID(),1, 'Y'),
 ('HAP', 'RAL', 'NCAR-RAL-HAP', 'admin', 	NOW(), UUID(),1, 'Y'),
 ('STSW', 'HAO', 'NCAR-HAO-STSW', 'admin', 	NOW(), UUID(),1, 'Y'),
 ('JNT', 'RAL', 'NCAR-RAL-JNT', 'admin', 	NOW(), UUID(),1, 'Y'),
 ('NSAP', 'RAL', 'NCAR-RAL-NSAP', 'admin', 	NOW(), UUID(),1, 'Y'),
 ('BLT', 'MMM', 'NCAR-MMM-BLT', 'admin', 	NOW(), UUID(),1, 'N'), --  Inactive divisions HCF 6/8/17
 ('WSAP', 'RAL', 'NCAR-RAL-WSAP', 'admin', 	NOW(), UUID(),1, 'Y'),
 ('DA', 'MMM', 'NCAR-MMM-DA', 'admin', 		NOW(), UUID(),1, 'N'),--  Inactive divisions HCF 6/8/17
 ('ITS', 'MMM', 'NCAR-MMM-ITS', 'admin', 	NOW(), UUID(),1, 'Y'),
 ('ASP', 'NCARDIR', 'NCAR-NCARDIR-ASP', 'admin', NOW(), UUID(),1, 'Y'),
 ('MD', 'MMM', 'NCAR-MMM-MD', 'admin', 		NOW(), UUID(), 1,'N'),   --  Inactive divisions HCF 6/8/17 
 ('MP', 'MMM', 'NCAR-MMM-MP', 'admin', 		NOW(), UUID(), 1,'N'),   --  Inactive divisions HCF 6/8/17
 ('PM', 'MMM', 'NCAR-MMM-PM', 'admin', 		NOW(), UUID(), 1,'N'),   --  Inactive divisions HCF 6/8/17
 ('RCR', 'MMM', 'NCAR-MMM-RCR', 'admin', 	NOW(), UUID(), 1,'N'),   --  Inactive divisions HCF 6/8/17
 ('C3WE', 'MMM', 'NCAR-MMM-C3WE', 'admin', 	NOW(), UUID(),1, 'Y'),   -- added by HCF on 6/8/17     Unit Number = "C3WE",   Unit Name = "NCAR-MMM-C3WE",  Parent Unit Number = "MMM"
 ('DPM', 'MMM', 'NCAR-MMM-DPM', 'admin', 	NOW(), UUID(),1, 'Y'),   -- added by HCF on 6/8/17   Unit Number = "DPM"     Unit Name = "NCAR-MMM-DPM" Parent Unit Number = "MMM"
 ('PARC', 'MMM', 'NCAR-MMM-PARC', 'admin', 	NOW(), UUID(),1, 'Y'),   -- added by HCF on 6/8/17     Unit Number = "PARC"    Unit Name = "NCAR-MMM-PARC"    Parent Unit Number = "MMM"
 ('WMR', 'MMM', 'NCAR-MMM-WMR', 'admin', 	NOW(), UUID(),1, 'Y'),   -- added by HCF on 6/8/17    Unit Number = "WMR"    Unit Name = "NCAR-MMM-WMR"    Parent Unit Number = "MMM"
 ('NCARDIRE', 'NCARDIR', 'NCAR-NCARDIR-NCARDire', 'admin', 	NOW(), UUID(),1, 'Y'),
 ('NCARLIB', 'NCARDIR', 'NCAR-NCARDIR-NCARLIB', 'admin', 	NOW(), UUID(),1, 'Y'),
 ('AAP', 'RAL', 'NCAR-RAL-AAP', 'admin', 					NOW(), UUID(), 1,'Y'),
 ('UNKNOWN', 'UCAR', 'UCAR-UNKNOWN', 'admin', 				NOW(), UUID(), 1,'Y'); --   updated by HCF on 6/8/17 Add "UNKNOWN" under UCAR Unit Number = "UNKNOWN" ,  Unit Name = "UCAR-UNKNOWN" , Parent Unit Number = "UCAR" 
 
 COMMIT;