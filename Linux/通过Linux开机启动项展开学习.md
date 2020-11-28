# 通过 Linux 开机启动项学习

## 目录
* [**相关文章**](#[相关文章]top)
* [**一、简述 Linux 开机启动流程**](#一、简述-linux-开机启动流程-top)
* [**二、开机启动相关文件**](#二、开机启动相关文件-top)
* [**三、Linux 管理守护进程两种方式**](#三、Linux-管理守护进程两种方式-top)
* [**四、设置开机启动方法**](#四、设置开机启动方法-top)

## 【相关文章】[[Top]](#目录)

> * [ 计算机是如何启动的？- 阮一峰](http://www.ruanyifeng.com/blog/2013/02/booting.html)
> * [Linux 的启动流程 - 阮一峰](http://www.ruanyifeng.com/blog/2013/08/linux_boot_process.html)
> * [Linux 守护进程的启动方法 - 阮一峰](http://www.ruanyifeng.com/blog/2016/02/linux-daemon.html)
> * [Systemd 入门教程：命令篇 - 阮一峰](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-commands.html)
> * [Systemd 入门教程：实战篇 - 阮一峰](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-part-two.html)

## 一、简述 Linux 开机启动流程 [[Top]](#目录)

<div align=center>
<img src="./images/computer_start.png"><br/>
这个过程不涉及操作系统，只与主板的板载程序有关<br/>
详情可看<a  href="http://www.ruanyifeng.com/blog/2013/02/booting.html">计算机是如何启动的？</a>
</div>

<div align=center>
<img src="./images/os_start.png"><br/>
Linux 操作系统的启动流程
</div>

**第一步、加载内核**

* 内核在 `/boot/` 目录下

**第二步、启动初始化进程**

* 内核文件加载以后，就开始运行第一个程序  /sbin/init，它的作用是初始化系统环境
* 由于 init 是第一个运行的程序，它的进程编号（ pid ）就是 1。其他所有进程都从它衍生，都是它的子进程

**第三步、确定运行级别**

* 许多程序需要开机启动。它们在 Windows 叫做 "服务"（ service ），在 Linux 就叫做"守护进程"（ daemon ）
* init 进程的一大任务，就是去运行这些开机启动的程序
* Linux 允许为不同的场合，分配不同的开机启动程序，这就叫做 "运行级别"（ runlevel ）。也就是说，启动时根据 "运行级别"，确定要运行哪些程序

**第四步、加载开机启动程序**

* 七种预设的 "运行级别" 各自有一个目录，存放需要开机启动的程序。不难想到，如果多个 "运行级别" 需要启动同一个程序，那么这个程序的启动脚本，就会在每一个目录里都有一个拷贝。这样会造成管理上的困扰：如果要修改启动脚本，岂不是每个目录都要改一遍

* Linux 的解决办法，就是七个 `/etc/rcN.d` 目录里列出的程序，都设为链接文件，指向另外一个目录 `/etc/init.d`，真正的启动脚本都统一放在这个目录中。init 进程逐一加载开机启动程序，其实就是运行这个目录里的启动脚本

**第五步、用户登录**

* 开机启动程序加载完毕以后，就要让用户登录了

* 一般来说，用户的登录方式有三种：
  * （1）命令行登录
  * （2）ssh 登录
  * （3）图形界面登录
  

**第六步、进入 login shell**

* 用户登录时打开的 shell，就叫做 login shell

**第七步，打开 non-login shell**

* 用户进入操作系统以后，常常会再手动开启一个 shell。这个 shell 就叫做 non-login shell，意思是它不同于登录时出现的那个shell，不读取`/etc/profile`和`.profile`等配置文件

## 二、开机启动相关文件 [[Top]](#目录)

### `/etc/rc[0-6].d`目录

**`ls /etc/ | grep '^rc.*'`**

``` shell
rc0.d rc1.d rc2.d rc3.d rc4.d rc5.d rc6.d rc.local rcS.d
```

* 0 - 6 是 Linux 操作系统的运行级别，运行命令 `runlevel` 查看当前运行级

| 运行级别 | 说明 |
| :---: | --- |
| 0 | 系统停机状态，系统默认运行级别不能设为0，否则不能正常启动 |
| 1 | 单用户，无网络连接，不运行守护进程，不允许非超级用户登录，用于系统维护，禁止远程登陆 |
| 2 | 多用户，无网络连接，不运行守护进程 |
| 3 | 多用户，正常启动系统，登陆后进入控制台命令行模式 |
| 4 | 用户自定义 |
| 5 | 多用户，带图形界面，X11 控制台 |
| 6 | 系统正常关闭并重启，默认运行级别不能设为6，否则不能正常启动 |

**`ls /etc/rc0.d/`**

``` shell
K01alsa-utils      K01dnsmasq  K01irqbalance  K01openipmi  K01resolvconf         K01tlp                  K02gdm3
K01bluetooth       K01docker   K01lightdm     K01plymouth  K01speech-dispatcher  K01unattended-upgrades  K04rsyslog
K01cgroupfs-mount  K01gdomap   K01mysql       K01polipo    K01spice-vdagent      K01uuidd                K05hwclock.sh
K01cups-browsed    K01ipmievd  K01nginx       K01postfix   K01thermald           K02avahi-daemon         K06networking
```

* 目录下文件的命名规则：**S|K + nn + script**
  * **`S | K`** - S 开头命名的是开机要执行的脚本，K 开头命名的是关机要执行的脚本
  * **`nn`** - 取值 0 - 100，表示优先级，数字越大，优先级越低
  * **`script`** - 软链接指向的脚本的文件名
  

 **`ls -l /etc/rc0.d/`**

``` shell
总用量 0
lrwxrwxrwx 1 root root 20 Mar 10  2018 K01alsa-utils -> ../init.d/alsa-utils
lrwxrwxrwx 1 root root 19 Mar 10  2018 K01bluetooth -> ../init.d/bluetooth
lrwxrwxrwx 1 root root 24 Jan  2  2019 K01cgroupfs-mount -> ../init.d/cgroupfs-mount
lrwxrwxrwx 1 root root 22 Mar 10  2018 K01cups-browsed -> ../init.d/cups-browsed
lrwxrwxrwx 1 root root 17 Mar 29  2019 K01dnsmasq -> ../init.d/dnsmasq
lrwxrwxrwx 1 root root 16 Jan 14  2019 K01docker -> ../init.d/docker
lrwxrwxrwx 1 root root 16 Dec  6  2018 K01gdomap -> ../init.d/gdomap
lrwxrwxrwx 1 root root 17 Oct 13 14:44 K01ipmievd -> ../init.d/ipmievd
lrwxrwxrwx 1 root root 20 Mar 10  2018 K01irqbalance -> ../init.d/irqbalance
lrwxrwxrwx 1 root root 17 Mar 10  2018 K01lightdm -> ../init.d/lightdm
lrwxrwxrwx 1 root root 15 Jun  9 18:52 K01mysql -> ../init.d/mysql
lrwxrwxrwx 1 root root 15 Oct  6 15:12 K01nginx -> ../init.d/nginx
lrwxrwxrwx 1 root root 18 Oct 13 14:44 K01openipmi -> ../init.d/openipmi
lrwxrwxrwx 1 root root 18 Mar 10  2018 K01plymouth -> ../init.d/plymouth
lrwxrwxrwx 1 root root 16 Oct  4 12:56 K01polipo -> ../init.d/polipo
. . .
```

* 可见 `/etc/rcX.d/` 目录下的文件都是软链接到 `/etc/init.d` 下的守护进程 ( daemon ) 启动文件

## 三、Linux 管理守护进程两种方式 [[Top]](#目录)

### 守护进程

* 守护进程 ( daemon ) 就是一直在后台运行的进程
* 许多程序需要开机启动，它们在 Windows 叫做 "服务"（service），在Linux就叫做 "守护进程"（daemon）

**命名规则**

* 通常在服务的名字后面加上 `d`，即表示守护进程，比如 sshd、teamviewerd 等等

### 守护进程两种管理方式 

#### service

**`service sshd start`** ---> **`加载 /lib/systemd/system/ssh.service`** ---> **`/etc/init.d/sshd`** ---> **`/usr/sbin/sshd 参数1 参数2 ...`** ---> **`成功启动 ssh`**

* `相关文件` - `/etc/init.d`、`/usr/sbin/service` 等等
* `which service`   - `/usr/sbin/service`
* `file service` - `POSIX shell script`
* `file /etc/init.d/ssh` - `POSIX shell script` - `/etc/init.d` 目录下全是守护进程的执行脚本
* `cat /usr/sbin/service`  - `A convenient wrapper for the /etc/init.d init scripts`
* 所以，`service` 其实就是一个在 `/etc/init.d` 目录下查找 `$1` 并执行的脚本
* 所以，`service mysql start` 其实就是 `/etc/init.d/mysql start`
* `/etc/init.d` 目录存在是为了封装直接使用命令操控守护进程传入各种参数等操作过程，通过查看该目录下脚本，简化言之就是通过调用 `/usr/bin`、`/usr/sbin/`等目录下守护进程对应可执行文件并传以各种参数，达到只需要 `/etc/init.d/xxx start|stop|reload|....` 就可以操控守护进程的目的

#### systemctl

* `相关文件` - `/etc/systemd/system`、`/lib/systemd/system`(ubuntu)、`/usr/lib/systemd/system`(RedHat) 等等
* 可使用 `man systemd.unit` 查看各个文件解释
* systemctl 是 Linux 系统最新初始化系统的守护进程 **systemd**  对应的进程管理命令
* 对于那些支持 systemd 的软件，安装的时候，会自动在 `/usr/lib/systemd/system` 目录添加一个配置文件
* systemctl 兼容 service 

## 四、设置开机启动方法 [[Top]](#目录)

### 1、 编辑`/etc/rc.local`文件

> 没有的话自己创建

``` shell
#!/bin/sh
#
# This script will be executed *after* all the other init scripts.
# You can put your own initialization stuff in here if you don't
# want to do the full Sys V style init stuff.

touch /var/lock/subsys/local
/etc/init.d/mysqld start  #mysql开机启动
/etc/init.d/nginx start  #nginx开机启动
/etc/init.d/php-fpm start  #php-fpm开机启动
/etc/init.d/memcached start   #memcache开机启动

#在文件末尾（exit 0之前）加上你开机需要启动的程序或执行的命令即可（执行的程序需要写绝对路径，添加到系统环境变量的除外），如：

/usr/local/thttpd/sbin/thttpd  -C /usr/local/thttpd/etc/thttpd.conf
```

### 2、 使用 `chkconfig \ systemctl` 命令

> 早期的 Linux 版本是用 chkconfig 命令来设置 rc 的 link，设置开机启动项；用 service 命令调用服务的 start、stop、restart、status 等函数。在现在主流 Linux 版本已经将这两个命令合并成一个 systemctl 命令了，映射关系如下:

| 任务 | 旧指令 ( chkconfig、service ) | 新指令 ( systemctl ) |
| --- | --- | --- |
| 设置服务开机自启 | chkconfig --level 3 httpd on | systemctl enable httpd.service |
| 禁止服务开机自启 | chkconfig --level 3 httpd off | systemctl disable httpd.service |
| 查看服务状态 | service httpd status | systemctl status httpd.service |
| 显示所有开机启动服务 | chkconfig --list | systemctl list-units --type=service |
| 显示当前已启动的开机启动服务 | &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;--- | systemctl list-units &#124; grep enable |
| 显示当前已启动的开机启动文件 | &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;--- | systemctl list-files &#124; grep enable |
| 显示启动失败的开机启动服务 | &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;--- | systemctl --failed |
| 启动服务 | service httpd start | systemctl start httpd.service |
| 关闭服务 | service httpd stop | systemctl stop httpd.service |
| 重启服务 | service httpd restart | systemctl restart httpd.service |

### 3、自己写一个shell脚本

将写好的脚本（ .sh 文件）放到目录 `/etc/profile.d/` 下，系统启动后就会自动执行该目录下的所有 shell 脚本。

<div align=center>
<img src="/Linux/images/profiled.jpg"><br/>
/etc/profile.d 文件夹中文件
</div>

### 4、添加一个开机启动服务

将你的启动脚本复制到` /etc/init.d`目录下，并设置脚本权限, 假设脚本为 test

``` bash
$ mv test /etc/init.d/test
$ sudo chmod 755 /etc/init.d/test
```

> * `/etc/init.d` 目录下的控制脚本接受参数 start | stop | restart | status | force-reload

将该脚本放倒启动列表中去
```
$ cd .etc/init.d
$ sudo update-rc.d test defaults 95
```
> * 其中数字 95 是脚本启动的顺序号，按照自己的需要相应修改即可。在你有多个启动脚本，而它们之间又有先后启动的依赖关系时你就知道这个数字的具体作用了。

**update-rc.d**  命令 : 为`/etc/init.d`目录下的脚本建立或删除到`/etc/rc[0-6].d`的软链接

> update-rc.d 命令要在 `etc/init.d/` 目录下执行，可能还需要 root 权限
* 增加一个服务
  * 添加这个服务并让它开机自动执行 : update-rc.d apache2 defaults
    * 并且可以指定该服务的启动顺序 : update-rc.d apache2 defaults 90
    * 还可以更详细的控制start与kill顺序 : update-rc.d apache2 defaults 20 80
    * 其中前面的 20 是 start 时的运行顺序级别，80 为 kill 时的级别。也可以写成 : update-rc.d apache2 start 20 2 3 4 5 . stop 80 0 1 6 .(其中 0 ～ 6 为运行级别)
* 删除一个服务
  * update-rc.d -f apache2 remove
