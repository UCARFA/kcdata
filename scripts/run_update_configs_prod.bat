echo "Running run_update_configs.bat to server %1 port %2..."
C:\mysql-5.6.28-win32\bin\mysql.exe -h%1 -P%2 -uremoteadmin -p5uperglu3 coeus < .\scripts\sql\ucar_kc_configs_update.sql
