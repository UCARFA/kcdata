echo "Running run_base_configs.sh to server $1 port $2..."
mysql -h$1 -P$2 -uroot -pturnacold coeus < ./scripts/sql/ucar_kc_configs_lnx.sql
