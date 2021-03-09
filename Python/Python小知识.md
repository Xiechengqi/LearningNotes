# Python 小知识

## 目录

* [标识符规范](#标识符规范)

* [字典使用 get 获取值](#字典使用-get-获取值)
* [字符串转换为 JSON 格式](#字符串转换为-json-格式)
* [中文编码问题](#中文编码问题)
* [列表特性 - 就地修改和有无返回值](#列表特性---就地修改和有无返回值)

## 标识符规范

> **标识符就是对变量、常量、函数、类等对象起的名字**

- 标识符以字母或下划线开头，后面部分由字母、数字和下划线组成，且对大小写敏感

* 变量名全部小写，常量名全部大写
* 函数和方法名用小写加下划线
* 类名用大写驼峰
* 模块和包的名字用小写

## 字典使用 get 获取值

* 访问字典中没有的项时，会报错。但使用 `d.get('键名','默认值')` 可以自定义不存在的值，这样就可以避免处理异常，默认返回 none

## 字符串转换为 JSON 格式

```bash
$ echo '{"name": "xiaoming", "job": "doctor", "sex": "male"}' | python -m json.tool
{
    "name": "xiaoming",
    "job": "doctor",
    "sex": "male"
}
```

## 中文编码问题

Python 中默认的编码格式是 ASCII 格式，在没修改编码格式时无法正确打印汉字，所以在读取中文时会报错

解决方法为只要在文件开头加入 `# -*- coding: UTF-8 -*-` 或者 `#coding=utf-8` 就行了

> 注意：`#coding=utf-8` 的 = 号两边不要空格。

## 列表特性 - 就地修改和有无返回值

|  | `list(lst)` | `del lst[x]` | `lst.append(o)` | `lst.clear() ` | `lst1.extend(lst2)` | `lst.insert(x,o)` | `lst.pop()` | `lst.remove(o)` | `lst.reverse()` | `lst.sort()` | `sorted(lst)` |
| --- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| 就地修改 | :x: |  :heavy_check_mark: |  :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |  :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :x: |
| 返回值 | :heavy_check_mark: | :x: | :x: | :x: | :x: | :x: | :heavy_check_mark: | :x: | :x: | :x: | :heavy_check_mark: |

> * `lst`：列表
> * `x`：元素索引
> * `0`：对象
