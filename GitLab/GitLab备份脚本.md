# GitLab 备份脚本

* FreeNAS 挂载到本地 `/mnt/backup`

``` shell
#!/usr/bin/env bash

# -----------------------
#
# 每周一到周周日凌晨 3 点备份
# 本地备份路径：/data/backup/gitlab
# 远程备份路径：/mnt/backup/gitdev
# 本地存放最近 7 天备份
# 远程存放最近 15 天的备份
#
# -----------------------

# 今天日期：20200920-121230 - 2020年9月20号，12点12分30秒
today=`date +"%Y%m%d-%H%M%S"`
# gitlab 备份目录，可以在 /etc/gitlab/gitlab.rb 中查看，默认是 /var/opt/gitlab/backups
gitlabBackupLocalPath='/var/opt/gitlab/backups'
# 本地磁盘备份路径，只存放最近 7 天的备份
backupLocalPath='/data/backup/gitlab'
# 本次备份产生的本地备份文件夹
fileLocalPath="$backupLocalPath"'/'"$today"
# 本次备份产生的日志文件
logfileLocalPath="$fileLocalPath"'/'"$today"'.log'
# 远程 freeNAS 备份路径，存放最近 15 天的备份
backupRemotePath='/mnt/backup/gitdev'
# 本次备份同步产生的远程备份文件夹
fileRemotePath="$backupRemotePath"'/'"$today"
# 远程 freeNAS 上的日志目录，永久保存
logsRemotePath="$backupRemotePath"'/logs'

# 只保留最近 7 次（即最近一周）的备份
if [ `ls /data/backup/gitlab | egrep '^202.*' | wc -l` -gt 6 ]
then
cd /data/backup/gitlab
deletePath=`ls | egrep '^202.*' | head -1`
rm -rf $deletePath
fi

# 开始备份前删除本地 /var/opt/gitlab/backups 旧的备份
cd $gitlabBackupLocalPath && rm -rf ./*
cd -

# /etc/gitlab/gitlab.rb、/etc/gitlab/gitlab-secrets.json、xxx.tar 有这三样备份即可随意完整的迁移到任何相同版本的 GitLab
mkdir $fileLocalPath
gitlab-rake gitlab:backup:create &> "$logfileLocalPath"
[ $? -ne 0 ] && mv $fileLocalPath "$fileLocalPath"'-BackupERROR' && exit 1
tarName=`ls $gitlabBackupLocalPath | egrep '.*13\.3\.6_gitlab_backup.tar'`
# 备份到本地 /data/backup/gitlab
cp /etc/gitlab/gitlab.rb /etc/gitlab/gitlab-secrets.json "$fileLocalPath" && mv "$gitlabBackupLocalPath"'/'"$tarName" "$fileLocalPath"
[ $? -ne 0 ] && mv $fileLocalPath "$fileLocalPath"'-BackupERROR' && exit 1
echo '----------------- BACKUP TO LOCAL SUCCESS --------------' >>"$logfileLocalPath"
# 同步到远程备份目录
rsync -avztP --delete $fileLocalPath $backupRemotePath
[ $? -ne 0 ] && mv $fileLocalPath "$fileLocalPath"'-RsyncERROR' && mv $fileRemotePath "$fileRemotePath"'-RsyncERROR' && exit 1
echo '----------------- BACKUP TO REMOTE SUCCESS --------------' >>"$logfileLocalPath"
cp $logfileLocalPath $logsRemotePath
```
