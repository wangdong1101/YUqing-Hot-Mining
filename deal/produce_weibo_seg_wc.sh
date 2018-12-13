#! /bin/bash

db_name=wangdong
input_table=weibo_seg_result
output_table=weibo_seg_wc

hive -e"
set hive.exec.dynamic.partition.mode=nonstrict;
use $db_name;
insert overwrite table $output_table partition(week_seq)
select word,count(1) as freq,week_seq from $input_table lateral view explode(split(text_seg,'\001')) word_table as word where week_seq='week1' and text_seg is not null and length(word)>1 group by week_seq,word order by freq desc;
"
