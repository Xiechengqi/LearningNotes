# SQL

## 常用命令

**`SELECT`**

| Products | prod_name           | prod_id | prod_price | vend_id |
| -------- | ------------------- | ------- | ---------- | ------- |
|          | gun                 | BANG00  | 10.0000    | 00      |
|          | Fish bean bag toy   | BNBG01  | 3.4900     | 00      |
|          | Bird bean bag toy   | BNBG02  | 3.4900     | 01      |
|          | Rabbit bean bag toy | BNBG03  | 3.4900     | 02      |

**SELECT prod_name FROM Products;** 

**SELECT prod_name,prod_id,prod_pride FROM Products;** 

**SELECT * FROM Products;**

**SELECT DISTINCT vend_id FROM Products;** -  去重

**SELECT TOP 2 prod_name FROM Products;** - 返回前 2 行（SQL Server 和 Access）

**SELECT prod_name FROM Products FETCH FIRST 2 ROWS ONLY;** - 返回前 2 行（DB2）

**SELECT prod_name FROM Products WHERE ROWNUM <= 2;** - 返回前 2 行（Oracle）

**SELECT prod_name FROM Products LIMIT 2;** - 返回前 2 行（Mysql、MariaDB、SQLite、PostgreSQL）

**SELECT prod_name FROM Products LIMIT 2 OFFSET 3;** - 返回第 2 行的后 3 行（Mysql、MariaDB、SQLite、PostgreSQL）

> `LIMIT 2 OFFSET 3` 又可以简化为 `LIMIT 3,2`，前为 OFFSET，后为 LIMIT

**SELECT * FROM Products;   -- 这是一条注释** 

**# 这也是一条注释** - 

**/* 多行注释 */** 

**`SELECT + ORDER BY`**

**SELECT prod_name FROM Products ORDER BY prod_name;** - 按 prod_name 列排序

**SELECT prod_name FROM Products ORDER BY prod_id;** - 根据非选择的列进行排序

**SELECT prod_name,prod_price FROM Products ORDER BY prod_price,prod_name;** - 先按价格排序，之后如果出现相同价格则按名字排序

**SELECT prod_id,prod_name,prod_price FROM Products ORDER BY 2,3** - 按 select 清单第 2、3 两列进行排序，先按第2列 prod_name排序，如果prod_name有相同的，则按第3列进行排序

**SELECT prod_name FROM Products ORDER BY prod_price DESC** - 降序排列（默认是升序）

**SELECT prod_id,prod_price,prod_name FROM Products ORDER BY prod_price DESC,prod_name;** - 价格降序排列，相同价格时名字还是按升序排列

**SELECT prod_id,prod_price,prod_name FROM Products ORDER BY prod_price DESC,prod_name DESC** - 价格降序排列，相同价格时名字也是按降序排列

**`SELECT + WHERE + 运算符/AND/OR/IN/NOT`**

**SELECT prod_name FROM Products WHERE prod_price=3.49;**

**`SELECT + WHERE + LIKE`**

**** - 

**** - 

**** - 

**** - 

**** - 

**** - 

