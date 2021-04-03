# Linux Shell 学习时的小知识

## 目录

* [curl 结合 sh 直接执行脚本](#curl-集合-sh-直接执行脚本)

* [查看当前环境所有环境变量](#查看当前环境所有环境变量)

* [按分割符取最后一列](#按分割符取最后一列)

* [两种脚本识别参数套路](#两种脚本识别参数套路)
* [POSIX 常用字符集合](#POSIX-常用字符集合)
* [确保脚本下载完全](#确保脚本下载完全)
* [根据某列排序](#根据某列排序)
* [进入执行脚本所在文件夹](#进入执行脚本所在文件夹)
* [替换字符串方法](#替换字符串方法)
* [删除空格](#删除空格)
* [awk 获取第 n 列以后所有列](#awk-获取第-n-列以后所有列)
* [for 循环高级玩法](#for-循环高级玩法)
* [从 1 到 n 的循环](#从-1-到-n-的循环)
* [tar 去除顶层目录结构](#tar-去除顶层目录结构)
* [getopts 获取命令参数](#getopts-获取命令参数)
* [csv 和 xlsx 文件格式互相转换](#csv-和-xlsx-文件格式互相转换)
* [判断字符串是否为空](#判断字符串是否为空)
* [变量设置默认值](#变量设置默认值)
* [判断 ip 是否合适](#判断-ip-是否合适)
* [实现按任意键继续](#实现按任意键继续)
* [timeout - 设置命令超时](#timeout---设置命令超时)
* [grep 默认模糊匹配的坑](#grep-默认模糊匹配的坑)
* [使用 iptables 做端口转发](#使用-iptables-做端口转发)
* [查找字符串所在行并输出行号](#查找字符串所在行并输出行号)
* [如何在 awk 中写变量](#如何在-awk-中写变量)
* [lshw 查看硬件信息](#lshw-查看硬件信息)
* [LANG 对正则表达式的影响](#lang-对正则表达式的影响)
* [快速切出当前路径的目录名](#快速切出当前路径的目录名)
* [计算脚本执行时间](#计算脚本执行时间)
* [if 条件判断的坑](#if-条件判断的坑)
* [打印主机ip](#打印主机ip)
* [通过端口判断服务是否启动](#通过端口判断服务是否启动)
* [Shell常用调试方法](#shell常用调试方法)
* [tar zxvf 的坑](#tar-zxvf-的坑)
* [变量替换](#变量替换)
* [shift](#shift)
* [nohup 和 & 区别](#nohup-和-&-区别)
* [数组](#数组)
* [命令后台运行](#命令后台运行)
* [while read line 和 for](#while-read-line-和-for)
* [rpm 离线安装步骤](#rpm-离线安装步骤)
* [使用 set 调试 shell 脚本](#使用-set-调试-shell-脚本)
* [Shell 中的单引号和双引号区别](#shell-中的单引号和双引号区别)
* [exit 退出值](#exit-退出值)
* [Shebang 行](#shebang-行)
* [echo $(命令) 原样输出](#echo-命令-原样输出)
* [单行命令拆成多行执行](#单行命令拆成多行执行)
* [exit 0 和 exit 1](#exit-0和exit-1)
* [特殊变量](#特殊变量)
* [让一个变量获得命令输出的结果](#让一个变量获得命令输出的结果)
* [重定向到空](#重定向到空)
* [数值比较](#数值比较)
* [几种数值计算方法](#几种数值计算方法)
* [数值进制间相互转换](#数值进制间相互转换)
* [等号两边不能有空格](#等号两边不能有空格)
* [ 条件判断中的各种括号](#条件判断中的各种括号)
* [字符串写入文件](#字符串写入文件)
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



## curl 结合 sh 直接执行脚本

``` shell
## 替换 docker 镜像源为 DaoCloud 源
curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s http://f1361db2.m.daocloud.io
```

* `sh -s <stdin>`  - 读取标准输入

## 查看当前环境所有环境变量

``` shell
$ sudo export
declare -x CLUTTER_IM_MODULE="fcitx"
declare -x COLORTERM="truecolor"
declare -x DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"
declare -x DEFAULTS_PATH="/usr/share/gconf/ubuntu.default.path"
declare -x DESKTOP_AUTOSTART_ID="10a2c25379f087c45d16158603309651400000022820017"
declare -x DESKTOP_SESSION="ubuntu"
declare -x DISPLAY=":0"
declare -x GDK_BACKEND="x11"
declare -x GDMSESSION="ubuntu"
declare -x GIO_LAUNCHED_DESKTOP_FILE="/home/xcq/.config/autostart/guake.desktop"
declare -x GIO_LAUNCHED_DESKTOP_FILE_PID="2520"
declare -x GNOME_DESKTOP_SESSION_ID="this-is-deprecated"
declare -x GNOME_SHELL_SESSION_MODE="ubuntu"
declare -x GO111MODULE="on"
declare -x GOPROXY="https://goproxy.io"
declare -x GPG_AGENT_INFO="/run/user/1000/gnupg/S.gpg-agent:0:1"
declare -x GTK_IM_MODULE="fcitx"
declare -x GTK_MODULES="gail:atk-bridge"
declare -x HOME="/home/xcq"
declare -x IM_CONFIG_PHASE="1"
declare -x INVOCATION_ID="c27c1079599247de8f9419e7082faa05"
declare -x JOURNAL_STREAM="9:43903"
declare -x LANG="zh_CN.UTF-8"
declare -x LANGUAGE="zh_CN:zh:en_US:en"
declare -x LC_ADDRESS="zh_CN.UTF-8"
declare -x LC_IDENTIFICATION="zh_CN.UTF-8"
declare -x LC_MEASUREMENT="zh_CN.UTF-8"
declare -x LC_MONETARY="zh_CN.UTF-8"
declare -x LC_NAME="zh_CN.UTF-8"
......
```

## 按分割符取最后一列

``` shell
# 花样取法
$ a='asfd/sd/xiecq'
$ echo ${a##*/}
xiecq
$ echo $a | grep -o '[^/]*$'
xiecq

# 稳重取法
$ a='asfd/sd/xiecq'
$ echo $a | awk -F '/' '{print $NF}'
xiecq

# cut 取法
$ a='asfd/sd/xiecq'
$ echo $a | rev | cut -d '/' -f 1 | rev
```

## 两种脚本识别参数套路

#### 一、用 shift 不断弹出 $1 获取参数

``` shell
function usage {
    echo "Download the Google docker image through the proxy node"
    echo
    echo "Usage: $0 [[[-p proxy] [-i image] | [-t tag] | [-f file]] | [-h]]"
    echo "  -p,--proxy      Specify proxy node url"
    echo "  -i,--image      Specify the image name"
    echo "  -t,--tag        Specify the image tag and download the k8s family bucket."
    echo "  -f,--file       Specify a file path containing the name"
    echo "  -h,--help       View help"
    echo
    echo
    echo "Example:"
    echo "  $0 gcr.io/google_containers/pause-amd64:3.1"
    echo "  $0 \"k8s.gcr.io/kube-{apiserver,controller-manager,proxy,scheduler}:v1.14.3\""
    echo "  $0 -i k8s.gcr.io/pause-amd64:3.1"
    echo "  $0 -p registry.aliyuncs.com/google_containers -i k8s.gcr.io/pause-amd64:3.1"
    echo "  $0 -t v1.14.3"
    echo "  $0 -f ./images.txt"
    echo
    exit 1
}


######################################################################################################
# main 
######################################################################################################

check

[ "$#" == "0" ] && usage

while [ "$1" != "" ]; do
    case $1 in
        -p | --proxy )          shift
                                unset proxy
                                proxy=$1
                                ;;
        -i | --image )          shift
				image_url=$1
                                ;;
        -t | --tag )            shift
				tag=$1
                                ;;
        -f | --file )           shift
				file=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        *\.* | *\/*)            image_url=$1
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done
```

#### 二、getopts 获取参数

``` shell
_usage() {
echo "Usage:"
echo "feishu.sh [-u repoUrl] [-b branch] [-d db] [-v version] [-c projectName] [-p productId] [-n name] [-h help]"
echo "Description:"
echo "-u, 必选-gitlab 仓库地址"
echo "-v, 必选-禅道版本号"
echo "-c, 必选-禅道项目名"
echo "-p, 必选-禅道产品 id"
echo "-n, 必选-创建人名"
echo "-b, 可选-分支名，默认为 master"
echo "-d, 可选-数据库名，默认为 mysql"
echo "-h / -help，选择-打印此帮助信息"
}

db=''

while getopts 'u:v:c:p:n:b:d:h' OPT
do
case $OPT in
u)
repoUrl="$OPTARG"
;;
b)
branch="$OPTARG"
;;
d)
db="$db $OPTARG"
;;
v)
version="$OPTARG"
;;
c)
projectName="$OPTARG"
echo "projectName: $projectName"
;;
p)
productId="$OPTARG"
;;
n)
name="$OPTARG"
;;
h)
_usage
exit 0
;;
?)
_usage
exit 0
;;
esac
done
```

## POSIX 常用字符集合

|    类型     |        匹配字符        |      |
| :---------: | :--------------------: | ---- |
| `[:space:]` | 空白 (whitespace) 字符 |      |
| `[:alnum:]` |          字母          |      |
| `[:lower:]` |        小写字母        |      |
| `[:upper:]` |        大写字母        |      |
| `[:digit:]` |          数字          |      |
|             |                        |      |

## 确保脚本下载完全

* 有些脚本会通过 `curl -SsL xxx.sh | bash` 调用，这时应该确保下载执行的脚本是完整的，可以通过将整个脚本内容放进 `{}` 内实现

```shell
#!/usr/bin/env bash

{ # this ensures the entire script is downloaded #
 ...
} # this ensures the entire script is downloaded #
```

## 根据某列排序

**`awk`**

``` shell
$ cat demo.txt
sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin
bin:x:1:1:bin:/bin:/sbin/nologin
adm:x:3:4:adm:/var/adm:/sbin/nologin
postfix:x:89:89::/var/spool/postfix:/sbin/nologin
chrony:x:998:996::/var/lib/chrony:/sbin/nologin
apache:x:48:48:Apache:/usr/share/httpd:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin
lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin
root:x:0:0:root:/root:/bin/bash
sync:x:5:0:sync:/sbin:/bin/sync

# 以 : 做为分隔符，按照第三列排序
$ cat a | awk -F ':' '{print $3,$0}' | sort | awk '{print $2}'
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/bin:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin
adm:x:3:4:adm:/var/adm:/sbin/nologin
apache:x:48:48:Apache:/usr/share/httpd:/sbin/nologin
lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin
sync:x:5:0:sync:/sbin:/bin/sync
sshd:x:74:74:Privilege-separated
postfix:x:89:89::/var/spool/postfix:/sbin/nologin
chrony:x:998:996::/var/lib/chrony:/sbin/nologin
```

**`sort`**

``` shell
$ cat demo.txt
sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin
bin:x:1:1:bin:/bin:/sbin/nologin
adm:x:3:4:adm:/var/adm:/sbin/nologin
postfix:x:89:89::/var/spool/postfix:/sbin/nologin
chrony:x:998:996::/var/lib/chrony:/sbin/nologin
apache:x:48:48:Apache:/usr/share/httpd:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin
lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin
root:x:0:0:root:/root:/bin/bash
sync:x:5:0:sync:/sbin:/bin/sync

# 以 : 做为分隔符，按照第三列排序
# -t 指定文本分隔符
# -k 指定排序列
# -n 按数字进行排序
# -r 从大到小排序
# -u 去重
$ sort -t ':' -k 3n
```

## 进入执行脚本所在文件夹

``` shell
$ cd `dirname $0`

$ BASEPATH=`dirname $(readlink -f ${BASH_SOURCE[0]})` && cd $BASEPATH
```

## 替换字符串方法

### 一、${}

``` shell
$ a='asdf'
$ a=${a/as/$a}
$ echo $a
asdfdf

$ echo ${a/hduser302/hdpusr400} 　　#变量a中的第一个匹配的字符串会被替换

$ echo ${a//hduser302/hdpusr400}　　#变量a中所有匹配的字符串都会被替换
```

### sed

``` shell
$ echo $a | sed 's/hduser302/hdpusr400/' 　　#sed 's///' 用来替换第一个匹配的字符串

$ echo $a | sed 's/hduser302/hdpusr400/g' 　　#sed 's///g'用来替换所有匹配的字符串
```

### awk

``` shell
$ echo $a | awk '{gsub(/hduser302/,"hdpusr400",$3);print $0}' #指定替换第一个

$ echo $a | awk '{gsub(/hduser302/,"hdpusr400");print $0}' 　　#全部替
```

##　删除空格

> **`[[:space:]]`** : POSIX 字符类 `[:space:]` 表示空白字符，把 `[:space:]` 放在 `[]` 里面，会成为正则表达式，表示匹配在 `[] `里面的字符

``` shell
# 删除字符串中空格
a=". "
echo ${a//[[:space:]]/}

# 删除首行空格
sed 's/^[ \t]*//g'

# 删除行末空格
sed 's/[ \t]*$//g'

# 删除所有空格	
sed s/[[:space:]]//g
```

## awk 获取第 n 列以后所有列

``` shell
# cat a
1 2 3 4
1 2 3 4
1 2 3 4
1 2 3 4
1 2 3 4
1 2 3 4
# cat a | awk '{$1="";print $0}'
 2 3 4
 2 3 4
 2 3 4
 2 3 4
 2 3 4
 2 3 4
或
# cat a | awk '{$1=null;print $0}'
 2 3 4
 2 3 4
 2 3 4
 2 3 4
 2 3 4
 2 3 4
或
# cat a | awk '{ for(i=1; i<=2; i++){ $i="" }; print $0 }'
  3 4
  3 4
  3 4
  3 4
  3 4
  3 4
```

## for 循环高级玩法

``` shell
#!/bin/bash
set i=0
set j=0
for((i=0;i<10;))
do
        let "j=j+1"
        echo "-------------j is $j -------------------"
done
```

## 从 1 到 n 的循环

**`for i in {1..100}`**

* `{1..100}` 这种循环无法使用变量，比如

``` shell
$ n=100
$ echo {1..$n}
{1..100}
```

**`seq 1 n`**

``` shell
n=100
for i in `seq 1 $n`
do
echo $i
done
```

## tar 去除顶层目录结构

``` shell
tar zxvf example.tar.gz -C /opt --strip-components 1
```

## getopts 获取命令参数

* 格式：**`getopts [option_string] [variable]`**

> * option_string 选项名称
> * variable 选项的值

* 选项之间使用冒号 `:` 分隔，也可以直接连接， `:`  表示选项后面有传值
* 当 getopts 命令发现冒号后，会从命令行该选项后读取该值。如该值存在，将保存在特殊的变量 OPTARG 中
* getopts 包含两个内置变量，OPTARG (保存选项后的参数值) 和 OPTIND (表示命令行下一个选项或参数的索引)

``` shell
while getopts a:b:c:d opts; do
    case $opts in
        a) a=$OPTARG ;;
        b) b=$OPTARG ;;
        c) c=$OPTARG ;;
        d) d=$OPTARG ;;
        ?) ;;
    esac
done

echo "a=$a"
echo "b=$b"
echo "c=$c"
echo "d=$d"


while getopts "f:d:icmk:?h" opt; do
	case $opt in
		f)
			flannel_env=$OPTARG
			;;
		d)
			docker_env=$OPTARG
			;;
		i)
			indiv_opts=true
			;;
		c)
			combined_opts=true
			;;
		m)
			ipmasq=false
			;;
		k)
			combined_opts_key=$OPTARG
			;;
		[\?h])
			usage
			;;
	esac
done
```

## csv 和 xlsx 文件格式互相转换

**`csv 转 xlsx`**

```shell
$ unix2dos example.csv
$ ssconvert example.csv example.xlsx
$ ssconvert example.csv example.xls
```

**`xlsx 转 csv`**

``` shell
$ ssconvert example.xlsx example.csv
```

## 判断字符串是否为空

``` shell
# 方法一
[ ".${a//[[:space:]]/}" = "" ] && echo 'a is empty'
# 方法二
[[ -n "${a//[[:space:]]/}" ]] && echo 'a is empty'
```

## 变量设置默认值

``` shell
SERVER_ARCH="${KUBERNETES_SERVER_ARCH:-amd64}"
```

## 判断 ip 是否合适

``` shell
function check_ip() {
    IP=$1
    if [[ $IP =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        FIELD1=$(echo $IP|cut -d. -f1)
        FIELD2=$(echo $IP|cut -d. -f2)
        FIELD3=$(echo $IP|cut -d. -f3)
        FIELD4=$(echo $IP|cut -d. -f4)
        if [ $FIELD1 -le 255 -a $FIELD2 -le 255 -a $FIELD3 -le 255 -a $FIELD4 -le 255 ]; then
            echo "IP $IP available."
        else
            echo "IP $IP 校验失败,请确认拿下你的IP格式是不是合法的!"
        fi
    else
        echo "IP format error!"
    fi
}
```

## 实现按任意键继续

``` shell
read -s -n1 -p "按任意键继续 ... "
```

## timeout - 设置命令超时

> 有时候，启动一个服务会占用很长时间，这就需要设置命令超时结束

```shell
# 设置 10 s 限制
$ timeout 10 systemctl start mysqld	
```

## grep 默认模糊匹配的坑

```shell
$ ls
a
a.txt
a.sh
b
$ ls | grep a
a
a.txt
a.sh
```

* 从上面可以看出 grep 默认是模糊匹配的，所以当需要使用精确匹配的时候就需要注意，比如使用 `-v` 剔除某一个文件就需要使用 `-w` 精确剔除


## 使用 iptables 做端口转发

``` shell
# 默认为8443（HTTPS）和8080（HTTP），改成 443 和 80
iptables -A PREROUTING -t nat -p tcp --dport 443 -j REDIRECT --to-ports 8443
iptables -A PREROUTING -t nat -p tcp --dport 80 -j REDIRECT --to-ports 8080
```


## 查找字符串所在行并输出行号

``` shell
# 输出内容同时输出行号 - 模糊匹配
grep -n "要匹配的字符串" 文件名

# 输出行号，并不输出内容 - 模糊匹配
# 注意是单引号
awk '/要匹配字符串/{print NR}' 文件名

# 在awk中引入变量, 打印变量所在的行
awk '/"'${word}'"/{print $0}' file.txt
# 其中${word}是变量较好的写法，$word 的写法也可以执行

## 精确匹配（全匹配）输出行号
grep -wn "要匹配的字符串" 文件名
```

## 如何在 awk 中写变量

> 比如“要匹配字符串”位置想要写入一个变量，要在变量外加单引号，再加双引号

``` shell
# 在 awk 中引入变量, 打印变量所在的行
awk '/"'${word}'"/{print $0}' file.txt

# 其中 ${word} 是变量较好的写法，$word 的写法也可以执行
```


## lshw 查看硬件信息

> * 可以查看系统硬件信息

``` shell
# 查看磁盘信息
$ lshw -C disk

$ 简短输出
$ lshw -short
```

## LANG 对正则表达式的影响

* 不同国家的字符编码很有可能不同，例如：
  * `LANG=C`：A B C D ... Z a b c d ...z
  * `LANG=zh_TW`：a A b B c C d D ... z Z
> 当采用第二种编码时，`[A-Z]` 之间会包括小写字母 `b-z`。为了避免这种问题，出现了特殊符号

``` shell
[:alnum:]  ：  即0-9,a-z,A-Z，英文大小写字符和数字
[:alpha:]   ：  即a-z,A-Z，任何英文大小写字符
[:digit:]      ：  即0-9，所有数字
[:upper:]   ：  即A-Z，所有大写字符
[:lower:]     :   即a-z,，所有小写字符
[:space:]   :  任何会产生空白的字符，包括空格，Tab和CR等
[:blank:]    :  空格和tab
[:cntrl:]     ： 键盘上的控制按键，包括C,LF,Tab,Del等
```
* 所以，Shell 中遇到需要使用正则表达式的命令，需要在最前面加上 `LANG=C`

```shell
LANG=C df -hPl | grep -wvE '\-|none|tmpfs|devtmpfs|by-uuid|chroot|Filesystem|udev|docker' | awk '{print $2}' )
LANG=C dd if=/dev/zero of=benchtest_$$ bs=64k count=16k conv=fdatasync && rm -f benchtest_$$
```

## 快速切出当前路径的目录名

``` shell
$ basename `pwd`
```

## 计算脚本执行时间

``` shell
# 方法一、记录开始结束时间，作差
START_TIME=$(($(date +%s%N)/1000000))
......
function print_time() {
  END_TIME=$(($(date +%s%N)/1000000))
  ELAPSED_TIME=$(echo "scale=3; ($END_TIME - $START_TIME) / 1000" | bc -l)
  MESSAGE="Took ${ELAPSED_TIME} seconds"
}
# 方法二、使用 time
time bash xxx.sh
```

## if 条件判断的坑
> Shell 的条件判断一直用的是 `if then ... else ... fi`，之前没遇到需要多加判断分支的情况，所以一直没遇到这个小坑: **`elif` 后天需要加 `then`**

``` shell
if [ $year -eq 2020 ]
then
echo 'Happy 2020 Year!'
elif [ $year -eq 2021 ]
then
echo 'Happy Next Year!'
else
echo 'Day Day Happy!'
fi
```

## 打印主机ip

``` shell
# hostname -I
192.168.7.12 172.17.0.1

# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: ens192: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether 00:0c:29:70:19:ed brd ff:ff:ff:ff:ff:ff
    inet 192.168.7.12/19 brd 192.168.31.255 scope global noprefixroute dynamic ens192
       valid_lft 25955sec preferred_lft 25955sec
    inet6 fe80::e6c4:2316:88fe:9d85/64 scope link noprefixroute
       valid_lft forever preferred_lft forever
3: docker0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether 02:42:f4:62:f5:a4 brd ff:ff:ff:ff:ff:ff
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
       valid_lft forever preferred_lft forever
    inet6 fe80::42:f4ff:fe62:f5a4/64 scope link
       valid_lft forever preferred_lft forever
33: veth03e6e07@if32: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master docker0 state UP group default
    link/ether 2a:2f:f6:08:96:9b brd ff:ff:ff:ff:ff:ff link-netnsid 1
    inet6 fe80::282f:f6ff:fe08:969b/64 scope link
       valid_lft forever preferred_lft forever
```

## 通过端口判断服务是否启动

* 以前判断服务是否启动都是使用 `ps aux | grep -v grep | grep xxx` 去且服务名，但有时不太准确。而通过切端口判断服务是否启动是一个很好的办法，但服务的端口一般可以改变，所以通过一下方法可以用 `端口` + `服务名` 双重判定服务是否启动

``` shell
# 判断 jenkins 是否启动，假设端口修改为 12345
jenkins_pid=`netstat -ntlp | grep :12345 | awk '{print $7}' | awk -F"/" '{ print $1 }'`
[ $jenkins_pid ] && echo 'jenkins 启动了'
```

## Shell常用调试方法

> * Maven - https://archive.apache.org/dist/maven/maven-3/
* 常用的三种 Shell 脚本调试方法：
1、执行脚本时候 - `bash -ex test.sh`
2、脚本开头中添加 - `set -ex`
3、使用 `bashdb` 工具，可以设置断点、按行执行等

* bashdb
``` shell
#下载软件
wget --no-check-certificate https://nchc.dl.sourceforge.net/project/bashdb/bashdb/4.2-0.92/bashdb-4.4-0.92.tar.gz

#第二步：解压并进入目录
tar -zxvf  4.4-0.92.tar.gz
cd  4.4-0.92
#第三步：配置及编译安装
./configure
make && make install

# bashdb --debug 脚本名
一、列出代码和查询代码类：
l  列出当前行以下的10行
-  列出正在执行的代码行的前面10行
.  回到正在执行的代码行
/pat/ 向后搜索pat
？pat？向前搜索pat
二、Debug控制类：
h     帮助
help  命令 得到命令的具体信息 q     退出bashdb x     算数表达式 计算算数表达式的值，并显示出来 !!    空格Shell命令 参数 执行shell命令 使用bashdb进行debug的常用命令(cont.) 三、控制脚本执行类：
n   执行下一条语句，遇到函数，不进入函数里面执行，将函数当作黑盒
s n 单步执行n次，遇到函数进入函数里面
b   行号n 在行号n处设置断点
del 行号n 撤销行号n处的断点
c   行号n 一直执行到行号n处
R   重新启动当前调试脚本
Finish 执行到程序最后
cond n expr 条件断点
```

## tar zxvf 的坑

执行 `tar zxvf test.tar.gz -C /opt/`，如果 `/opt/` 下已经有 test.tar.gz 解压后的内容（比如解压后是 test 目录），在未删除直接执行解压命令，则只会覆盖 `test.tar.gz` 解压出来的相同文件，最好是提前判断解压路径下有无 test 目录，有的话提前删除


## 变量替换

* 变量替换可以根据变量的状态（是否为空、是否定义等）来改变它的值


| 形式 | 说明 |
| --- | --- |
| `${var}` | 变量本来的值 |
| `${var:-word}` | 如果变量 var 为空或已被删除(unset)，那么返回 word，但不改变 var 的值 |
| `${var:=word}` | 如果变量 var 为空或已被删除(unset)，那么返回 word，并将 var 的值设置为 word |
| `${var:?message}` | 如果变量 var 为空或已被删除(unset)，那么将消息 message  送到标准错误输出，可以用来检测变量 var 是否可以被正常赋值，若此替换出现在Shell脚本中，那么脚本将停止运行 |
| `${var:+word}` | 如果变量 var 被定义，那么返回 word，但不改变 var 的值 |
| `${value:offset}` 或 `${value:offset:length}` |  从变量中提取子串，这里 offset 和 length 可以是算术表达式 |
| `${#value}` | 变量的字符个数 (变量的字符个数，并不是变量个数） |
| `${value#pattern}` 或 `${value##pattern}` | 去掉 `value` 中与 `pattern` 相匹配的部分,条件是 `value` 的开头与 `pattern` 相匹配。#与##的区别：`#`是最短匹配模式，而`##`是最长匹配模式 |
| `${value％pattern}` 或 `${value％％pattern}` | 去掉 `value` 中与 `pattern` 相匹配的部分,条件是从 `value` 的尾部于 `pattern` 相匹配,`%`与`%%`的区别：`%`是最短匹配模式,而`%%`是最长匹配模式 |
| `${value/pattern/string}` 或 `${value//pattern/string}` | 进行变量内容的替换,把与 `pattern` 匹配的部分替换为 `string` 的内容,`/` 和 `//` 的区别：`/` 是只替换第一个，而 `//` 替换所有的 |
| `${var/#pattern/string}` 或 `${var/%pattern/string}` | 进行变量内容的替换,把与 `pattern` 匹配的部分替换为 `string` 的内容，`%` 和 `#` 的区别是：`#` 是从前面开始匹配，`%` 是从后面开始匹配 |
|  |  |

## shift

* shift 命令用于对脚本传入参数的移动(左移)，通常用于在不知道传入参数个数的情况下依次遍历每个参数然后进行相应处理（常见于Linux中各种程序的启动脚本）

`**run.sh**`
``` shell
#!/bin/bash
while [ $# != 0 ]
do
echo "第一个参数为：$1,参数个数为：$#"
shift
done
```

## nohup 和 & 区别

* 使用 nohup 运行程序
  * 结果默认会输出到 nohup.out
  * 使用 `Ctrl + C` 发送 SIGINT 信号，程序关闭
  *  关闭 session 发送 SIGHUP 信号，程序免疫
* 使用 & 后台运行程序
  * 结果会输出到终端
  * 使用 Ctrl + C 发送 SIGINT 信号，程序免疫
  * 关闭 session 发送 SIGHUP 信号，程序关闭

## 数组

* Bash Shell 只支持一维数组（不支持多维数组），初始化时不需要定义数组大小
* 数组元素的下标由 0 开始，使用括号表示一个数组，数组元素用"空格"符号分割开
* 数组元素可以是：字符串、数字等
* 读取数组格式：**`${array_name[index]}`**

``` shell
$ my_array=(1 "1" "C" D)
$ for i in ${my_array[*]};do echo $i;done  
1
1
C
D
```

## 命令后台运行

1、支持后台运行，但是关闭终端的话，程序也会停止。使用 `jobs -l` 查看和使用 `fg` 命令将后台运行调到前台运行

``` shell
$ [command] &
```

2、支持后台运行，关闭终端后，程序也会继续运行。使用 `jobs` 命令查看不到，需要使用 `ps aux | grep -v grep | grep [command]` 查看

``` shell
$ nohup [command] &
```

## while read line 和 for

* while read line 是一次性将文件的一行读入并赋值给变量 line ，while 中使用重定向机制,文件中的所有信息都被读入并重定向给了整个 while 语句中的 line 变量
``` shell
# 从文件读取
while read line
do
command
done < [文件]

# 从命令输出读取
command1 | while read line
do
command2
done
```
* for 是每次读取文件中一个以空格为分割符的字符串

## rpm 离线安装步骤

> Linux 离线部署一般采用 docker 或 rpm 包安装

* yum 只下载不安装软件 rpm 包

``` shell
# 下载 vim 所有 rpm 包到当前目录下的 vim 文件夹 
$ yum install --downloadonly --downloaddir=./ vim
```

* 检测是否还有遗漏的依赖 rpm

``` shell
$ yum -ivh ./*.rpm
```

## 使用 set 调试 shell 脚本

> **参考**：http://www.ruanyifeng.com/blog/2017/11/bash-set.html

**`set -u` 或 `set -o nounset`** - 遇到不存在的变量就会报错，并停止执行
* 默认遇到不存在的变量，Bash 忽略它。使用 `set -u`，

**`set -x` 或 `set -o xtrace`** - 在运行结果之前，先输出执行的那一行命令
* 默认情况下，脚本执行后，屏幕只显示运行结果，没有其他内容。如果多个命令连续执行，它们的运行结果就会连续输出。有时会分不清，某一段内容是什么命令产生的

**`set -e` 或 `set -o errexit`** - 脚本只要发生错误，就终止执行
* 如果脚本里面有运行失败的命令（返回值非0），Bash 默认会继续执行后面的命令
* `set -e` 根据返回值来判断，一个命令是否运行失败。但是，某些命令的非零返回值可能不表示失败，或者开发者希望在命令失败的情况下，脚本继续执行下去。这时可以暂时关闭 `set -e`，该命令执行结束后，再重新打开 `set -e`
``` shell
# set +e 表示关闭 -e 选项，set -e 表示重新打开 -e 选项
set +e
command1
command2
set -e
```
* 不管有没有设置 `set -e`，手动确保命令执行失败退出或继续执行
```shell
# 命令失败则一定退出
command || echo "fail!";exit 1
# 命令失败也一定继续执行
command || true
```

**set -o pipefail** - 只要管道中一个子命令失败，整个管道命令就失败，脚本就会终止执行
``` shell
$ cat script.sh
#!/usr/bin/env bash
set -eo pipefail
foo | echo a
echo bar
$ bash script.sh
a
script.sh:行4: foo: 未找到命令
```
* `set -e` 不适用于管道命令。Bash 会把管道最后一个子命令的返回值，作为整个命令的返回值。也就是说，只要最后一个子命令不失败，管道命令总是会执行成功，因此它后面命令依然会执行，`set -e` 就失效了
```shell
# 管道连接多个 command，$? 是最后一个 command 的返回值
$ hello | echo "hello"
hello
-bash: hello: 未找到命令
$ echo $?
0
```

**以上四个参数汇总** 

```shell
# 方法一
set -euxo pipefail

# 方法二
set -eux
set -o pipefail

# 方法三，执行脚本时传入
$ bash -euxo pipefail script.sh
```

## Shell 中的单引号和双引号区别

> **参考**：https://blog.csdn.net/fdl19881/article/details/7849286

**结论**：单引号和双引号都能关闭 shell 对特殊字符的处理。不同的是，双引号没有单引号严格，单引号关闭所有有特殊作用的字符，而双引号只要求 shell 忽略大多数。具体的说，双引号保留对**美元符号、反引号、反斜杠**的特殊解析。所以，在 sed 中需要引用变量则必须使用双引号；而 awk 中 `'{print $0}'` 的 `$0` 不是引用 shell 的 `$0`（即不是由 shell 解析），而是由 awk 程序解析

在 shell 终端输入一行命令然后按下 enter，这时 shell 会以进程方式执行提交的命令，而对于命令行中字符的解析，shell 有不同的方法：

简而言之，命令行的的字符都可按如下两种分类：
* **literal**：就是普通字符串，没有特殊意义，例如 abcd、123456 等等
* **meta**：具有特定功能的保留元字符
  * **IFS**：由 <space> <tab> <enter> 三者之一组成
  * **CR**：由 <enter> 产生
  * **=**：设定变量
  * **$**：做变量或运算替换(请不要与 shell prompt 搞混了)
  * **>**：重定向 stdout
  * **<**：重定向 stdin
  * **|**：管道命令
  * **&**：重定向 file descriptor ，或将命令置于后台执行
  * **( )**：將其內的命令置于 nested subshell 执行，或用于运算或命令替换
  * **{ }**：將其內的命令置于 non-named function 中执行，或用在变量替换的界定范围
  * **;**：在前一个命令结束时，而忽略其返回值，继续执行下一個命令
  * **&&**：在前一個命令结束时，若返回值为 true，继续执行下一個命令
  * **||**：在前一個命令结束时，若返回值为 false，继续执行下一個命令
  * **!**：执行 history 列表中的命令
meta 往往具有多重意义，比如 `$` 有时需要作为单纯的美元符号，但有时需要作为 `$变量` 使用。在 shell 中，是通过 quoting 开启和关闭 meta 功能，常用 quoting 有一下三种方法：
* **hard quote**：`''`（单引号），凡在 hard quote 中的所有 meta 均被关闭
* **soft quote**：`""`（双引号），在 soft quote 中的大部分 meta 都会被关闭，但某些保留（如 $ ）
* **escape**：`\` （反斜线），只有紧接在 escape（跳脱字符）之后的单一 meta 才被关闭

## exit 退出值

0 表示正常，1 表示发生错误，2 表示用法不对，126 表示不是可执行脚本，127 表示命令没有发现。如果脚本被信号 N 终止，则退出值为 128 + N。简单来说，只要退出值非 0，就认为执行出错。

``` bash
$ ls 参数 || echo $?
ls: 无法访问'参数': 没有那个文件或目录
2

$ ./README.md || echo $?
bash: ./README.md: 权限不够
126

$ 命令 || echo $?
命令：未找到命令
127
```

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

### `$*` 和  `$@` 区别
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

## 重定向到空

> 解释：无提示（包括 stdin 和 stderr ）执行

![](./images/shell_wj.jpg)

**`文件描述符`**

 * 文件描述符是与文件输入、输出关联的整数。它们用来跟踪已打开的文件
 * 最常见的文件描述符是 stidin、stdout、和 stderr
  * 0 —— stdin（标准输入）
  * 1 —— stdout （标准输出）
  * 2 —— stderr （标准错误）
  
 * 我们可以将某个文件描述符的内容重定向到另外一个文件描述符中

![](./images/shell_stdout.jpg)

![](./images/shell_stderr.jpg)

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
echo "scale=3; 1/12" | bc
# 0.083
echo "1 12" | awk '{printf("%0.3f\n",$1/$2)}'
# 0.083
```

 ## 数值进制间相互转换

```  shell
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

 ## 条件判断中的各种括号

> * [Shell十三问](http://bbs.chinaunix.net/forum.php?mod=viewthread&tid=218853&page=7#pid1617953)
> * [完全总结bash中的条件判断test](https://www.cnblogs.com/zejin2008/p/8412680.html)

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

## 字符串写入文件

**`cat`**

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

**`echo`**

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

**`kill [信号] [进程号]`**

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

* **`进程 -> 端口`**

1、`sudo netstat -tlpn | grep nginx`

2、`sudo ss -tlpn | grep nginx`

3、`sudo netstat -nap | grep <pid>`

* **`端口 -> 进程`**

1、`lsof -i:<port>`

2、`sudo netstat -nap | grep <port>`

## 查看其他主机开放的端口

**`sudo nmap -sS <ip>`**

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

