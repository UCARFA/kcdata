# DROP Existing database, and recreate
DROP DATABASE IF EXISTS `coeus`;
CREATE DATABASE `coeus` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

# Grant privileges to the 'coeus' account.  This will create the account if it does not exist.
# MySQL 5.7 introduced 'CREATE USER IF NOT EXISTS', but we will have to do it this way until we
# upgrade. 
GRANT ALL PRIVILEGES ON `coeus`.* TO 'coeus'@'localhost' IDENTIFIED BY 'MuleD33r#' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `coeus`.* TO 'coeus'@'%' IDENTIFIED BY 'MuleD33r#' WITH GRANT OPTION;
