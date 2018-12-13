#! /bin/sh
#设置jar包位置

db_name=wangdong
#设置jar包位置
jar_path="../udf/TlHadoopCore-jar-with-dependencies.jar"
#设置udf classpath
class_path="cn.dd.job004.CwsUDF"
#数据的来源表
from_table=weibo_produce
#要生成的数据表
to_table=weibo_seg_result
#发起执行hql脚本
hive -e "
        set hive.exec.dynamic.partition.mode=nonstrict;
        use $db_name;
        add jar $jar_path;
        create temporary function seg as '$class_path';
        from $from_table
        insert overwrite table $to_table partition(week_seq)
select mid,retweeted_status_mid,uid,retweeted_uid,source,text,seg(text) as text_seg,geo,created_at,week_seq;
"
