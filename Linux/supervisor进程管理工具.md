# Supervisor 进程管理工具

> * **[官方文档](http://supervisord.org/)**

## 目录

* **[安装](#安装)**
* []



## 安装

> * Supervisor 只支持 Linux 发行版，不支持 Windows

#### CentOS

``` shell
$ yum install -y epel-release && yum install -y supervisor
```

#### Python

* python 安装后需要手动生成 supervisor 配置文件及在 `/etc/supersord.conf` 添加 `[include]` 配置并创建对应目录

``` shell
# python >= 2.6
$ pip install supervisor

# pip 可以同理，easy_install 离线安装也可以
```

## 常用命令

* 安装好后在 `/usr/bin` 下会有三个 supervisor 命令: **`supervisortd、supervisorctl 和 echo_supervisord_conf`**
  * **`supervisortd`** - 用于管理 supervisor 本身服务
  * **`supervisorctl`** - 用于管理我们委托给 supervisor 工具的服务
  * **`echo_supervisord_conf`** - 通过运行 `echo_supervisord_conf` 命令生成 supervisor 的初始化配置文件，`yum` 安装的可省略此步骤

``` shell
$ mkdir /etc/supervisord.d
$ echo_supervisord_conf > /etc/supervisord.conf
```

#### **`supervisortd`**

``` shell
# 启动 supervisord
$ supervisord -c /etc/supervisord.conf
# 或
$ supervisord
# 或 (yum 安装)
$ systemctl start supervisord
```

#### **`supervisorctl`**

``` shell
# 进入交互式
$ supervisorctl
# 查看 supervisor 监管的进程状态
$ supervisorctl status
# 更新最新的配置到 supervisord（不会重启原来已运行的程序）。start、restart、stop 都不会载入最新的配置
supervisorctl update
# 载入所有配置文件，并按新的配置启动、管理所有进程（会重启原来已运行的程序）
supervisorctl reload
# 常用所有进程操作
$ supervisorctl status|start|stop|restart all
# 常用某个进程操作
$ supervisorctl status|start|stop|restart [进程名]
```



## 配置文件

* supervisor 配置文件: **`/etc/supervisord.conf`** 和 **`/etc/supervisord.d/`** 目录下文件，配置文件是 ini 格式
  * **`/etc/supervisord.conf`** - 主配置文件，配置 supervisor 服务本身
  * **`/etc/supervisord.d/`** - 默认子进程配置文件，配置需要管理的进程

#### 配置开启 web 管理

* 取消注释 `/etc/supervisord.conf` 的 **`inet_http_server`**

``` ini
[inet_http_server]       
port=*:9001
username=xxx
password=xxx
```

#### 配置管理进程

* supervisor 通过 `fork/exec` 的方式把这些被管理的进程当作 supervisor 的子进程来启动，这样只要在 supervisor 的配置文件中，把要管理的进程的可执行文件的路径写进去即可。也实现当子进程挂掉的时候，父进程可以准确获取子进程挂掉的信息的，可以选择是否自己启动和报警

* supervisor 只能管理默认前台启动的经常，比如 Redis 和 Tomcat 的 catalina.sh 等，Nginx 就无法使用 supervisor 管理
* supervisor 管理应用需要在 `/etc/supervisord` 目录下编写相应的配置文件

``` ini
[program:usercenter]  # usercenter 是应用程序的唯一标识，不能重复。对该程序的所有操作（start, restart 等）都通过名字来实现。
directory = /home/leon/projects/usercenter ; 程序的启动目录
command = gunicorn -w 8 -b 0.0.0.0:17510 wsgi:app  ; 启动命令
autostart = true     ; 在 supervisord 启动的时候也自动启动
startsecs = 5        ; 启动 5 秒后没有异常退出，就当作已经正常启动了，默认 1
autorestart = true   ; 程序异常退出后自动重启，可选值：[unexpected,true,false]，默认为 unexpected，表示进程意外杀死后才重启；意思为如果不是supervisord 来关闭的该进程则认为不正当关闭，supervisord 会再次把该进程给启动起来，只能使用该 supervisorctl 来进行关闭、启动、重启操作 
startretries = 3     ; 启动失败自动重试次数，默认 3
user = leon          ; 用哪个用户启动，默认是 root
redirect_stderr = true  ; 把 stderr 重定向到 stdout，默认 false
stdout_logfile_maxbytes = 20MB  ; stdout 日志文件大小，日志文件大小到 20M 后则进行切割，默认 50MB
stdout_logfile_backups = 20     ; stdout 日志文件备份数, 超过 20 个后老的将被删除，默认 10
stdout_logfile = /data/logs/usercenter_stdout.log ; 标准日志输出位置，如果输出位置不存在需要手动创建，否则会启动失败
```

#### 示例

* **`Jar`**

``` ini
[program:app]
directory = /data/product/app ; 程序的启动目录
command = java -jar -Xms2g -Xmx2g -Dspring.profiles.active=prod app-web-0.0.1-SNAPSHOT.jar ; 启动命令
autostart = true     ; 在 supervisord 启动的时候也自动启动
startsecs = 30        ; 启动 30 秒后没有异常退出，就当作已经正常启动了
autorestart = true   ; 程序异常退出后自动重启
startretries = 3     ; 启动失败自动重试次数，默认是 3
user = root          ; 用哪个用户启动
redirect_stderr = true  ; 把 stderr 重定向到 stdout，默认 false
stdout_logfile_maxbytes = 1000MB  ; stdout 日志文件大小，默认 50MB
stdout_logfile_backups = 5     ; stdout 日志文件备份数
stdout_logfile = /data/product/app/nohup.out ;应用日志目录
```

* **`Tomcat`**

``` ini
# cat /etc/supervisord.d/tomcat.conf
[program:tomcat]
directory=/usr/local/tomcat
command=/usr/local/tomcat/bin/catalina.sh run
autostart=true
startsecs=10
autorestart=true
startretries=3
user=root
priority=999                                            #进程启动优先级，默认999，假如Supervisord需要管理多个进程，那么值小的优先启动
stopsignal=INT
redirect_stderr=true
stdout_logfile_maxbytes=200MB
stdout_logfile_backups = 100
stdout_logfile=/usr/local/tomcat/logs/catalina.out
stopasgroup=false                                       #默认为false,进程被杀死时，是否向这个进程组发送stop信号，包括子进程
killasgroup=false                                       #默认为false，向进程组发送kill信号，包括子进程
```

* **`Redis`**

> * redis 若在配置文件中有 `daemon true` ，则无法使用 supervisor 来管理。必须先修改为 `daemon off  #关闭守护进程`

``` ini
# cat /etc/supervisord.d/redis.conf
[program:redis]
directory=/usr/local/redis
command=/usr/local/redis/bin/redis-server /usr/local/redis/etc/redis6001.conf
autostart=true
startsecs=10
autorestart=true
startretries=3
user=root
priority=999
stopsignal=INT
redirect_stderr=true
stdout_logfile_maxbytes=200MB
stdout_logfile_backups = 100
stdout_logfile=/usr/local/redis/logs/redis6001.log
stopasgroup=false
killasgroup=false
```









在项目中，经常有脚本需要常驻运行的需求。以PHP脚本为例，最简单的方式是：

```shell
$ nohup php cli.php &
```

这样能保证当前终端被关闭或者按CRTL+C后，脚本仍在后台运行。但是没法保证脚本异常后自动重启等。

Supervisor 是用Python开发的一套通用的进程管理程序，能将一个普通的命令行进程变为后台daemon，并监控进程状态，异常退出时能自动重启。



