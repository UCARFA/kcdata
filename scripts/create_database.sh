#!/bin/sh
echo "Running create_database.sh to server $1 at port $2..."
echo "    Create user, empty database, and grant privileges..."
mysql -h$1 -P$2 -uroot -pturnacold < ./scripts/sql/create_user_db.sql
echo "    Restore base 'coeus' database..."
mysql -h$1 -P$2 -uroot -pturnacold coeus < ./databases/coeus_base.sql
