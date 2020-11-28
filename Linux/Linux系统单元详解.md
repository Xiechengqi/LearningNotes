# Linux 系统单元( Systemd.unit ) 详解

## 目录
* [Linux 系统启动三种方式](#linux-系统启动三种方式)


## Linux 系统启动三种方式

Linux系统目前存在的三种系统启动方式所对应的配置文件目录分别为：
1、**SysVinit** - `/etc/init.d` 目录；
2、Systemd：/usr/lib/systemd目录；
3、UpStart： `/usr/share/upstart` 目录；


但是大多数系统上，都会存在多个类似的目录，因此不能简单地根据是否存在相应的配置目录的方式来判断系统的启动方式，这里推荐的方式上是根据init进程号1所对应的可执行文件来判断



