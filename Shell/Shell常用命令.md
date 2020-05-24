# Shell 中常用的命令

## 目录

* [echo](#echo)
* [type](#type)
* [env](#env)
* [read](#read)
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


## read

**`read -t [num]`** - 设置超时秒数，如果超过了指定时间，用户仍然没有输入，脚本将放弃等待，继续向下执行
``` bash
#!/bin/bash

echo -n "输入一些文本 > "
if read -t 3 response; then
  echo "用户已经输入了"
else
  echo "用户没有输入"
fi
```

**``read -p** - 参数指定用户输入的提示信息

``` bash
read -p "输入一个数字: " num
```

**`read -a`** - 把用户的输入赋值给一个数组，从零号位置开始

``` bash
$ read -a num
1 2 3 4
$ echo ${num[1]}
2
```

**`read -n`** - 指定最多读取若干个字符作为变量值
``` bash
# read -n 3 执行时输入第四和字符就自动退出
$ read -n 3 letter
abc$ echo $letter
abc
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

