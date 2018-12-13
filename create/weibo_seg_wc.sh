#! /bin/bash
db_name=wangdong
table_name=weibo_seg_wc
hive -e"
use $db_name;

CREATE TABLE $table_name(
word string,
freq int
)
comment 'weibo seg wc'
partitioned by (week_seq string comment 'the week sequence')
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n'
STORED AS orcfile;"
