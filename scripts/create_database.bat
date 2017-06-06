echo "This is the create_database.bat script"

c:\mysql-5.6.28-win32\bin\mysql -hkcnonprod1 -P13306 -uroot -pturnacold < ../configuration/test.sql
