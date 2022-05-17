#!/bin/bash

#你要修改的地方从这里开始
MYSQL_USER=root                 #mysql用户名
MYSQL_PASS=123456               #mysql密码
HOST=114.132.198.61
PORT=3306
MAIL_TO=xxxxx@gmail.com         #数据库发送到的邮箱
WEB_DATA_PARENT=/root/www/wwwroot
DATA_PATH_FOLDER=wecenter
WEB_DATA=/root/www/wwwroot/wecenter          #要备份的网站数据，如果是使用lnmp安装包，则默认这个为网站目录

#你要修改的地方从这里结束
#定义数据库的名字和旧数据库的名字
DataBakName=sql_$(date +"%Y%m%d").tar.gz
WebBakName=30daydo_$(date +%Y%m%d).tar.gz
OldData=sql_$(date -d -5day +"%Y%m%d").tar.gz
OldWeb=30daydo_$(date -d -5day +"%Y%m%d").tar.gz

#删除本地3天前的数据
rm -rf /root/backup/sql_$(date -d -3day +"%Y%m%d").tar.gz /root/backup/30daydo_$(date -d -3day +"%Y%m%d").tar.gz
cd /root/backup
#导出数据库,一个数据库一个压缩文件

# 如果没有mysql 客户端，安装流程参考： http://www.30daydo.com/article/44419

for db in `/usr/bin/mysql -h$HOST -u$MYSQL_USER -p$MYSQL_PASS --port $PORT -B -N -e 'SHOW DATABASES' | xargs`; do
    (/usr/bin/mysqldump -h$HOST --port $PORT -u$MYSQL_USER -p$MYSQL_PASS ${db} | gzip -9 - > ${db}.sql.gz)
done
# #压缩数据库文件为一个文件
tar zcf /root/backup/$DataBakName -C /root/backup/ *.sql.gz
rm -rf /root/backup/*.sql.gz

#发送数据库到Email,如果数据库压缩后太大,请注释这行
# echo "Content:This email is auto send by vps..." | mutt -a /home/backup/$DataBakName -s "Subject:VPS Database Backup" $MAIL_TO

#压缩网站数据

tar zcf /root/backup/$WebBakName -C  $WEB_DATA_PARENT  $DATA_PATH_FOLDER

#上传到FTP空间,删除FTP空间5天前的数据
# 如果需要，请把下面的注释去掉，填入你的ftp密码
# FTP_USER=ftpuser                #ftp用户名
# FTP_PASS=ftpuserpassword        #ftp密码
# FTP_IP=xxx.xxx.xxx.xxx          #ftp地址
# FTP_backup=backup               #ftp上存放备份文件的目录,这个要自己得ftp上面建的
# ftp -v -n $FTP_IP << END
# user $FTP_USER $FTP_PASS
# type binary
# cd $FTP_backup
# delete $OldData
# delete $OldWeb
# put $DataBakName
# put $WebBakName
# bye
# END
(base) 