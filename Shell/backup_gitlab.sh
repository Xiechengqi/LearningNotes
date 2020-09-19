#!/usr/bin/env bash

# -----------------------
#
# xiechengqi - 20200919
# 添加定时任务：crontab -e
# 每天凌晨 3 点执行：0 3 * * * bash backup_gitlab.sh
#
# -----------------------

# 星期六和星期天不备份
[ $weekday -eq 6 ] && exit 0
[ $weekday -eq 0 ] && exit 0

today=`date +"%Y%m%d-%H%M%S"`
weekday=`date +%w`
backupPath='/data/backup/gitlab/'$today

# 默认只保留最近 5 天的备份
if [ `ls /data/backup/gitlab | egrep '^202.*' | wc -l` -gt 4 ]
then
cd /data/backup/gitlab
deletePath=`ls | egrep '^202.*' | head -1`
rm -rf $deletePath
fi

# 周一到周五备份，gitlab.rb、gitlab-secrets.json、xxx.tar 有这三样备份即可随意完整的迁移到任何相同版本的 GitLab
mkdir $backupPath
gitlab-rake gitlab:backup:create &> "$backupPath/backup.log"
[ $? -ne 0 ] && mv /data/backup/gitlab/$data '/data/backup/gitlab/'"$today"'-ERROR' && exit 1
cp /opt/gitlab/backup/*.tar /etc/gitlab/gitlab.rb /etc/gitlab/gitlab-secrets.json "$backupPath"
[ $? -ne 0 ] && mv /data/backup/gitlab/$data '/data/backup/gitlab/'"$today"'-ERROR' && exit 1
