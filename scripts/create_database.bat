echo "Running create_database.bat..."
echo "    Create user, empty database, and grant privileges..."
C:\mysql-5.6.28-win32\bin\mysql.exe -h%1 -P%2 -uroot -pturnacold < scripts\sql\create_user_db.sql
echo "    Restore base 'coeus' database..."
C:\mysql-5.6.28-win32\bin\mysql.exe -h%1 -P%2 -uroot -pturnacold coeus < databases\coeus_base.sql
