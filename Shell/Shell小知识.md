# Linux Shell 学习时的小知识

## 目录

* [Shebang 行](#shebang-行)
* [echo $(命令) 原样输出](#echo-命令-原样输出)
* [单行命令拆成多行执行](#单行命令拆成多行执行)
* [exit 0 和 exit 1](#exit-0和exit-1)
* [特殊变量](#特殊变量)
* [让一个变量获得命令输出的结果](#让一个变量获得命令输出的结果)
* [`命令 > /dev/null 2 > &1`和`命令 &> /dev/null`](#命令--devnull-2--1和命令--devnull)
* [数值比较](#数值比较)
* [几种数值计算方法](#几种数值计算方法)
* [数值进制间相互转换](#数值进制间相互转换)
* [等号两边不能有空格](#等号两边不能有空格)
* [ $( )、\` \`、${ }、$(( ))、$[ ] 、[ ]、(( )) 和 [[ ]] 详解]（#---------和---详解)
* [用 cat、echo 命令向文件写入](#用-cat-命令向文件写入)
* [杀死一个进程](#杀死一个进程)
* [删除空行](#删除空行)
* [文件去重](#文件去重)
* [截取文件开头几行、末尾几行和中间几行](#截取文件开头几行、末尾几行和中间几行)
* [修改文件以包含当前时间命名](#修改文件以包含当前时间命名)
* [查看当前主机公网 IP](#查看当前主机公网-ip)
* [while 无限循环](while-无限循环)
* [进程查端口，端口查进程](#进程查端口端口查进程)
* [查看其他主机开放的端口](#查看其他主机开放的端口)
* [快速查看配置文件中有效配置行](#快速查看配置文件中有效配置行)
* [使用重定向新建文件](#使用重定向新建文件)


## Shebang 行

* Shebang 行位于脚本第一行，用于指定解释器，即这个脚本必须通过什么解释器执行

``` bash
#!/usr/bin/env bash
# 意思是让 Shell 查找 $PATH 环境变量里面第一个匹配的 bash

# 这样执行脚本时就不用手动指定 Shell 解释器
$ ./script.sh
# 若没有 Shebang 行，则需要如下：
$ bash ./script.sh
```

## echo $(命令) 原样输出

``` bash
# echo `命令` 打印的命令的输出是单行的，可以通过添加双引号保持命令的原样格式输出
$ echo `ls`
abcdefghij001 abcdefghij002 abcdefghij003 abcdefghij004 abcdefghij005 abcdefghij006 abcdefghij007 abcdefghij008 abcdefghij009 abcdefghij010 abcdefghij011 abcdefghij012 abcdefghij013
$ echo "`ls`"
abcdefghij001
abcdefghij002
abcdefghij003
abcdefghij004
abcdefghij005
abcdefghij006
abcdefghij007
abcdefghij008
abcdefghij009
abcdefghij010
abcdefghij011
abcdefghij012
abcdefghij013
```

## 单行命令拆成多行执行

``` shell
$ echo foo bar
# 等同于
$ echo foo \
bar
```

## `exit 0`和`exit 1`

* Linux exit 命令用于退出目前的 shell
* 执行 exit 可使 shell 以指定的状态值退出
* 若不设置状态值参数，则 shell 以预设值退出；状态值 0 代表执行成功，其他值代表执行失败
* exit 也可用在 script，离开正在执行的 script，回到 shell
> 语法：exit [ 状态值 ]

<div align=center>
  <img src="./images/shell_exit.jpg"><br/>Ubuntu shell exit
 </div>

## 特殊变量

| $X | 说明 |
| --- | --- |
| $? | 最近一次运行命令的结束代码（返回值 0 表示成功，非 0 表示失败） |
| $$ | 脚本运行的当前进程 ID 号（PID） |
| $n(n=1,2...) | 传递给该 shell 脚本的第 n 个参数，参数多于 9 个时候，使用`${10}`形式引用 |
| $0 | 执行脚本本身的名字 |
| $# | 传递给脚本参数的个数 |
| $* | 脚本的所有参数列表,代表"$1 $2 … $n"，即当成一个整体输出，每一个变量参数之间以空格隔开 |
| $@ | 脚本的所有参数列表,代表"$1" "$2" … "$n" ，即每一个变量参数是独立的 ,也是全部输出 |

* 如果多个参数放在双引号里面，视为一个参数。
``` bash
$ ./script.sh "a b"
a b
```

### `$*` 和 `$@`区别
``` shell 
#!/bin/bash
# This script is to verify the difference between $* and $@
 
echo Dollar Star is $*
echo "Dollar Star in double quotes is $*"
 
echo Dollar At is $@
echo "Dollar At in double quotes is $@"
 
echo 
echo "Looping through Dollar Star"
for i in $*
do
	echo "parameter is $i"
done
echo 
echo "Looping through Dollar Star with double quotes"
for i in "$*"
do
	echo "Parameter is $i"
done 
 
echo
echo "Looping through Dollar At"
for i in $@
do
	echo "Parameter is $i"
done
echo
echo "Looping through Dollar At with double quotes"
for i in "$@"
do
	echo "Parameter is $i"
done

$ bash test.sh 1 2 " 3 4 " 5 6
Dollar Star is 1 2 3 4 5 6
Dollar Star in double quotes is 1 2  3 4  5 6
Dollar At is 1 2 3 4 5 6
Dollar At in double quotes is 1 2  3 4  5 6

Looping through Dollar Star
parameter is 1
parameter is 2
parameter is 3
parameter is 4
parameter is 5
parameter is 6

Looping through Dollar Star with double quotes
Parameter is 1 2  3 4  5 6

Looping through Dollar At
Parameter is 1
Parameter is 2
Parameter is 3
Parameter is 4
Parameter is 5
Parameter is 6

Looping through Dollar At with double quotes
Parameter is 1
Parameter is 2
Parameter is  3 4 
Parameter is 5
Parameter is 6
```

> * 相同点如下：
> 1、直接输出不保留空格
> 2、带双引号输出会保留带引号的空格
> 3、不带双引号循环遍历的输出结果一样：每个字符串单独输出
> * 不同点如下：
> 1、带双引号遍历`$*`相当于带双引号输出`$*`
> 2、带双引号遍历`$@`分别输出每个参数，带双引号的参数保留空格输出

<br/>
<div align=center>
  <img src="./images/shell_$.jpg"><br/>$* 示例
 </div>

## 让一个变量获得命令输出的结果

### 1、`$(命令)`表示

``` shell
#!/bin/bash
i=$(ls 123.txt)
echo $i
```

### 2、反引号表示

``` shell
#!/bin/bash
i=`ls 123.txt`
echo $i
```

## `命令 > /dev/null 2 > &1`和`命令 &> /dev/null`

> 解释：无提示（包括 stdin 和 stderr ）执行

<br/>
<div align=center>
  <img src="./images/shell_wj.jpg"><br/>
 </div>

 ### 文件描述符

 * 文件描述符是与文件输入、输出关联的整数。它们用来跟踪已打开的文件
 * 最常见的文件描述符是 stidin、stdout、和 stderr
  * 0 —— stdin（标准输入）
  * 1 —— stdout （标准输出）
  * 2 —— stderr （标准错误）
  
 * 我们可以将某个文件描述符的内容重定向到另外一个文件描述符中

<br/>
<div align=center>
  <img src="./images/shell_stdout.jpg"><br/>stdout （标准输出）
 </div>

 <br/>
<div align=center>
  <img src="./images/shell_stderr.jpg"><br/>stderr （标准错误）
 </div>

 ### `/dev/null`

 * `/dev/null`是一个特殊的设备文件，这个文件接收到的任何数据都会被丢弃。因此，null 这个设备通常也被成为位桶（ bit bucket ）或黑洞
 * 重定向操作给这个`/dev/null`文件的所有东西都会被丢弃

 ### 扩展使用

 ``` shell
 # 将 stderr 单独定向到一个文件，将stdout重定向到另一个文件
$ ls 123.txt 1> stdout.txt 2> stderr.txt
 # 将 stderr 转换成 stdout，使得 stderr 和 stdout 都被重新定向到同一个文件中
$ ls 123.txt 1> output.txt 2>&1
# 或
$ ls 123.txt > output.txt 2>&1
# 或
 $ ls 123.txt &> output.txt
# 或
 $ ls 123.txt >& output.txt
 ```

> * `>` 或 `1>`（标准输出）：把 STDOUT 重定向到文件,将默认或正确的传到另一个终端
> * `2>`（标准错误）：把 STDERR 重定向到文件，可将错误信息传到另一个终端，正确留下
> * `2>&1`：将错误转为正确输出，老式“洗钱”方法
> * `1>&2`：将正确转为错误输出
> * `&>`or`>&`：正确、错误都输出，新式方法

 ## 数值比较

| arg1 OP arg2 ( OP ) | 说明 |
| --- | --- |
| -eq | arg1 is equal arg2 |
| -ne | arg1 is not-equal arg2 |
| -lt | arg1 is less-than arg2 |
| -le | arg1 is less-than-or-equal arg2 |
| -gt | arg1 is greater-than arg2 |
| -ge | arg1 is greater-than-or-equal arg2 |

## 几种数值计算方法

 ``` shell
 $ ((i=5%2))
 $ echo $i            
 # 1
 
 $ let i=5%2
 $ echo $i            
 # 1
 
 $ expr 5 % 2
 # expr 之后的 5，%，2 之间必须有空格分开。如果进行乘法运算，需要对运算符进行转义，否则 Shell 会把乘号解释为通配符，导致语法错误
 
 $ i=$(echo 5%2 | bc)
 $ echo $i            
 # 1
  
  $ i=$(echo "5 2" | awk `{print $1+$2;}`)
  $ echo $i            
  # 1
 ```

 * `let`，`expr`，`bc` 都可以用来求模，运算符都是 `%`，而 `let` 和 `bc`可以用来求幂，运算符不一样，前者是` **`，后者是 `^ `
 * `(())` 的运算效率最高，而 `let` 作为 `Shell` 内置命令，效率也很高，但是 `expr`，`bc`，`awk` 的计算效率就比较低
* `let` 和 `expr` 都无法进行浮点运算，但是 `bc` 和 `awk` 可以
 ``` shell
 $ echo "scale=3; 1/12" | bc
 # 0.083
 
 $ echo "1 12" | awk '{printf("%0.3f\n",$1/$2)}'
 # 0.083
 ```

 ## 数值进制间相互转换

 ``` shell
# 八进制 12 转换为十进制
# 方法一、
$ echo "obase=8;ibase=10;12" | bc            
# 10
# obase - 进制源
# ibase - 进制转换目标
# bc 命令是任意精度计算器语言，通常在 linux 下当计算器用
 
# 方法二、
$ echo $((8#12)                                                 
# 10
 ```

 ## 等号两边不能有空格

 <div align=center>
  <img src="./images/nospace1.jpg"><br/>= 含有空格导致无法运行
 </div>

 <div align=center>
  <img src="./images/nospace2.jpg"><br/>正确
 </div>

 ## $( )、\` \`、${ }、$(( ))、$[ ] 、[ ]、(( )) 和 [[ ]] 详解

|  | 说明 | 举例 | 例子说明 |
| --- | --- | --- | --- |
| $( ) | 命令替换 | `version=$(uname -r)` | 得到内核版本号 |
| \` \` | 命令替换，同 $() | version=\`uname -r\` | 同上 |
| ${ } | 用于变量替换 |  `a=1; b=${a}`  其实这里用 $a 一样，但有时会有区别 | a 赋给 b |
| $(( )) | 进行数学运算 | `echo $(( 1+2*3 ))` | 输入 1+2×3 的结果 |
| $[ ] | 进行数学运算 | `echo $[ 1+2*3 ]` | 同上 |
| [ ] | test 命令的另一种形式 | `if [ 1 eq 1 ]...` | 字面意思 |
| (( )) | 是`[  ]`的针对数学比较表达式加强版 |  |  |
| [[ ]] | 是`[  ]`的针对字符串表达式的加强版 | [[ $? != 0 ]] |  |

 * \` \` 和 $( )：反引号几乎可以在所有 shell 上执行，而`$( )`有些不可以；多层使用反引号需要加`\`，`$( )`更浅显易懂，不易出错
 ``` shell
 $ cat a.txt
 b.txt
 $ cat b.txt
 c.txt
 $ cat c.txt
 Hello World!
 $ cat `cat \`cat a.txt\``   
 # ``内的反引号必须使用 \`
 Hello World!
 $ cat $(cat $(cat a.txt))
 Hello World!
 ```
 * bash 只能作整数运算，对于浮点数是当作字符串处理的
 * `[ ]`：必须在左括号的右侧和右括号的左侧各加一个空格，否则会报错

 ### 更多资料

http://bbs.chinaunix.net/forum.php?mod=viewthread&tid=218853&page=7#pid1617953

https://www.cnblogs.com/zejin2008/p/8412680.html

## 用 cat、echo 命令向文件写入

<kbd>**cat**</kbd>

``` bash
# 文件不存在则自动创建
# EOF 为开头结尾标记，可以换成任意字符串
# 1. 覆盖
cat > test.sh << EOF
> 1
> 2
> EOF
# 2. 追加
$ cat >> test.sh << EOF
> 1
> 2
> EOF
```

<kbd>**echo**</kbd>

``` bash
# 文件不存在则自动创建
# 1. 覆盖
echo 'hello
hello
world'>hello
# 2. 追加
echo 'hello
hello
world' >> hello
```

## 杀死一个进程

1. ps aux | grep 进程名 ---> kill -s 9 进程号
2. kill -s 9 \`ps aux | grep 进程名 | grep -v grep | awk '{print $2}'\`
3. ps aux | grep 进程名 | grep -v grep | xrags kill -s 9
4. kill -s 9 \`pgrep 进程名\`
5. pkill -s 9 进程名



<kbd>**kill [信号] [进程号]**</kbd>

* kill 给指定进程发送指定信号，默认发送 TERM 信号，这回杀死不能捕获该信号的进程，对于单纯 kill 杀不死的进程，可能需要使用 kill ( 9 ) 信号，因为该信号不能被任何进程捕获
* 当我们杀掉父进程时，其下的子进程也会被杀死
* `kill -9` 常用来杀死僵尸进程
* `pkill -9 进程名` 可以一次性杀死所有包含 `进程名` 的进程
  * `killall -9 进程名全称` 也是一次性杀死所有包含 `进程名` 的进程，但必须使用进程完整名称

*  `kill -s singal` 命令最长使用的信号：

| Signal Name | Single Value |        Effect         |
| :---------: | :----------: | :-------------------: |
|   SIGHUP    |      1       |         挂起          |
|   SIGINT    |      2       | 中断（等同 Ctrl + C） |
|             |      3       |  退出（同 Ctrl + \）  |
|   SIGKILL   |      9       |   发出强制杀死信号    |
|   SIGTERM   |      15      |  默认，发出终止信号   |
|   SIGSTOP   |  17, 19, 23  | 暂停（等同 Ctrl + Z） |

## 删除空行

``` shell
 sed '/^$/d' file

 sed -n '/./p' file

 grep -v ^$ file

 awk '/./ {print}' file 

 awk '{if($0!="") print}'

 tr -s "\n"
```



## 文件去重

``` shell
# 1. awk （不排序直接去重，按原顺序输出）
awk '!a[$0]++' file
cat file | awk '!a[$0]++'

# 2. sort + uniq (先排序再去重，打乱了顺序)
cat file | sort | uniq
```



## 截取文件开头几行、末尾几行和中间几行

``` shell
 # 截取前 5 行 - head、sed、awk
 head -5 filename
 # 或
 sed -n '1,5p' filename
 # 或
 awk 'NR < 5 {print $0}' filename
# 截取最后 5 行
tail -5 
# 截取 5 - 10 行
sed -n '5,10p' filename
# 或
cat filename | head -n 10 | tail -n +5
        # tail -n +2 : 从第 2  行开始显示之后的行
        # tail -n 2 或 tail -2 : 显示最后 2 行
# 先内容匹配找到某一行行号，再显示此行后 5 行
# 匹配显示 netstat -a 输出中的    Active UNIX domain sockets (servers and established) 后 5 行
netstat -a | tail -n +`netstat -a | sed -n -e '/UNIX/='` | head -n 5
活跃的UNIX域套接字 (服务器和已建立连接的)
Proto RefCnt Flags       Type       State         I-Node   路径
unix  2      [ ]         数据报                25378    /var/spool/postfix/dev/log
unix  2      [ ACC ]     流        LISTENING     38931    /tmp/.ICE-unix/3025
unix  2      [ ACC ]     流        LISTENING     36700    public/pickup
```



## 修改文件以包含当前时间命名

``` shell
$ ls
hello_log.txt
$ mv hello_log.txt $(date +%Y%m%d-%H%M%S)_hello_log.txt
$ ls
20191113-205057_hello_log.txt
$ tar cvf hello_log_$(date +%Y%m%d-%H%M%S).tar.gz 20191113-205057_hello_log.txt 
20191113-205057_hello_log.txt
$ ls
20191113-205057_hello_log.txt  hello_log_20191113-205252.tar.gz
```



## 查看当前主机公网 IP

``` shell
# 只返回 ip
$ curl ip.sb 
$ curl www.pubyun.com/dyndns/getip
$ curl members.3322.org/dyndns/getip

# 返回中文解析，包括 IP、地址、运营商
$ curl cip.cc
```

## while 无限循环

```bash
while :
do
    echo '我是死循环'
done

while /bin/true
do
     echo '我是死循环'
done
```

## 进程查端口，端口查进程

<kbd>**进程**</kbd> **->** <kbd>**端口**</kbd>

1. <kbd>**sudo netstat -tlpn | grep nginx**</kbd>
2. <kbd>**sudo ss -tlpn | grep nginx**</kbd>
3. <kbd>**sudo netstat -nap | grep \<pid\>**</kbd>

<kbd>**端口**</kbd> **->** <kbd>**进程**</kbd>

1. <kbd>**lsof -i:\<port\>**</kbd>
2. <kbd>**sudo netstat -nap | grep \<port\>**</kbd>

## 查看其他主机开放的端口

<kbd>**sudo nmap -sS \<ip\>**</kbd>

```bash
$ sudo nmap -sS 47.101.133.201

Starting Nmap 7.60 ( https://nmap.org ) at 2019-11-26 19:40 CST
Nmap scan report for 47.101.133.201
Host is up (0.045s latency).
Not shown: 995 filtered ports
PORT     STATE  SERVICE
22/tcp   open   ssh
80/tcp   closed http
443/tcp  closed https
1080/tcp closed socks
8080/tcp closed http-proxy

Nmap done: 1 IP address (1 host up) scanned in 28.81 seconds
```

## 快速查看配置文件中有效配置行

> 配置文件往往动辄几百行，但可能只有几行是非注释非换行的有效配置，可以使用 egrep -v 排除空行和注释行，快速查看配置文件的有效配置行

``` bash
# 查看 ansible 配置文件中的有效配置 ( 以 # 号开头是注释行 )
$ egrep -v "(^$|^#)" ./ansible.cfg
```

## 使用重定向新建文件

```bash
# 比 touch 新建少输入几个字符！
$ > new.txt
```

