# GitLab 迁移记录

>  现有 GitLab 是使用 Docker 安装的 9.3.2 版本，计划迁移到 RPM 安装的 13.3.6 版本

### 迁移过程

1、逐步升级 GitLab Docker 容器版本

因为 GitLab 不能跨版本升级，比如从 9 大版本是无法直接升级到 11 大版本的，必须先升级到当前大版本的最新版本，然后才能在升级到下一个大版本。

所以，Docker 升级 `9.3.2` 到 `13.3.6` 的过程是这样的：**`9.3.2` -> `9.5.10` -> `10.8.7` -> `11.11.8` -> `12.10.14` -> `13.0.12` -> `13.3.6`** (`12` 升 `13` 时候有些特殊，必须先升级到 `13.0.x`，才能升级到最新的 `13.3.6`)

迁移需要的 GitLab 各个版本容器镜像 `tar` 包和 `rpm` 包在 `192.168.7.12` 上的 `/opt/GitLab` 中

迁移过程容器命令：

``` shell
$ docker stop gitlab
$ docker pull gitlab/gitlab-ce:9.5.10-ce.0
$ docker run -itd --name gitlab-ce-9.5.10 -p 80:80 -p 2222:22 -v /srv/gitlab/config:/etc/gitlab -v /srv/gitlab/logs:/var/log/gitlab -v /srv/gitlab/data:/var/opt/gitlab gitlab/gitlab-ce:9.5.10-ce.0
# 查看容器启动日志，启动成功，浏览器访问，帐号密码登录查看
$ docker logs -f gitlab-ce-9.5.10

$ docker stop gitlab-ce-10.8.7
$ docker run -itd --name gitlab-ce-10.8.7 -p 80:80 -p 2222:22 -v /srv/gitlab/config:/etc/gitlab -v /srv/gitlab/logs:/var/log/gitlab -v /srv/gitlab/data:/var/opt/gitlab gitlab/gitlab-ce:10.8.7-ce.0
# 查看容器启动日志，启动成功，浏览器访问，帐号密码登录查看
$ docker logs -f gitlab-ce-10.8.7
......
$ docker run -itd --name gitlab-ce-13.3.6 -p 80:80 -p 2222:22 -v /srv/gitlab/config:/etc/gitlab -v /srv/gitlab/logs:/var/log/gitlab -v /srv/gitlab/data:/var/opt/gitlab gitlab/gitlab-ce:13.3.6-ce.0
```

2、在 `13.3.6` 版本容器内执行 GitLab 备份命令

``` shell
$ gitlab-rake gitlab:backup:create
```

* 备份目录：`/var/opt/gitlab/backups`（容器内）、`/srv/gitlab/data/backups`（容器外）
* 生成备份数据文件：`1600358803_2020_09_17_13.3.6_gitlab_backup.tar`
* 其他迁移需要备份的文件：容器内的 `/etc/gitlab/gitlab.rb`（宿主机上的`/srv/gitlab/config/config/gitlab.rb`）和容器内的 `/etc/gitlab/gitlab-secrets.json`（宿主机上的`/srv/gitlab/config/gitlab-secrets.json`）

3、将 `1600358803_2020_09_17_13.3.6_gitlab_backup.tar`、`gitlab.rb` 和 `gitlab-secrets.json` 传输到迁移机器

4、在迁移机器上恢复 GitLab 备份数据（迁移机器和源容器内 GitLab 版本必须完全相同）

* `xxx.gitlab_backup.tar` 放到 `/var/opt/gitlab/backups/`  
* 给 `1600358803_2020_09_17_13.3.6_gitlab_backup.tar` 增加权限

``` shell
$ chmod 777 /var/opt/gitlab/backups/1600358803_2020_09_17_13.3.6_gitlab_backup.tar
```

* 停止 GitLab 数据交换服务

``` shell
$ gitlab-ctl stop unicorn
ok: down: unicorn: 3188s, normally up
$ gitlab-ctl stop puma
$ gitlab-ctl stop sidekiq
ok: down: sidekiq: 3186s, normally up
$ gitlab-ctl status
run: alertmanager: (pid 23730) 4249s; run: log: (pid 23210) 4343s
run: gitaly: (pid 23585) 4252s; run: log: (pid 22585) 4451s
run: gitlab-exporter: (pid 23620) 4251s; run: log: (pid 23064) 4359s
run: gitlab-workhorse: (pid 23569) 4253s; run: log: (pid 22926) 4386s
run: grafana: (pid 23750) 4248s; run: log: (pid 23407) 4296s
run: logrotate: (pid 28170) 780s; run: log: (pid 22977) 4379s
run: nginx: (pid 23409) 4295s; run: log: (pid 22937) 4384s
run: node-exporter: (pid 23603) 4252s; run: log: (pid 23035) 4367s
run: postgres-exporter: (pid 23741) 4249s; run: log: (pid 23245) 4337s
run: postgresql: (pid 22682) 4446s; run: log: (pid 22731) 4443s
run: prometheus: (pid 23636) 4250s; run: log: (pid 23143) 4349s
run: redis: (pid 22520) 4458s; run: log: (pid 22535) 4457s
run: redis-exporter: (pid 23623) 4251s; run: log: (pid 23091) 4355s
run: registry: (pid 23578) 4252s; run: log: (pid 23018) 4371s
down: sidekiq: 3188s, normally up; run: log: (pid 22891) 4390s
down: unicorn: 3195s, normally up; run: log: (pid 22877) 4397s
```

* 恢复备份，中途需要输入两次 `yes`

``` shell
$ gitlab-backup restore BACKUP=1600358803_2020_09_17_13.3.6
# 这里去掉备份名字的 _gitlab_backup.tar
```

* 将 `gitlab.rb` 和 `gitlab-secrets.json` 放到 `/etc/gitlab/`

5、重启 GitLab，浏览器访问

``` shell
$ gitlab-ctl reconfigure
$ gitlab-ctl restart
$ gitlab-rake gitlab:check SANITIZE=true
```
