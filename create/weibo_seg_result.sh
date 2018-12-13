#! /bin/bash

source ../config/set_env.sh

db_name=wangdong
table_name=weibo_seg_result

$HIVE -e"
  use $db_name;
  CREATE TABLE $table_name(
mid string,
retweeted_status_mid string,
uid string,
retweeted_uid string,
source string,
text string,
text_seg string,
geo string,
created_at string
)
comment 'weibo seg result table'
partitioned by (week_seq string comment 'the week sequence')
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n'
STORED AS orcfile;
"
