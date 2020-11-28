# 如何替换已忘记的 root 密码

> * 环境：
>   * 操作系统：Ubuntu 18.04 LTS
>   * 软件：Mysql 5.7.27
  
## 错误信息：

``` shell
$ mysql -u root -p
Enter password: 
ERROR 1045 (28000): Access denied for user 'root'@'localhost' (using password: YES)
```

## 操作

### 1、关闭 mysql 服务

```
service mysql stop
```

### 2、修改`/etc/mysql/my.cnf`文件

```
# 添加
[mysqld]
skip-grant-tables
```

### 3、启动 mysql ，并登录

```
$ service mysql start
$ mysql -uroot              # 此时无需密码即可直接进入
```

### 4、操作 user 表

``` shell
$ mysql -u root 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 4
Server version: 5.7.18 MySQL Community Server (GPL)
 
Copyright (c) 2000, 2017, Oracle and/or its affiliates. All rights reserved.
 
Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.
 
Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
 
mysql> use mysql;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A
 
Database changed

# MySQL < 5.7
mysql> update user set password=PASSWORD('123') where user='root';
ERROR 1054 (42S22): Unknown column 'password' in 'field list'

# MySQL >= 5.7，user 表已经没有 Password 字段
mysql> update mysql.user set authentication_string=password('123') where user='root';
Query OK, 1 row affected, 1 warning (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 1
 
mysql> flush privileges;
Query OK, 0 rows affected (0.00 sec)
 
mysql> exit
```

### 5、删除 my.cnf 中刚添加的内容，重启 mysql 服务器即可
