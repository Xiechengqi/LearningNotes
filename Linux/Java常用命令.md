# Java 常用命令

> 最近接触到 java 项目的部署和调试，所以有必要学习一下 java 相关的命令

## JDK、JRE、JVM 详解

> * JDK - Java development kit
> * JRE - Java runtime environment 
> * JVM - Java virtual machine 

![](./images/jdkjrejvm.png)



## jps - Java Virtual Machine Process Status Tool

* 显示当前用户启动的所有 Java 进程 PID
* jps 位于 `$JAVA_HOME/bin/` 目录下，是 Java JDK 中自带的命令
* 原理: java 程序在启动以后，会在 java.io.tmpdir 指定的目录下（即临时文件夹），生成一个类似于 `hsperfdata_User` 的文件夹，这个文件夹里（在 Linux 中为 `/tmp/hsperfdata_{userName}/`），每个文件对应一个 Java 进程，文件名就是 PID，因此 jsp 列出运行的 Java 进程就是读取此文件夹下文件的文件名。 也可以通过解析这几个文件获得更多关于进程的信息。
* **`jps [options] [hostid]`**
  * `[options]`:对输出格式进行控制
  * `[hostid]`: 指定特定主机(IP、Domain), 也可以指定具体协议，端口

**`[options]`**
* **`-q`**: 只输出 PID，不显示 jar、class、main 参数等信息
* **`-m`**: 输出传递给 Java 进程（main 函数）的参数 
* **`-l`**: 输出 main 函数完整 package 名称或 jar 完整名称
* **`-v`**: 显示传递给 Java 虚拟机的参数
* **`-V`**: 输出通过 .hotsportrc 或 -XX:Flags=<filename> 指定的 jvm 参数
* **`-Joption`**: 传递参数到 javac 调用的java lancher


* **`jps`** - 查看 Java 进程
``` shell
# jps
44736 para-portal-server-5.3.0.jar
44786 para-idm-server-5.3.0.jar
61812 Jps
44693 para-mobile-server-5.3.0.jar
44438 para-eureka-server-5.3.0.jar
44537 para-config-server-5.3.0.jar
44650 para-mfa-server-5.3.0.jar
44588 para-sso-server-5.3.1.jar
44844 para-msg-server-5.3.0.jar
```

* **`jps -l`** - 查看 Java 进程详细信息
```shell
# jps -l
44736 /opt/install4mfa-20200703/package/para-portal-server-5.3.0.jar
44786 /opt/install4mfa-20200703/package/para-idm-server-5.3.0.jar
44693 /opt/install4mfa-20200703/package/para-mobile-server-5.3.0.jar
44438 /opt/install4mfa-20200703/package/para-eureka-server-5.3.0.jar
61831 sun.tools.jps.Jps
44537 /opt/install4mfa-20200703/package/para-config-server-5.3.0.jar
44650 /opt/install4mfa-20200703/package/para-mfa-server-5.3.0.jar
44588 /opt/install4mfa-20200703/package/para-sso-server-5.3.1.jar
44844 /opt/install4mfa-20200703/package/para-msg-server-5.3.0.jar
```
* **``** -
* **``** -
* **``** -
* **``** -
* **``** -
* **``** -
* **``** -
* **``** -
* **``** -
* **``** -
* **``** -
* **``** -
