# 平时 linux 遇到的问题解决办法和扩展小知识
## 目录

* [CentOS net-tools 软件包详解](#centos-net-tools-软件包详解)
* [CentOS 7.6图形化界面中文显示乱码的问题](#centos-7.6图形化界面中文显示乱码的问题)
* [解决远程链接的`Gtk-WARNING **: cannot open display`或`Cannot connect to display`问题](#解决远程链接的gtk-warning-**-cannot-open-display或cannot connect-to-display问题)
* [pushd、popd 切换目录](#pushdpopd-切换目录-top)
* [/etc/motd ssh 登陆后欢迎界面](#etcmotd-ssh-登陆后欢迎界面-top)
* [端口、进程名、进程号互查](#端口进程名进程号互查-top)
* [Linux adduser 与 useradd 区别](#linux-adduser-与-useradd-区别-top)
* [使用 wget 提示无法建立SSL连接](#使用-wget-提示无法建立ssl连接-top)
* [通过编译安装软件时：[Error]运行时找不到.so文件](#通过编译安装软件时error运行时找不到so文件-top)
* [更换 Ubuntu 18.04 LTS 登录界面背景](#更换-ubuntu-1804-lts-登录界面背景-top)
* [执行 make 命令时提示“makefile:2: *** 遗漏分隔符 停止”](#执行-make-命令时提示-makefile2--遗漏分隔符-停止-top)
* [Linux 下 gcc 编译 c 源文件过程详解](#linux-下-gcc-编译-c-源文件过程详解-top)
* [创建启动器（.Desktop文件)](#创建启动器desktop文件-top)
* [浅谈 /etc/skel 文件夹](#浅谈-etcskel-文件夹-top)
* [apt、wget、curl 设置代理端口](#aptwgetcurl-设置代理端口-top)
* [shell、终端、终端模拟器](#shell终端终端模拟器-top)
* [Ubuntu 彻底关闭 dash](#ubuntu-彻底关闭-dash-top)
* [sudo apt update显示：鉴于仓库 'xxx' 不支持 'i386' 体系结构，跳过配置文件 'xx' 的获取](#sudo-apt-update-提示异常信息-top)
* [Linux 中使用 crontab 命令启用自定义定时任务](#linux-中使用-crontab-命令启用自定义定时任务-top)
* [Linux 添加环境变量 $PATH](#linux-添加环境变量-path-top)
* [Linux 手动添加字体文件](#linux-手动添加字体文件-top)
* [`#!/usr/bin/env` 与 `#!/usr/bin`区别](#usrbinenv-与-usrbin区别-top)
* [永久修改 DNS](#永久修改-dns-top)
* [Linux程序存放目录](#Linux程序存放目录-top)
* [更换镜像源](#更换镜像源-top)
* [诊断某文件无法修改](#诊断某文件无法修改-top)
* [Linux terminal 快捷键](#linux-terminal-快捷键-top)
* [通过 PID 查看进程完整信息](#通过-pid-查看进程完整信息-top)
* [文件权限 777](#文件权限-777-top)
* [/tmp 目录自动清理](#tmp-目录自动清理-top)
* [修改时区](#修改时区-top)

## CentOS net-tools 软件包详解

* net-tools 包里有 ifconfig、netstat、whois 等命令
* CentOS 7 默认没有安装该软件包，`yum intall -y net-tools` 安装


## centos 7.6图形化界面中文显示乱码的问题

https://blog.csdn.net/linxue110/article/details/85293022

## 解决远程链接的`Gtk-WARNING **: cannot open display;`或`Cannot connect to display;`问题 [[Top]](#目录)

## pushd、popd 切换目录 [[Top]](#目录)

* 使用 cd 切换目录经常想回到之前的目录，但 `cd -` 只能回到上一个目录，使用 pushd、popd 可以以目录堆栈的方式(FILO，先进后出)前进后退切换目录，结合 dirs 查看堆栈内容（最左边的是栈顶），十分方便！
``` shell
$ pushd ~/桌面/WORK
~/桌面/WORK ~/桌面/codeLearn/Shell/kjyw/redis
xcq@xcq:~/桌面/WORK$ pushd ~/桌面/codeLearn/git/github/
~/桌面/codeLearn/git/github ~/桌面/WORK ~/桌面/codeLearn/Shell/kjyw/redis
xcq@xcq:~/桌面/codeLearn/git/github$ dirs
~/桌面/codeLearn/git/github ~/桌面/WORK ~/桌面/codeLearn/Shell/kjyw/redis
xcq@xcq:~/桌面/codeLearn/git/github$ popd
~/桌面/WORK ~/桌面/codeLearn/Shell/kjyw/redis
xcq@xcq:~/桌面/WORK$ popd
~/桌面/codeLearn/Shell/kjyw/redis
xcq@xcq:~/桌面/codeLearn/Shell/kjyw/redis$ dirs
~/桌面/codeLearn/Shell/kjyw/redis
```


## `/etc/motd` ssh 登陆后欢迎界面 [[Top]](#目录)

> * 通过修改 `/etc/motd` 文件可以自定义 ssh 登录欢迎界面
> * [常用终端 ASCII 码图](https://blog.csdn.net/whatday/article/details/106002578)
> * [在线图片转 ASCII 码网站](http://www.makepic.net/Tool/Image2ascii.html)

* aliyun 登录后界面
``` shell
$ ssh root@aliyun
Welcome to Ubuntu 18.04.4 LTS (GNU/Linux 4.15.0-48-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

 * "If you've been waiting for the perfect Kubernetes dev solution for
   macOS, the wait is over. Learn how to install Microk8s on macOS."

   https://www.techrepublic.com/article/how-to-install-microk8s-on-macos/

 * Canonical Livepatch is available for installation.
   - Reduce system reboots and improve kernel security. Activate at:
     https://ubuntu.com/livepatch

Welcome to Alibaba Cloud Elastic Compute Service !

Last login: Fri Jul  3 23:03:28 2020 from 218.82.189.64
root@xcq:~#
```

## Port、PName、PID互查 [[Top]](#目录)

**Port** -> **PID**

``` shell
netstat -nlp | grep [Port]

```

**PID** -> **Port**

``` shell
nestat -nltp | grep [PID]
```


**PName** -> **PID**

``` shell
ps aux | grep [PName]
```

**PID** -> **PName**



**** -> ****


## Linux adduser 与 useradd 区别 [[Top]](#目录)

### 一、Debian 或 Ubuntu 

>  主要的区别在使用方式上

#### adduser

> `adduser` 是一个 perl 脚本，通过交互式菜单设定一些用户参数。在输入`adduser 用户名` 后，会自动创建用户主目录（并复制 `/etc/skel` 目录下的文件）、指定系统 shell，提示输入用户密码，很简单的就添加了一个标准的普通用户

``` shell
# 添加用户，会在目录（/home/）增加对应用户家目录
$ adduser au
adduser：只有 root 才能将用户或组添加到系统。
$ sudo adduser au
[sudo] xcq 的密码： 
正在添加用户"au"...
正在添加新组"au" (1001)...
正在添加新用户"au" (1001) 到组"au"...
创建主目录"/home/au"...
正在从"/etc/skel"复制文件...
输入新的 UNIX 密码： 
重新输入新的 UNIX 密码： 
passwd：已成功更新密码
正在改变 au 的用户信息
请输入新值，或直接敲回车键以使用默认值
	全名 []: 
	房间号码 []: 
	工作电话 []: 
	家庭电话 []: 
	其它 []: 
这些信息是否正确？ [Y/n] y
```

#### useradd

> `useradd`是一个指令，如果不使用任何选项，创建的用户将无密码、无主目录、没有指定 shell。如果你需要正常使用这个账户，就还需要设置密码、创建家目录等额外操作

* 对于 `useradd` 添加标准的普通用户有**使用选项**和**不使用选项**两种方式

**使用选项**

``` shell	
# 添加用户 ua，输入命令添加用户、添加用户目录、指定 bash 为 shell
$ useradd -m -s /bin/bash ua
# -m 自动创建用户的家目录，并将/etc/skel中的文件复制到家目录中
# -s 指定用户登入后所使用的 shell

# 然后对该用户设置密码
$ passwd ua
```

**不使用选项**

> 在不使用选项的情况下，添加一个标准普的通用户的过程相总共有 6 个步骤，略显麻烦，也没必要这样操作。但可以从中了解添加一个用户具体做了哪些事情，对解决一些问题有参考价值。

1、以添加用户名为`ua` 的用户为例子，输入命令添加用户

```shell
$ useradd ua
```

2、设置密码

```shell
$ passwd ua
```

3、创建家目录

```shell
$ mkdir /home/ua
```

4、将`/etc/skel`目录下的文件复制到该用户目录

```shell
$ cp -r /etc/skel/. /home/ua
```

5、更改家目录归属

```shell
$ chown -R ua:ua /home/ua
```

6、指定 Shell 为`/bin/bash`

```shell
$ usermod -s /bin/bash ua
```

### 二、Cen­tOS

> 两者没有区别

* adduser` 通过符号链接指向 `useradd`，即 Cen­tOS 只有 `useradd

### 三、删除用户

如果因为错误的方式添加了用户，而不知道如何解决，可以删除这个用户

以删除 au 这个用户为例子，首先终结该用户所有进程

```shell
$ pkill -u au
```

然后输入删除命令

```shell
$ userdel -r au
```

> `-r` 表示删除用户的同时，将其宿主目录和系统内与其相关的内容删除


## 使用 wget 提示无法建立SSL连接 [[Top]](#目录)

``` shell
[root@localhost ~]# wget https://www.kernel.org/pub/software/scm/git/git-2.0.5.tar.gz
--2018-03-22 01:43:37--  https://www.kernel.org/pub/software/scm/git/git-2.0.5.tar.gz
Resolving www.kernel.org... 147.75.42.139, 2604:1380:40a0:500::1
Connecting to www.kernel.org|147.75.42.139|:443... connected.
ERROR: certificate common name “kernel.org” doesn’t match requested host name “www.kernel.org”.
To connect to www.kernel.org insecurely, use ‘--no-check-certificate’.
```
> 这是因为 wget 在使用 HTTPS 协议时，默认会去验证网站的证书，而这个证书验证经常会失败，加上 "--no-check-certificate" 选项，就能排除掉这个错误

## 通过编译安装软件时：[Error]运行时找不到.so文件 [[Top]](#目录)

* 在 linux 下，.so 文件相当与 windows 上的 dll 文件，即动态链接库
* 在 Linux 下面，共享库(*.so) 的寻找和加载是由 /lib/ld.so 实现的
     * ld.so 会在标准路经 /lib，/usr/lib 中寻找应用程序用到的共享库
     * ld.so 也会在存有非标准路径的文件夹 /etc/ld.so.conf.ld 寻找应用程序用到的共享库
* 动态链接库是为了减少发布程序的大小，可以将具有相同功能的代码模块放在动态链接库中，随应用程序一起发布；而对于应用程序来说，只需要知道其接口就可以，在运行时动态的加载代码到内存中

``` shell
./SystemArchitect: error while loading shared libraries: libqt.so.3: cannot open shared object file:
No such file or directory
```
原因：链接器 ld 提示找不到库文件

### /etc/ld.so.conf 文件和 /etc/ld.so.conf.d/ 文件夹

* Linux 中 ld 的默认目录为 /lib 和 /usr/lib，扩展库路径目录都存储在 /etc/ld.so.conf 文件里，而 /etc/ld.so.conf 的文件内容是``` include /etc/ld.so.conf.d/*.conf```，所以在 /etc/ld.so.conf.d 目录下，加入任何以 .conf 为后缀的文件，都能被 ld 链接器识别

<div align=center>
  <img src="./images/ld.so.conf文件.jpg"><br/>/etc/ld.so.conf 文件
 </div>

 <div align=center>
  <img src="./images/ld.so.conf.d文件夹.jpg"><br/>/etc/ld.so.conf.d/文件夹
 </div>

### 查看某个库是否安装
``` shell
# 查看 libqt.so 是否安装
ldconfig -p | grep qt
ldconfig -p | grep qt
# ldconfig -p: 打印当前缓存所保存的所有库的名字
# grep qt/libqt: 用管道符解析 libqt.so 是否已加入缓存中
# qt 会打印所有 *qt.so.* 库文件信息，可以联想搜索；libqt 只会搜索 libqt.so.* 是否安装，若不存在不会返回显示
```

* ldconfig 是一个动态链接库管理命令，其目的为了让动态链接库为系统所共享
* ldconfig 默认搜寻/lib 和 /usr/lib 以及动态库配置文件 /etc/ld.so.conf 内所列的目录下的库文件
* ldconfig 会搜索出所有库，进而创建动态装入程序(ld.so)所需的连接和产生缓存文件 /etc/ld.so.cache（该文件保存已排好序的动态链接库名字列表）
* ldconfig 通常在系统启动时运行，而当用户安装了一个新的动态链接库时，就需要手工运行这个命令

### 新增库文件（.so文件）方法

* 若库文件已经在 /lib 和 /usr/lib 里面，是不用修改 /etc/ld.so.conf 文件的，但是添加完后需要调用下 ldconfig，不然添加的 library 会找不到
* .so 文件不在 /lib 和 /usr/lib 里，新增库路径方法
    * 直接在 /etc/ld.so.conf 文件中后续添加
    * 将库文件路径写入 /etc/ld.so.conf.d/ 文件夹中的 .conf 文件中
    * 在 /etc/ld.so.conf.d/ 文件夹中添加新的 .conf 文件
* 如果添加的库不在 /lib 或 /usr/lib 下，但是却没有权限操作写 /etc/ld.so.conf 文件的话，这时就需要往 export 里写一个全局变量```LD_LIBRARY_PATH```就可以了
> ld.so.cache 的更新是递增式的，就像 PATH 系统环境变量一样，不是从头重新建立，而是向上累加，只有重新开机，系统才从零开始建立 ld.so.cache 文件。所以每次修改 /etc/ld.so.conf 文件或 /etc/ld.so.conf.d/ 文件夹都要执行一次命令：`ldconfig`

## 更换 Ubuntu 18.04 LTS 登录界面背景 [[Top]](#目录)

<div align=center>
  <img src="./images/登录界面.png"><br/>Ubuntu 18.04 LTS 默认登录界面
</div>

### 修改 /usr/share/gnome-shell/theme/ubuntu.css 或 /usr/share/gnome-shell/theme/gdm3.css 文件

> * Ubuntu 18.04 用的 Gnome 的桌面，和以前 Unity 桌面配置方式不同，所以 16.04 及以前版本修改方法与此不同
> * ubuntu.css 和 gdm3.css 内容相同，只需修改其一即可

修改该文件第 1814 行左右（#lockDialogGroup)：
修改前：
``` css
#lockDialogGroup {
  background: #2c001e url(resource:///org/gnome/shell/theme/noise-texture.png);
  background-repeat: repeat; }
```
修改后：
``` css
#lockDialogGroup {
  background: #2c001e url(file:///usr/share/gnome-shell/theme/denglubeijing.jpg);
  background-repeat: no-repeat;
  background-size: cover;
  background-position: center;
   }
```

> 这种方法在执行系统更新 -`sudo apt upgrade` 后可能以上修改的文件也被更新，再次登录时会发现又变回原来黑界面，所以还需要手动按照以上步骤修改才行

## 执行 make 命令时提示 “makefile:2: *** 遗漏分隔符 停止" [[Top]](#目录)

> 分析原因：gcc、rm、cp 前面是 tab 分割符，不能用空格，make 中规定每一 Shell 命令之前的开头必须使用字符

``` shell
# makefile 文件部分示例
all:
    gcc -o helloworld helloworld.c
fresh:
    rm -rf Makefile
clean:
    rm -rf helloworld helloworld.o
install:
    cp helloworld /usr/bin
uninstall:
    rm -rf /usr/bin/helloworld
```

## Linux 下 gcc 编译 c 源文件过程详解 [[Top]](#目录)

<div align=center>
    <img src="./images/gcc.png" /><br/>gcc 编译过程图
</div>


<div align=center>
    <img src="./images/gcc过程.png" /><br/>gcc 编译过程文件变化图
</div>

* Linux 下与 C 语言有关的文件类型
    * .c - 源代码文件
    * .h - C语言头文件
    * .i - 经过预处理之后的源代码文件
    * .s - 汇编代码文件
    * .o - 目标代码文件（二进制机器指令文件）
    * .a - 静态对象库文件
    * .so - 共享（动态）对象库文件

<div align=center>
    <img src="./images/test.c.jpg" width="75%" heigth="75%" /><br/>test.c 源文件
</div>

### 预编译（预处理 - Preprocessing） - ``` gcc -E test.c -o test.i```

<div align=center>
    <img src="./images/test.i.jpg" width="75%" heigth="75%" /><br/>test.i 源文件预处理生成的文件
</div>

### 编译（Compilation） - ``` gcc -S test.i -o test.s```

<div align=center>
    <img src="./images/test.s.jpg" width="75%" heigth="75%" /><br/>test.s 经编译生成的汇编文件
</div>

> 此阶段会检查代码逻辑，若出现错误会中断编译提示

<div align=center>
    <img src="./images/编译出错.jpg" width="75%" heigth="75%" /><br/>test.s 编译出错中断提示
</div>


### 汇编(Assembly) - ``` gcc -c test.s -o test.o```

<div align=center>
    <img src="./images/test.o.jpg" width="75%" heigth="75%" /><br/>test.o 由汇编文件生成的二进制文件
</div>

### 链接(Linking) - ```gcc test.o test```

<div align=center>
    <img src="./images/test.jpg" width="75%" heigth="75%" /><br/>test 链接后生成的可执行文件
</div>

### 多个 c 源文件生成一个可执行文件
方法一、
``` shell
gcc test1.c test2.c -o test
```
方法二、
``` shell
gcc -c test1.c -o test1.o
gcc -c test2.c -o test2.o
gcc test1.o test2.o -o test
```

> 第一种方法编译时需要所有文件重新编译，而第二种方法可以只重新编译修改的文件，未修改的文件不用重新编译

### [补充参考]
[gcc 编译过程详解](http://www.cnblogs.com/ggjucheng/archive/2011/12/14/2287738.html#_Toc311642851)

## 创建启动器（.Desktop文件) [[Top]](#目录)

* 在 Linux 中，一个 .desktop 文件就是一个用来运行程序的快捷方式，没有此文件，你的应用就不会在应用菜单中显示。例如从源代码中编译的程序或者自己下载的压缩格式的应用，每次都需要打开终端来执行它的二进制文件
* desktop 文件路径：
    * 仅对当前用户可见：`~/.local/share/applications`
    * 所有用户可见：`/usr/share/applications/`

### desktop 文件创建
``` shell
$ touch test.desktop
```
### test.desktop 文件内容
``` shell
[Desktop Entry]
Encoding=UTF-8
Name=IntelliJ IDEA
GenericName=IntelliJ IDEA
Comment=The Java IDE for Professional Developers by JetBrains
Exec=/opt/SoftWare/idea-IU-172.4343.14/bin/idea.sh %f
Icon=/opt/SoftWare/idea-IU-172.4343.14/bin/idea.png
Terminal=false
Type=Application
Categories=Application;Programme;

语法解释：
关键词                         意义
[Desktop Entry]               文件头
Encoding                      编码
Name                          应用名称
Name[xx]                      不同语言的应用名称
GenericName                   描述
Comment                       注释
Exec                          执行的命令
Icon                          图标路径
Terminal                      是否使用终端
Type                          启动器类型
Categories                    应用的类型（内容相关）
说明： 
其中 Exec 常用的参数有：%f %F %u %U 
%f：单个文件名，即使选择了多个文件。如果已选择的文件不在本地文件系统中（比如说在HTTP或者FTP上），这个文件将被作为一个临时文件复制到本地，％f将指向本地临时文件； 
%F：文件列表。用于程序可以同时打开多个本地文件。每个文件以分割段的方式传递给执行程序。 
%u：单个URL。本地文件以文件URL或文件路径的方式传递。 
%U：URL列表。每个URL以分割段的方式传递给执行程序。本地文件以文件URL或文件路径的方式传递
```
### 修改权限:
``` shell
$ chmod 755 test.desktop
```
## 浅谈 /etc/skel 文件夹 [[Top]](#目录)

* skel 是 skeleton 的缩写，每当你新建一个用户的时候 (通过 useradd 命令)，/etc/skel 目录下的文件，都会原封不动的复制到新建用户的家目录下（~/）

<div align=center>
    <img src="./images/skel文件.jpg" width="75%" heigth="75%" /><br/>skel 目录
</div>

* 如果你是一个多用户系统的管理员，你可以在 skel 目录下写个 ReadMe.txt 之类的文件，写一些使用说明，这样每个新建的用户都会在自己的目录下看到这个说明文件了
* 再比如，你希望新建用户可以直接 startx 就启动到 gnome 桌面环境，你可以在 skel 目录下建立一个 .xinitrc 文件，内容如下：
``` shell
export LC_ALL="zh_CN.UTF-8"
export XMODIFIERS=@im=SCIM
export GTK_IM_MODULE="scim"
eval `dbus-launch --exit-with-session --sh-syntax`
exec gnome-session
```
 > .xinitrc 是 X 启动需要读取的用户配置文件，这样每个用户 startx 之后就直接装载 gnome 了

* 你甚至可以在 sekl 目录下再建立目录，总之 /etc/skel 下的所有文件都会拷贝的用户的家目录去
* 你也许会想到，在 skel 目录下的 .bashrc 文件中加入一些方便的环境变量或者命令别名，这样每个新建用户都可以使用这些功能。不过，更好的选择是把这些设置放到全局的 /etc/profile 中，skel 目录下的文件是拷贝过去的，如果你修改或者增加了新的文件，只有新建的用户才能受益

## Linux shell 中执行命令的查找顺序




## apt、wget、curl 设置代理端口 [[Top]](#目录)

### apt 代理设置

１. 作用于当前终端（临时有效，关闭当前终端，再打开终端则无效）
bash 里命令行执行```export http_proxy=http://yourproxyaddress:proxyport```（https、ftp等其他代理类型类似）
> 此时 wget、curl等应用程序都是使用http_proxy
２. 专门设置 apt 的代理
* 如果您希望 apt（而不是其他应用程序）一直使用某个代理，可以编辑 /etc/apt/apt.conf 配置文件（如果 /etc/apt/ 目录下没有 apt.conf 文件，那么需要手动创建）
* 按照下面的格式，将网络代理配置信息加入到 apt.conf 文件里
``` shell
Acquire::http::proxy “http://user:passwd@proxyserver:port”;
Acquire::http::Proxy "http://yourproxyaddress:proxyport";
Acquire::http::Proxy “http://192.168.0.1：80“；
Acquire::ftp::proxy "ftp://127.0.0.1:8000/";
```
* 保存退出当前配置文件，关闭当前终端，然后打开另一个终端
* 运行 ```sudo apt-get update``` 命令，来检测 ubuntu 系统是否能够正常更新
3. 统一设置所有应用程序的代理，对所有用户有效

4. 统一设置所有应用程序的代理，对当前用户和所有有效，会覆盖　/etc/environment 里的相同代理设置
* 如果您希望 apt和其他应用程序如 wget 等都使用代理，您可以使用这种方式，编辑 ~/.bashrc文件，在您的.bashrc文件末尾添加如下内容：
``` shell
export http_proxy=http://yourproxyaddress:proxyport
# 根据你的实际情况替换yourproxyaddress和proxyport
```
* 保存退出当前配置文件，关闭当前终端，然后打开另一个终端
* 运行 ```sudo apt-get update``` 命令，来检测 ubuntu 系统是否能够正常更新

### wget 代理设置
１. 临时有效
* bash 里命令行执行```export http_proxy=http://yourproxyaddress:proxyport```（https、ftp等其他代理类型类似）
> 此时 wget、curl、apt 等应用程序都是使用http_proxy
* 直接将代理作为 wget 命令的参数：```wget ... -e use_proxy=yes -e http_proxy=http://yourproxyaddress:proxyport ...```


## shell、终端、终端模拟器 [[Top]](#目录)

### shell 其实是 /bin 目录下的**可执行文件**
* Linux 将允许使用的 shell 不同版本名存储在 /etc/shells，可以使用```cat /etc/shells```查看

<div align=center>
    <img src="./images/shell.jpg" /><br/>/bin 目录下的不同的 shell 版本
</div>

### 终端 - terminal
> terminal 只是一个命令的输入窗口，例如 Windows 有 CMD

<div align=center>
    <img src="./images/terminal.jpg" /><br/>谈到 shell 以前以为就是这个，但这只是 terminal
</div>

### 终端模拟器 - terminal emulator
> 例如：Windows 下的 Putty、Xshell；Linux 下的 Guake Terminal

## Ubuntu 彻底关闭 dash [[Top]](#目录)

> Ubuntu 安装了 dockey 代替系统设置里的默认 dash，但系统设置不能选择关闭 dash（只能选择隐藏，但时常误触就会弹出，很烦人）

* 解决方法：在目录 ```/usr/share/gnome-shell/extensions/```删除文件夹```ubuntu-dock@ubuntu.com```
> * 一定要先备份```ubuntu-dock@ubuntu.com```，注意权限问题

## sudo apt update 提示异常信息 [[Top]](#目录)

``` shell
N: 鉴于仓库 'http://dl.google.com/linux/earth/deb stable InRelease' 不支持 'i386' 体系结构，跳过配置文件 'main/binary-i386/Packages' 的获取。
```
分析：这是因为执行`sudo apt update`时根据`/etc/apt/sources.list`镜像站读取下载所有软件源到`/var/lib/apt/lists/'目录，但可能会下载了自己电脑架构不兼容的软件源，这样就会提示上面信息

### 解决方法

> 移除架构不兼容的软件源

* 执行命令：`dpkg --remove-architecture i386`

#### 上面命令可能出现错误：`dpkg: 错误: 无法移除体系结构 i386 ，当前它仍被数据库使用`

> * 先查看 安装了哪些外部架构： `dpkg --print-foreign-architectures`
可能会显示： i386
> * 删除所有已下载的 i386 软件包：```apt-get purge ".*:i386"```
purge 关键字（而不是 remove ）将删除与要卸载的软件包关联的所有配置文件
> * 现在您可以删除 i386 架构：`dpkg --remove-architecture i386`

## Linux 中使用 crontab 命令启用自定义定时任务 [[Top]](#目录)

> crontab - 定时任务

### 简介

* Linux 下的任务调度分为两类，系统任务调度和用户任务调度
    * 系统任务调度：系统需要定期执行的任务，比如重启、日志清理等，其配置文件是：`/etc/crontab`
    * 用户任务调度：某个用户需要定期执行的任务，用户可以使用`crontab`命令来配置自己的定时任务。所有用户配置的定时任务都存放在 `/var/spool/cron/crontabs/` 目录下，其文件名与用户名一致。如：root用户的所有定时任务就保存在 `/var/spool/cron/root` 文件中
 > `/var/spool/cron/crontabs`目录需要切换到 root 权限才能打开

## crontab 文件详解

### `/etc/crontab`文件源代码

``` shell
# /etc/crontab: system-wide crontab
# Unlike any other crontab you don't have to run the `crontab'
# command to install the new version when you edit this file
# and files in /etc/cron.d. These files also have username fields,
# that none of the other crontabs do.

SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

# m h dom mon dow user	command
17 *	* * *	root    cd / && run-parts --report /etc/cron.hourly
25 6	* * *	root	test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.daily )
47 6	* * 7	root	test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.weekly )
52 6	1 * *	root	test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.monthly )
#
```

### `/var/spool/cron/crontab/用户名`文件源代码

``` shell
# DO NOT EDIT THIS FILE - edit the master and reinstall.
# (/tmp/crontab.LtbPsE/crontab installed on Fri Dec 14 21:01:59 2018)
# (Cron version -- $Id: crontab.c,v 2.13 1994/01/17 03:20:37 vixie Exp $)
# Edit this file to introduce tasks to be run by cron.
# 
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
# 
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').# 
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
# 
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
# 
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
# 
# For more information see the manual pages of crontab(5) and cron(8)
# 
# m h  dom mon dow   command
*/10 * * * * /usr/local/bin/himawaripy
```

#### `*/10 * * * * /usr/local/bin/himawaripy` 详解

<div align=center>
    <img src="./images/crontab.jpg" /><br/>crontab 文件中添加配置格式
</div>

* 它的格式一共分为六个字段，前五段是时间设置段，第六段是要执行的命令段，格式如下：
```
minute hour day month week command
```

* minute： 表示分钟，可以是从 0 到 59 之间的任何整数
* hour：表示小时，可以是从 0 到 23 之间的任何整数
* day：表示日期，可以是从 1 到 31 之间的任何整数
* month：表示月份，可以是从 1 到 12 之间的任何整数
* week：表示星期，可以是从 0 到 7 之间的任何整数，这里的 0 或 7 都代表星期日
* command：表示需要执行的命令，可以是系统命令，也可以是自己编写的脚本文件

> * 在以上各个字段中，还可以使用以下特殊字符：
```
*    代表所有可能的值，例如：如果 month 字段是星号，则表示在满足其它字段的约束条件后每月都执行该命令
,     用逗号隔开的值表示一个范围列表，例如：如果 minute 字段的值是 “1,3,15”，则表示每小时的第 1 分钟、第 3 分钟和第 15 分钟都执行该命令
–    可以用整数之间的 – 表示一个整数范围，例如：如果 day 字段的值是 “2-6”，则表示每月的第2天到底6天都执行该命令
/    可以用斜线表示命令的执行频率，例如：如果 minute 字段的值是 “*/10”，则表示每十分钟执行一次命令
```

## Linux 添加环境变量 $PATH [[Top]](#目录)

> 有时手动编译安装软件包时，可执行目录 - `bin` 目录并不在环境变量 `$PATH` 里，所以不可以直接在终端执行，这时需要手动添加新的 `bin` 路径到 `$PATH` 环境变量中

* `$PATH`：决定了 shell 将到哪些目录中寻找命令或程序，PATH 的值是一系列目录，当您运行一个程序时，Linux 在这些目录下进行搜寻编译链接
* 其格式为：
`PATH=$PATH:<PATH1>:<PATH2>:<PATH3>:------:<PATHn>`
> * 你可以自己加上指定的路径，中间用冒号隔开
> * 环境变量更改后，在用户下次登陆时生效，如果想立刻生效而免去重新启动，则可执行下面的语句：`$source   /etc/profile`

**添加方法**

1. 临时添加，退出终端即没有效果了

``` shell
sudo export PATH=/usr/local/vim/bin:$PATH
```

2. `/etc/profile` 文件中修改，全局永久有效

``` shell
sudo vim /etc/profile
# 在文档最后，添加
export PATH="/usr/local/vim/bin:$PATH"
# 保存，退出，然后运行，即可立即生效
source /etc/profile
```

## Linux 手动添加字体文件 [[Top]](#目录)

* Linux 的字体都在 /usr/share/fonts 这个目录里，一种字体就是这个目录下面的一个子目录
* 将字体文件（.ttf 文件）放入这个目录下，还需要用root用户身份依次执行如下三条命令，这个字体才能用
``` shell
sudo mkfontscale
sudo mkfontdir
sudo fc-cache -fv
```

## `#!/usr/bin/env` 与 `#!/usr/bin`区别 [[Top]](#目录)

> 在 Linux、Unix、Mac 的一些脚本中，经常在开头出现`#!/usr/bin/env` 与 `#!/usr/bin`

例如：

``` shell
#!/usr/bin/env python
#!/usr/bin python
#!/usr/bin/env perl
#!/usr/bin perl
```

**区别**

> * `#!/usr/bin python`: 表示脚本执行的一定是`/usr/bin/python`解释器，但有时 python 解释器并不是安装在`/usr/bin`目录下，这时脚本就无法执行。
> * `#!/usr/bin/env python`: 脚本执行时会通过命令`/usr/bin/env`运行 python，env 会从环境变量中寻找 python 解释器并执行。所以，即使 python 并未安装在 `/usr/bin` 目录下也是可以的
> * 推荐使用`#!/usr/bin/env python` 形式

## 永久修改 DNS [[Top]](#目录)

https://blog.csdn.net/MrBaymax/article/details/79430744

https://www.zhujibiji.com/2017/12/linux-permanently-modify-dns/

## Linux程序存放目录 [[Top]](#目录)
![](./images/Linux程序存放目录.jpg)

## 更换镜像源 [[Top]](#目录)

阿里镜像源：https://opsx.alibaba.com/mirror?lang=zh-CN

> * 对应镜像源后【帮助】，有对应修改详细介绍



## 诊断某文件无法修改 [[Top]](#目录)

1. 使用 `file filename` 查看文件格式，若不是文本文件，是无法编辑的
2. 最可能是权限问题，`ls -l filename` 查看文件权限，若是，使用 `chmod` 或 `chown` 修改之
3. `1 、2` 都不是的话，使用 `lsattr filename` 查看文件隐藏属性，若是，使用 `chattr` 修改之



## Linux terminal 快捷键 [[Top]](#目录)

| 终端快捷键   | 功能                                       |
| ------------ | ------------------------------------------ |
| Ctrl + a     | 光标移动到行首                             |
| Ctrl + e     | 光标移动到行尾                             |
| Ctrl + c     | 终止当前程序                               |
| Ctrl + d     | 如果光标前有字符则删除，没有则退出当前中断 |
| Ctrl + l     | 清屏                                       |
| Ctrl + u     | 剪切光标以前的字符                         |
| Ctrl + k     | 剪切光标以后的字符                         |
| Ctrl + y     | 复制 Ctrl u / k 的内容                     |
| Ctrl + r     | 查找最近用过的命令                         |
| Ctrl+shift+c | 复制                                       |
| Ctrl+shift+v | 粘贴                                       |

## 通过 PID 查看进程完整信息 [[Top]](#目录)

> 通常已知 Port ，可以通过 **`lsof -i:\<Port\>`** 得到 PID，然后使用 **`ps aux | grep PID`** 或 **`ps -ef | grep PID`**，查看进程信息，但有时需要进程的更多的信息，这时就可以直接找到进程的文件（Linux 中一切皆是文件）

* **每个进程，都会在 `/proc` 文件夹里面生成一个进程目录，里面存放了进程的各种信息**

* **`sudo ls -l /proc/\<PID\>`**

  ``` BASH
  $ ps -ef | grep v2ray | grep -v grep
  root      9541     1  0 Nov21 ?        00:00:02 /usr/bin/v2ray/v2ray -config /etc/v2ray/config.json
  $ sudo ls -l /proc/9541
  总用量 0
  dr-xr-xr-x  2 root root 0 Nov 21 19:23 attr
  -rw-r--r--  1 root root 0 Nov 22 19:41 autogroup
  -r--------  1 root root 0 Nov 22 19:41 auxv
  -r--r--r--  1 root root 0 Nov 21 19:23 cgroup
  --w-------  1 root root 0 Nov 22 19:41 clear_refs
  -r--r--r--  1 root root 0 Nov 21 19:23 cmdline
  -rw-r--r--  1 root root 0 Nov 21 19:23 comm
  -rw-r--r--  1 root root 0 Nov 22 19:41 coredump_filter
  -r--r--r--  1 root root 0 Nov 22 19:41 cpuset
  lrwxrwxrwx  1 root root 0 Nov 22 19:41 cwd -> /
  -r--------  1 root root 0 Nov 22 19:41 environ
  lrwxrwxrwx  1 root root 0 Nov 22 19:41 exe -> /usr/bin/v2ray/v2ray
  dr-x------  2 root root 0 Nov 21 19:23 fd
  dr-x------  2 root root 0 Nov 22 19:41 fdinfo
  -rw-r--r--  1 root root 0 Nov 22 19:41 gid_map
  -r--------  1 root root 0 Nov 22 19:41 io
  -r--r--r--  1 root root 0 Nov 22 19:41 limits
  -rw-r--r--  1 root root 0 Nov 21 19:23 loginuid
  dr-x------  2 root root 0 Nov 22 19:41 map_files
  -r--r--r--  1 root root 0 Nov 22 19:41 maps
  -rw-------  1 root root 0 Nov 22 19:41 mem
  -r--r--r--  1 root root 0 Nov 22 19:41 mountinfo
  -r--r--r--  1 root root 0 Nov 22 19:41 mounts
  -r--------  1 root root 0 Nov 22 19:41 mountstats
  dr-xr-xr-x  6 root root 0 Nov 22 19:41 net
  dr-x--x--x  2 root root 0 Nov 22 19:41 ns
  -r--r--r--  1 root root 0 Nov 22 19:41 numa_maps
  -rw-r--r--  1 root root 0 Nov 22 19:41 oom_adj
  -r--r--r--  1 root root 0 Nov 22 19:41 oom_score
  -rw-r--r--  1 root root 0 Nov 22 19:41 oom_score_adj
  -r--------  1 root root 0 Nov 22 19:41 pagemap
  -r--------  1 root root 0 Nov 22 19:41 patch_state
  -r--------  1 root root 0 Nov 22 19:41 personality
  -rw-r--r--  1 root root 0 Nov 22 19:41 projid_map
  lrwxrwxrwx  1 root root 0 Nov 22 19:41 root -> /
  -rw-r--r--  1 root root 0 Nov 22 19:41 sched
  -r--r--r--  1 root root 0 Nov 22 19:41 schedstat
  -r--r--r--  1 root root 0 Nov 21 19:23 sessionid
  -rw-r--r--  1 root root 0 Nov 22 19:41 setgroups
  -r--r--r--  1 root root 0 Nov 22 19:41 smaps
  -r--r--r--  1 root root 0 Nov 22 19:41 smaps_rollup
  -r--------  1 root root 0 Nov 22 19:41 stack
  -r--r--r--  1 root root 0 Nov 21 19:23 stat
  -r--r--r--  1 root root 0 Nov 22 19:41 statm
  -r--r--r--  1 root root 0 Nov 21 19:23 status
  -r--------  1 root root 0 Nov 22 19:41 syscall
  dr-xr-xr-x 19 root root 0 Nov 22 19:41 task
  -r--r--r--  1 root root 0 Nov 22 19:41 timers
  -rw-rw-rw-  1 root root 0 Nov 22 19:41 timerslack_ns
  -rw-r--r--  1 root root 0 Nov 22 19:41 uid_map
  -r--r--r--  1 root root 0 Nov 22 19:41 wchan
  ```

- `cwd` - 符号链接的是进程运行目录
- `exe` - 符号连接就是执行程序的绝对路径
- `cmdline` - 就是程序运行时输入的命令行命令
- `environ` - 记录了进程运行时的环境变量
- `fd` - 目录下是进程打开或使用的文件的符号连接

## 文件权限 777 [[Top]](#目录)

* 文件权限 777、644 等等，其实是八进制的表示方法



## /tmp 目录自动清理 [[Top]](#目录)

> 在线安装软件时，常常将安装包先下载到 `/tmp/` 下面，这是因为 `/tmp/` 目录会定时自动清理

* **在 RHEL6 中，系统自动清理 `/tmp` 文件夹的默认时限是 30 天**
* **在 Ubuntu 中，系统自动清理 `/tmp` 文件夹的时限默认每次启动**

## 修改时区 [[Top]](#目录)

> * [设置修改Linux系统时间与时区的6种方法- 2018](https://www.linuxrumen.com/rmxx/182.html) 
> * [Linux时间和timezone概念解释](https://www.ichenfu.com/2018/05/15/linux-timezone/)
> * CST - 中国标准时间 (China Standard Time)
> * UTC - 通用协调时(Universal Time Coordinated)

* `/etc/localtime` 是用来描述**本机时间**，而 `/etc/timezone` 是用来描述**本**

  **机所属的时区**

* `zdump -v /etc/localtime` 读取 `/etc/localtime` 内容

* 修改 `/etc/localtime` 使本地时间正确(对应 linux 的 date 指令正确),另外还需要修改 `/etc/timezone` 使得时区正确

**`修改配置文件`**

``` bash
$ sudo echo 'Asia/Shanghai' > /etc/timezone

# 例如：Dockerfile 时区设置
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' >/etc/timezon
```

**`timedatectl 命令设定`**

``` bash
$ timedatectl set-timezone Asia/Shanghai    #其他时区以此类推
```

**`直接手动创建软链接`**

```bash
$ ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
```

**`tzselect 命令引导设定`**

```bash
$ tzselect
Please identify a location so that time zone rules can be set correctly.
Please select a continent, ocean, "coord", or "TZ".
 1) Africa
 2) Americas
 3) Antarctica
 4) Asia
 5) Atlantic Ocean
 6) Australia
 7) Europe
 8) Indian Ocean
 9) Pacific Ocean
10) coord - I want to use geographical coordinates.
11) TZ - I want to specify the time zone using the Posix TZ format.
#?
```

## vim 高亮
``` bash
echo export EDITOR=vim >> /etc/profile.d/env.sh
source /etc/profile.d/env.sh
```
## 一段脚本片段 [[Top]](#目录)

``` shell
#!/bin/bash
# Don't generate .pyc files
export PYTHONDONTWRITEBYTECODE=1
```
