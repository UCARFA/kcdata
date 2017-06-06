echo "This is the create_database.bat script"

mysql.exe -hkcnonprod1 -P13306 -uroot -pturnacold < configuration\test.sql
