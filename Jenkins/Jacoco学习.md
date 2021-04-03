## Jacoco 学习

> * **[Jacoco On the fly](https://segmentfault.com/a/1190000022512386)**

jacoco 可以有两种生效模式：**On-The-Fly代理模式** 和 **Offine模式**

- jacoco可以有两种生效模式：**On-The-Fly代理模式** 和 **Offine模式**

  这里只说fly模式，这种模式是基于javaagent，使用方便简单。在启动脚本中加入如下代码:

  -javaagent:D:\wechat\jacoco-0.8.5\lib\jacocoagent.jar=output=tcpserver,address=*,port=8888

  然后启动应用就可以进行代码覆盖率统计，这种模式是CS结构，应用是server，监听在8888 端口。

- 2.3 jacoco的导出。

  既然生成了数据，就要导出，怎么导出呐？先切换到lib目录，然后使用下面的命令：

  java -jar jacococli.jar dump --address 127.0.0.1 --port 8888 --destfile /dump.exec

- 生成我们看的懂的数据——html或者csv。

  因为exec文件我们没办法直接查看，因此需要生成report。report的命令我就不演示了，因为不重要，等下我会介绍一个效率更高的方式。命令如下

  java -jar jacococli.jar report [<execfiles> ...] --classfiles <path> [--csv <file>] [--encoding <charset>] [--help] [--html <dir>] [--name <name>] [--quiet] [--sourcefiles <path>] [--tabwith <n>] [--xml <file>]
  
- 测试报告覆盖率分析

- 红色：无覆盖，没有分支被执行

- 黄色：部分覆盖，部分分支被执行。

- 绿色：全覆盖，所有分支被执行