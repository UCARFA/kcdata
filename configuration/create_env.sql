CREATE USER 'coeus'@'localhost' identified by 'kuali';
CREATE USER 'coeus'@'%' identified by 'kuali';
CREATE SCHEMA `coeus` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
GRANT ALL PRIVILEGES ON `coeus`.* TO 'coeus'@'%' WITH GRANT OPTION
