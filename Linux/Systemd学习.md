# Linux Systemd 学习

``` shell
[Unit]
Description=ROT13 demo service
After=network.target
 
[Service]
Type=simple
User=ltpc
ExecStart=/usr/bin/env php /path/to/server.php
Restart=always
RestartSec=5
StartLimitInterval=0
 
[Install]
WantedBy=multi-user.target
```

``` shell
[Unit]
#简单介绍当前服务单元
Description=Shadowsocks multiple user server
#需要哪些服务单元启动后启动当前服务单元
Requires=network.target

[Service]
#服务的类型，一般都是 simple
Type=simple
#告诉 systemd 如何启动服务。启动的服务应当为持续运行的服务，不要加后台运行的选项
ExecStart=/usr/local/bin/ssserver -c /etc/shadowsocks/servers.json --pid-file=/tmp/ssserver.pid
#这是本文解决异常退出自动重启的方法，只要简单加一行
Restart=always

[Install]
WantedBy=multi-user.target
```
* 自动无限次重启(systemctl stop 是不会重启的):

``` shell
[Service]
Restart=always # 只要不是通过systemctl stop来停止服务，任何情况下都必须要重启服务，默认值为no 
RestartSec=5 # 重启间隔，比如某次异常后，等待 5s 再进行启动，默认值 0.1s
StartLimitInterval=0 # 无限次重启，默认是10s 内如果重启超过5次则不再重启，设置为 0 表示不限次数重启
```

``` shell
[Unit]
Description=Your Daemon
After=network-online.target
Wants=network-online.target systemd-networkd-wait-online.service
StartLimitIntervalSec=500
StartLimitBurst=5

[Service]
Restart=on-failure
RestartSec=5s
ExecStart=/path/to/daemon

[Install]
WantedBy=multi-user.target
```

* 根据服务退出状态决定是否重启 - `RestartPreventExitStatus`

> 该参数的值支持 exit code 和信号名 2 种，可写多个，以空格分隔，例如 `RestartPreventExitStatus=143 137 SIGTERM SIGKILL`

``` shell
[Unit]
Description=mytest

[Service]
Type=simple
ExecStart=/root/mem
Restart=always
RestartSec=5
StartLimitInterval=0
RestartPreventExitStatus=SIGKILL

[Install]
WantedBy=multi-user.target
```


* 加载环境变量文件

``` shell
[Service]
Environment=PYTHONPATH=$PYTHONPATH:/root/robot/models-master/research/:/root/robot/models-master/research/slim
```

* 允许设置开机启动

``` shell
[Install]
WantedBy=multi-user.target
```
