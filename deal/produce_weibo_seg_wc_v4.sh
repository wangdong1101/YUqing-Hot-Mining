#! /bin/bash

hive -e "
set hive.exec.dynamic.partition.mode=nonstrict;
use wangdong;
insert overwrite table weibo_seg_wc partition(week_seq)
select main.word,freq,week_seq from
(select word,count(1) as freq,week_seq from weibo_seg_result lateral view explode(split(text_seg,'\001')) word_table as word where week_seq='week1' and text_seg is not null and length(word)>1 group by week_seq,word order by freq desc) main
left join (select word from weibo_stopwords) filter
on main.word=filter.word
where filter.word is null

"
