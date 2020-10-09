
# Tomcat 优化

## 目录

**[压力测试](#)**
**[性能监控]()**
**[]()**
**[]()**



## 压力测试



1、 为了方便管理，设置软连接，若以后换版本了，可以很容易切换

```shell
`[root@centos-7 ``local``]``# ln -s /usr/local/apache-tomcat-8.5.42/ /usr/local/tomcat`
```

2、用户权限最小化，使用特定普通用户启动 Tomcat

``` shell
# 创建一个没有家目录的系统账号
$ useradd -r java
# 将 tomcat 目录下的文件所有者和所属组都进行修改
$ chown -R java.java /usr/local/tomcat/
# 以 java 用户形式进行启动 tomcat 服务
$ su - java -c /usr/local/tomcat/bin/startup.sh
```

3、编译安装最新 Tomcat

4、Tomcat 注册服务

