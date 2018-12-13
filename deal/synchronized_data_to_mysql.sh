#! /bin/sh
mysql -h192.168.1.15 -ujob004_group2  -pjob004_group2 -e "
   use group2_weibo;
   LOAD DATA LOCAL INFILE '/home/wangdong/joob00/yuqing_hot_miming/udf/hot_words/000000_0' INTO TABLE weibo_hot_words_wd FIELDS TERMINATED BY '\t';
"
