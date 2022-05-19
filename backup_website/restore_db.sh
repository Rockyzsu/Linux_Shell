#!/bin/bash

# 批量备份数据库
MYSQL_USER=root
MYSQL_PASSWORD=123456 # 改为你的mysql密码
HOST=127.0.0.1
restore_db=(db_bond_daily.sql db_bond_history.sql) # sql 文件列表

for i in ${restore_db[*]}
do
    name=(${i//./ })
    #echo ${name[0]}
    mysql -h$HOST -u$MYSQL_USER -p$MYSQL_PASSWORD ${name[0]}<${i}
    
done