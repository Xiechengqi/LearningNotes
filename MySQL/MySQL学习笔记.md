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


# 导出一个数据库结构

```

























## 
