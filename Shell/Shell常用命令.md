# Shell 中常用的命令

## 目录

* [echo](#echo)
* [type](#type)
* [env](#env)
* [](#)
* [](#)



## echo

**`echo -n`** - 输出不换行

``` bash
$ echo -n a;echo b
ab
```

**`echo -e`** - 解析特殊字符
``` bash
$ echo -e "hello\nworld!"
hello
world!
```

## type

**`type [command]`** - 检查命令是内置命令还是外部程序

``` bash
$ type git
git 是 /usr/bin/git
$ type echo
echo 是 shell 内建
```

**`type -a [command]`** - 查看一个命令的所有定义
``` bash
$ type -a echo
echo 是 shell 内建
echo 是 /bin/echo
```

**`type -t [command]`** - 返回一个命令的类型：别名（alias），关键词（keyword），函数（function），内置命令（builtin）和文件（file）
``` bash
$ type -t bash
file
$ type -t if
keyword
```

## env

**`env`** - 打印所有环境变量

``` bash
# printenv 也可以
$ env
CLUTTER_IM_MODULE=xim
LC_MEASUREMENT=en_HK.UTF-8
LESSCLOSE=/usr/bin/lesspipe %s %s
LC_PAPER=en_HK.UTF-8
LC_MONETARY=en_HK.UTF-8
XDG_MENU_PREFIX=gnome-
HADOOP_HOME=/home/xcq/Local/Hadoop/
LANG=zh_CN.UTF-8
...
```

**``**
``` bash

```

**``**
``` bash

```

## 

**``**
``` bash

```

**``**
``` bash

```

**``**
``` bash

```

## 

**``**
``` bash

```

**``**
``` bash

```

**``**
``` bash

```

