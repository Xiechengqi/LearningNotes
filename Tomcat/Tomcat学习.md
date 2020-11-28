# Tomcat 学习

## 目录
* [Tomcat 安装及配置](#tomcat-安装及配置-top)


## Tomcat 安装及配置 [[Top]](#目录)

> **环境**
> * Ubuntu 18.04 
> * Tomcat 7、8、9
> * JDK-12.0.1

### 1. 安装 Java

```  shell
$ echo $JAVA_HOME
/usr/lib/jvm/jdk-12.0.1
```

### 2. 到[官网](https://tomcat.apache.org/download-80.cgi)或其他软件镜像站，比如[清华镜像站](https://tomcat.apache.org/download-80.cgi)，下载二进制编码包 (  Binary Distributions 或 bin )

> * 下载后一定要使用非 root 用户解压，然后再将解压后文件转移到`/opt/tomcat`（可选其他）

<div align=center>
<img src="../images/tomcat_001.jpg"><br>Tomcat 解压后目录
</div>

### 3. 修改权限

``` shell
sudo chgrp -R xcq（非root用户） /opt/tomcat
sudo chmod -R g+r conf
sudo chmod g+x conf
sudo chown -R xcq webapps/ work/ temp/ logs/
```

### 4. 修改 systemctl 服务文件

``` shell
$ sudo vim /etc/systemd/system/tomcat.service
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

Environment=JAVA_HOME= #  #需要修改行 (Java home 路径，使用 echo $JAVA_HOME 查看）
Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat/apache-tomcat-9.0.27  #需要修改行
Environment=CATALINA_BASE=/opt/tomcat/apache-tomcat-9.0.27   #需要修改行
Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'
Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'

ExecStart=/opt/tomcat/apache-tomcat-9.0.27/bin/startup.sh     #需要修改行
ExecStop=/opt/tomcat/apache-tomcat-9.0.27/bin/shutdown.sh     #需要修改行

User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
```

### 5. 重新加载 systemd 守护程序，以便它知道我们的服务文件

``` shell
$ sudo systemctl daemon-reload
```

### 6. 调整防火墙

``` shell
# Tomcat 使用端口 8080 接受传统请求。 输入以下内容允许到该端口的流量：
sudo ufw allow 8080
```

### 7. 启动 tomcat

``` shell
sudo systemctl start tomcat
sudo systemctl status tomcat
```
