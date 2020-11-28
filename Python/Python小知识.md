# Python 小知识

## 目录

* [快速启动一个下载服务器](#快速启动一个下载服务器-top)
* [字符串转换为 JSON 格式](#字符串转换为-json-格式-top)
* [检查第三方库是否安装](#检查第三方库是否安装-top)

* [`# -*- coding: UTF-8 -*-`和`#coding=utf-8`中文编码问题](#----coding-utf-8---和codingutf-8中文编码问题-top)
* [列表特性 - 就地修改和有无返回值](#列表特性---就地修改和有无返回值-top)

## 快速启动一个下载服务器 [[Top]](#目录)

```bash
# 当前目录下有 index.html，则渲染出该文件页面；若没有，则显示当前目录下的文件列表
$ python -m http.server
```

## 字符串转换为 JSON 格式 [[Top]](#目录)

```bash
$ echo '{"name": "xiaoming", "job": "doctor", "sex": "male"}' | python -m json.tool
{
    "name": "xiaoming",
    "job": "doctor",
    "sex": "male"
}
```

## 检查第三方库是否安装 - [[Top]](#目录)

```bash
$ python -c "import django"
```


## `# -*- coding: UTF-8 -*-`和`#coding=utf-8`中文编码问题 [[Top]](#目录)

Python 中默认的编码格式是 ASCII 格式，在没修改编码格式时无法正确打印汉字，所以在读取中文时会报错

解决方法为只要在文件开头加入 `# -*- coding: UTF-8 -*-` 或者 `#coding=utf-8` 就行了

> 注意：`#coding=utf-8` 的 = 号两边不要空格。

## 列表特性 - 就地修改和有无返回值 [【Top】](#目录)

|  | `list(lst)` | `del lst[x]` | `lst.append(o)` | `lst.clear() ` | `lst1.extend(lst2)` | `lst.insert(x,o)` | `lst.pop()` | `lst.remove(o)` | `lst.reverse()` | `lst.sort()` | `sorted(lst)` |
| --- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| 就地修改 | :x: |  :heavy_check_mark: |  :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |  :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :x: |
| 返回值 | :heavy_check_mark: | :x: | :x: | :x: | :x: | :x: | :heavy_check_mark: | :x: | :x: | :x: | :heavy_check_mark: |

> * `lst`：列表
> * `x`：元素索引
> * `0`：对象
