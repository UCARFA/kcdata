echo "Running run_configs.bat..."
C:\mysql-5.6.28-win32\bin\mysql.exe -hkcnonprod1 -P13306 -uroot -pturnacold coeus < scripts\sql\insert_unit_hierarchy.sql
C:\mysql-5.6.28-win32\bin\mysql.exe -hkcnonprod1 -P13306 -uroot -pturnacold coeus < scripts\sql\modify_sponsor_types.sql
