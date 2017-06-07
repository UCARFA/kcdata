echo "This is the create_database.sh script"
mysql -hkcnonprod1 -P13306 -uroot -pturnacold < ../configuration/create_env.sql
