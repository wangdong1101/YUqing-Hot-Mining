#! /bin/bash

source ../config/set_env.sh

remote_mysql_server_ip=192.168.1.15
remote_mysql_server_port=9093
remote_mysql_server_username=job004_group2
remote_mysql_server_password=job004_group2
db_name=group2_weibo
table_name=weibo_hot_words_wd_shell

$MYSQL -h$remote_mysql_server_ip -u$remote_mysql_server_username -p$remote_mysql_server_password -e "
    use $db_name;
    CREATE TABLE $table_name (word varchar(255) DEFAULT NULL,freq int DEFAULT NULL,week_seq varchar(255) DEFAULT NULL) ENGINE=MyISAM DEFAULT CHARSET=utf8;
"
