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
    LOAD DATA LOCAL INFILE '/home/wangdong/joob00/yuqing_hot_miming/udf/hot_words/000000_0' INTO TABLE weibo_hot_words_wd_shell FIELDS TERMINATED BY '\t';
"
