# Shell 中常用的命令

## 目录

* [常用组合命令](#常用组合命令)
* [echo](#echo)
* [type](#type)
* [env](#env)
* [read](#read)
* [](#)


## 常用组合命令


* **`du -h --max-depth=1 .`** - 查看当前文件夹下文件（文件夹）大小
* **`du -h --max-depth=1 /home/xcq`** - 查看 xcq 用户主目录大小
* **`df -h`** - 查看所有磁盘大小
* **`top -d 1 -p [pid,...]`** - 查看进程内存使用情况
* **`pmap [pid]`** - 查看进程内存使用情况
* **`ps aux | grep [process_name]`** - 查看 `/proc/process_id/` 文件夹下的 status 文件
* **`列出本机监听的端口号`**  
``` shell
$ netstat -tlnp
$ netstat -ulnp
$ netstat -anop
```
* **`ssh [user]@[hostip] bash < [path]/[shell脚本]`** - 在远程服务器上运行脚本
* **`siege -c20 www.baidu.com -b -t30s`** - 负载测试，30 秒内向 baidu 发起 20 个并发连接
* **``** - 
* **``** - 
* **``** - 
* **``** - 
* **``** - 
* **``** - 
* **``** - 
* **``** - 
* **``** - 
* **``** - 

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

