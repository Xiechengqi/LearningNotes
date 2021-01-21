# MySQL 学习笔记

## 目录

* **[介绍](#介绍)**
* **[基本命令](#基本命令)**
* **[](#)**
* **[](#)**
* **[](#)**

## 介绍

> * MySQL 是单进程多线程的

## 基本命令

``` shell
# which mysql
/usr/bin/mysql
# ls /usr/bin | grep mysql
mysql
mysqladmin
mysqlshow
mysqldump
mysqldumpslow
mysqlbinlog
mysqlcheck
mysql_config_editor
mysqld_pre_systemd
mysqlimport
mysql_install_db
mysql_plugin
mysqlpump
mysql_secure_installation
mysqlslap
mysql_ssl_rsa_setup
mysql_tzinfo_to_sql
mysql_upgrade
```

### mysql 

**`mysql [选项] [参数]`**
* **[选项]**
  * **`-h`**：MySQL 服务器的 ip 地址或主机名
  * **`-u`**：连接 MySQL 服务器的用户名
  * **`-e`**：执行 MySQL 内部命令
  * **`-p`**：连接 MySQL 服务器的密码

``` shell
# mysql 终端登录
$ mysql -h[ip/hostname] -u[用户] -p[密码] -e[sql语句]

# 创建数据库
$ mysql -uroot -p"$password" -e 'CREATE DATABASE test;'
$ mysql -uroot -p"$password" << EOF
CREATE DATABASE test;
CREATE DATABASE new;
EOF
# 导入 sql 语句到特定数据库执行
$ mysql -uroot -p"$password" test < ./test.sql
```

### mysqladmin

> * MySQL 服务器管理任务的客户端工具，它可以检查 MySQL 服务器的配置和当前工作状态、创建和删除数据库、创建用户和修改用户密码等操作
> * 常用在从 MySQL 执行一次命令获取信息，常见于脚本中使用

**`mysqladmin [选项] [命令[参数]]`**
* **`[选项]`**
  * **`-h`**：MySQL 服务器的 ip 地址或主机名
  * **`-u`**：连接 MySQL 服务器的用户名
  * **`-e`**：执行 MySQL 内部命令
  * **`-p`**：连接 MySQL 服务器的密码
  * **`-c [num]/--sleep=[num]`**：自动运行次数统计，必须和 -i 一起使用
  * **`-i [num]/--count=[num]`**：间隔多长时间重复执行
  * **`-S`**：`--socket=name`，指定用于连接数据库 socket file
* **`[命令]`**
  * **`create DB_Name`**：创建数据库
  * **`drop DB_Name`**：删除数据库及其所有表
  * **`debug`**：打开调试日志并记录于 error log 中
  * **`status`**：显示数据库简要状态信息
  * **`extended-status`**：显示扩展信息，输出 mysqld 的各状态变量及赋值，相当于执行 `mysql> show global status`
  * **`variables`**：输出 mysqld 的各服务器变量
  * **`flush-hosts`**：清空主机相关的缓存- DNS 解析缓存；此前因为连接错误次数过多而被拒绝访问 mysqld 的主机列表
  * **`flush-logs`**：清空所有日志
  * **`refresh`**：相当于同时使用 flush-hosts 和 flush-logs
  * **`flush-tables`**：清空所有表
  * **`flush-privileges`**：重载授权表
  * **`reload`**：同 `flush-privileges`
  * **`flush-status`**：重置状态变量的值
  * **`flush-threads`**：清空线程缓存
  * **`kill [id]`**：杀死 MySQL 指定线程（可以一次杀死多个线程，以逗号分隔，但不能有多余空格）
  * **`password [新密码]`**：修改当前用户的密码
  * **`ping`**：检测 mysqld 是否存活
  * **`processlist`**：显示 mysqld 线程列表
  * **`shutdown`**：关掉 mysqld
  * **`start-slave/stop-slave`**：启动/关闭从服务器线程


``` shell
# 修改 MySQL 用户密码
$ mysqladmin -uroot -p"$password" password "$newpassword"

# 显示 MySQL 简要状态
$ mysqladmin -uroot -p"$password" status

# 检测 MySQL Server(mysqld) 是否可用
mysqladmin -uroot -p ping

# 查看 mysqld 版本信息
$ mysqladmin -uroot -p version

# 同时执行多个命令
$ mysqladmin -uroot -p process status version
```

### mysqlshow

> * 显示 MySQL 服务器中数据库、表和列表信息 

### mysqldump

> * MySQL 数据库的备份工具，，用于将 MySQL 服务器中的数据库以标准的 sql 语言的方式导出，并保存到文件中
> * mysqldump 属于单线程，功能是非常强大的，不仅常被用于执行数据备份任务，甚至还可以用于数据迁移

``` shell
# 导出整个数据库
$ mysqldump -u 用户名 -p 密码 数据库名 > 导出文件名

# 导出一张表
$ mysqldump -u 用户名 -p 密码 数据库名 表名 > 导出文件名

```
-?, –help: 显示帮助信息，英文的；
-u, –user: 指定连接的用户名；
-p, –password: 指定用户的密码，可以交互输入密码；
-S , –socket: 指定socket文件连接，本地登录才会使用。
-h, –host: 指定连接的服务器名称或者IP。
-P, –port=: 连接数据库监听的端口。
–default-character-set: 设置字符集，默认是UTF8。
-A, –all-databases: 导出所有数据库。不过默认情况下是不会导出information_schema库。
-B, –databases: 导出指定的某个/或者某几个数据库，参数后面所有名字参量都被看作数据库名，包含CREATE DATABASE创建库的语句。
–tables: 导出指定表对象，参数格式为“库名 表名”，默认该参数将覆盖-B/–databases参数。
-w, –where: 只导出符合条件的记录。
-l, –lock-tables: 默认参数，锁定读取的表对象，想导出一致性备份的话最后使用该参数，会导致无法对表执行写入操作。
–single-transaction:
该选项在导出数据之前提交一个BEGIN SQL语句，BEGIN 不会阻塞任何应用程序且能保证导出时数据库的一致性状态。它只适用于多版本存储 引擎，仅InnoDB。本选项和–lock-tables 选项是互斥的，因为LOCK TABLES 会使任何挂起的事务隐含提交，使用参数–single-transaction会自动关闭该选项。
在InnoDB导出时会建立一致性快照，在保证导出数据的一致性前提下，又不会堵塞其他会话的读写操作，相比–lock-tables参数来说锁定粒度要低，造成的影响也要小很多。指定这个参数后，其他连接不能执行ALTER TABLE、DROP TABLE 、RENAME TABLE、TRUNCATE TABLE这类语句，事务的隔离级别无法控制DDL语句。
-d, –no-data: 只导出表结构，不导出表数据。
-t, –no-create-info: 只导出数据，而不添加CREATE TABLE 语句。
-f, –force: 即使遇到SQL错误，也继续执行，功能类似Oracle exp命令中的ignore参数。
-F, —flush-logs: 在执行导出前先刷新日志文件，视操作场景，有可能会触发多次刷新日志文件。一般来说，如果是全库导出，建议先刷新日志文件，否则就不用了，刷新日志的意思也就是新建一个binlog日志，后面的语句都从新的日志开始记录，方便恢复的时候寻找。
–master-data[=#]: 该选项将当前备份时候二进制日志的位置和文件名写入到输出中。该选项要求有RELOAD权限，并且必须启用二进制日志。如果该选项值等于1，位置和文件名被写入CHANGE MASTER语句形式的转储输出，如果你使用该SQL转储主服务器以设置从服务器，从服务器从主服务器二进制日志的正确位置开始。如果选项值等于2，CHANGE MASTER语句被写成SQL注释。如果value被省略，这是默认动作，也就是说-master-data=1会将CHANGE MASTER语句写入备份文件中，-master-data=2也会写入备份文件中，只不过会注释掉
–master-data选项会启用–lock-all-tables，除非还指定–single-transaction(在这种情况下，只在刚开始转储时短时间获得全局读锁定。又见–single-transaction。在任何一种情况下，日志相关动作发生在转储时。该选项自动关闭–lock-tables。
所以，我在INNODB引擎的数据库备份时，我会同时使用–master-data=2 和 –single-transaction两个选项。
-n, –no-create-db: 不生成建库的语句CREATE DATABASE … IF EXISTS，即使指定–all-databases或–databases这类参数。
–triggers: 导出表的触发器脚本，默认就是启用状态。使用–skip-triggers禁用它。
-R, –routines: 导出存储过程以及自定义函数。
在转储的数据库中转储存储程序(函数和程序)。
-E, –events: 输出event。
–ignore-table: 指定的表对象不做导出，参数值的格式为[db_name,tblname]，注意每次只能指定一个值，如果有多个表对象都不进行导出操作的话，那就需要指定多个–ignore-table参数，并为每个参数指定不同的参数值。
–add-drop-database: 在任何创建库语句前，附加DROP DATABASE 语句。
–add-drop-table: 在任何创建表语句前，附加DROP TABLE语句。这个参数是默认启用状态，可以使用– skip-add-drop-table参数禁用该参数。
–add-drop-trigger: 创建任何触发器前，附加DROP TRIGGER语句。
–add-locks: 在生成的INSERT语句前附加LOCK语句，该参数默认是启用状态。使用–skip-add-locks参数禁用。
-K, –disable-keys: 在导出的文件中输出 ‘/!40000 ALTER TABLE tb_name DISABLE KEYS */; 以及
‘/!40000 ALTER TABLE tb_name ENABLE KEYS */; ‘ 等信息。这两段信息会分别放在INSERT语句的前后，也就是说，在插入数据前先禁用索引，等完成数据插入后再启用索引，目的是为了加快导入的速度。该参数默认就是启用状态。可以通过–skip-disable-keys参数来禁用。
–opt: 功能等同于同时指定了 –add-drop-table, –add-locks, –create-options, –quick, –extended-insert, –lock-tables, –set-charset, 以及 –disable-keys这些参数。默认就是启用状态。使用–skip-opt来禁用该参数。
–skip-opt: 禁用–opt选项，相当于同时禁用 –add-drop-table, –add-locks, –create-options, –quick, –extended-insert, –lock-tables, –set-charset, 及 –disable-keys这些参数。
-q, –quick: 导出时不会将数据加载到缓存，而是直接输出。默认就是启用状态。可以使用–skip-quick 来禁用该参数。
```




























## 
