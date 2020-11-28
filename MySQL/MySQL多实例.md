# MySQL 实例

## 实例、进程、

## 单实例部署

### Linux command / shell

### docker command / docfile



## 多实例部署

> * [MySQL数据库运维之多单机多实例搭建](https://segmentfault.com/a/1190000015262090)

* 简单的说，MySQL 多实例就是在一台服务器上同时开启多个不同的服务端口（如 3306、 3307），同时运行多个 MySQL 服务进程，这些服务进程通过不同的 socket 监听不同的服务端口来提供服务。这些 MySQL 多实例公用一套 MySQL 安装程序，使用不同的 my.cnf（也可以相同）配置 文件、启动程序（也可以相同）和数据文件，在提供服务时，多实例 mysql 在逻辑上看来是各自独立的，他们根据配置文件的对应设定值，获得服务器相应数量的硬件资源 
* MySQL 多实例只需要一次部署，但有各自的配置文件（my.cnf）、启动程序、数据目录

### 实现方法

#### 1、基于多配置文件

* 分开管理启动脚本、配置文件、端口、basedir、datadir
  * 创建 mysql 用户和组
  * 创建数据目录，通常用端口号作为目录名
  * 创建多实例各自的配置文件( $datadir/xxx.cnf )
  * 更改实例数据目录的属主和属组权限
  * 通过指定的配置文件( $datadir/xxx.cnf )初始化数据目录（即初始化数据库），数据目录初始化前必须为空
  * 配置 `/etc/my.cnf` 实现集中管理多实例，这一步视实例各自的配置文件内容而定
  * 通过启动脚本管理多实例( 可以自己编写一个 shell 脚本或注册服务 service )
* 优点：逻辑简单，配置简单
* 缺点：管理起来不方便

#### 2、基于 mysqld_multi
> * [mysqld_multi - 管理多个MySQL服务器](http://www.deituicms.com/mysql8cn/cn/programs.html#mysqld-multi)

> * [基于mysqld_multi实现MySQL 5.7.24多实例多进程配置](https://blog.csdn.net/w892824196/article/details/104067734)

* 对于某些Linux平台，从RPM或Debian软件包安装MySQL包括用于管理MySQL服务器启动和关闭的systemd支持。 在这些平台上， 没有安装 mysqld_multi， 因为它是不必要的

* 通过官方自带的 mysqld_multi 工具，使用单独配置文件来实现多实例
* 优点：便于集中管理管理
* 缺点：不方便针对每个实例配置进行定制

#### 3、基于 systemd

> * [Configuring Multiple MySQL Instances Using systemd](https://dev.mysql.com/doc/refman/5.7/en/using-systemd.html#systemd-multiple-mysql-instances)



#### 4、基于 IM
* 使用 MySQL 实例管理器（MYSQLMANAGER），这个方法好像比较好不过也有点复杂
* 优点：便于集中管理
* 缺点：耦合度高。IM 一挂，实例全挂
* 不方便针对每个实例配置进行定制

#### 4、docker 容器

#### 5、ansible + mysqltools

> * https://github.com/Neeky/mysqltools
> * [如何一键部署mysql的多实例](https://kknews.cc/code/rnxqqnr.html)


