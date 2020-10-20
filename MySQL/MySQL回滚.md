# MySQL 回滚

> * [mysql回滚到指定时间点](http://static.kancloud.cn/ichenpeng/blog/1514019)
> * [MySQL误操作的语法与回滚](https://www.phpzjj.com/article/6094.html#%E5%87%A0%E7%A7%8D%E6%83%85%E5%86%B5)
> * [MySQL误操作后如何快速回滚](https://www.jianshu.com/p/4b71eb2de1ba)

> 对于 MySQL 误操作的回滚，一般有以下两种方法：

* 简单粗暴：基于全量备份 + 增量 binlog，用全量备份重搭实例，再利用增量binlog备份，恢复到误操作之前的状态。然后跳过误操作的SQL，再继续应用binlog
* 精细操作：使用 binlog2sql、flashback 等工具生成 binlog 文件的逆向操作 sql 文件，通过执行相反操作的 sql 语句实现回滚
* 延迟备份


### 规范的数据库流程/权限/操作规范

* 做到权限最小化，只给业务开发 DML 权限，DDL 可以走工单
* 删除数据表之前先对表进行改名操作，然后观察一段时间确保无影响
* 改表名加固定后缀，并且管理员只能删除固定后缀的表
