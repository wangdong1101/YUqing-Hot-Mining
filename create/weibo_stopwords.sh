#! /bin/bash

db_name=wangdong
table_name=weibo_stopwords

hive -e "
use $db_name;
CREATE external TABLE $table_name(
word string
)
comment 'weibo stopwords'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n'
STORED AS textfile;
"
