#! /bin/bash
#设置zip源文件所在的本地数据目录
parent_zip_dir=/home/wangdong/weibo_unzip
#将分区值转换成shell数组
partition_name_array=`ls $parent_zip_dir | xargs -n1 echo | cut -d . -f1`
#设置数据库名称
db_name=wangdong
#设置数据表名称
table_name=weibo_origin
#遍历每个分区数据，加载到对应的hive分区表当中
for one_partition in $partition_name_array; do
#打印当前正在处理的分区
  echo $one_partition
#正式执行导入代码
  hive -e "
        use $db_name;
        LOAD DATA LOCAL INPATH '$parent_zip_dir/$one_partition.csv' OVERWRITE INTO TABLE $table_name PARTITION (week_seq='$one_partition');
  "
  #break
done
#脚本执行完成
