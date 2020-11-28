# Ubuntu 软件包安装

> * deb 是 Debian、Ubuntu 软件安装的一种格式
> * rpm 是 Redhat、Fedora、SUSE 软件安装的一种格式

## 源码包（ Tarball 软件)

1. 安装编译工具：`$ sudo apt-get install build-essential`
* 在 ubuntu 上编译程序，默认是有 gcc 的，但是没有 g++。如果自己来安装 g++ 也可以，不过它涉及到一些依赖库，有点麻烦，但 build-essential 包里有很多开发必备的软件包：`dpkg-dev fakeroot g++ g++-4.6 libalgorithm-diff-perl libalgorithm-diff-xs-perl libalgorithm-merge-perl libdpkg-perl libstdc++6-4.6-dev libtimedate-perl`
* 推荐将源码包放在`/usr/local/src`目录下
2. 进入`/usr/local/src`目录，解压源码包，进入源码目录
3. 编译、安装软件
* 一般情况下，里面有个 configure 文件，则运行命令:
```shell
sudo ./configure --prefix=/usr/local/filename  #存放路径，可更改
make    #编译
sudo make install #安装
```

> --prefix 选项是配置安装目录，如果不配置该选项，安装后可执行文件默认放在 `/usr /local/bin`，库文件默认放在`/usr/local/lib`，配置文件默认放在`/usr/local/etc`，其它的资源文件放在`/usr /local/share`，比较凌乱。如上安装后的所有资源文件都在`/usr/local/filename`文件夹里

* 如果只有Makefile文件，则运行命令：
```shell
make    #编译
sudo make install #安装
```
* 如果只是Imake文件，则运行命令：
```shell
xmkmf  #配置
make  #编译
sudo make install   # 安装
```
4. 卸载软件：`$ dpkg -r filename.deb`
5. 清除编译过程中产生的临时文件：`$ make clean`
6. 清除配置过程中产生的文件：`$ make distclean` (谨用)
7. 卸载软件时，进入源码文件目录：`$ make uninstall`

**关于卸载**

* 如果没有配置 --prefix 选项，源码包也没有提供 make uninstall，则可以通过以下方式可以完整卸载：
  * 找一个临时目录重新安装一遍，如：`./configure --prefix=/tmp/to_remove && make install`
  * 然后遍历`/tmp/to_remove`的文件，删除对应安装位置的文件即可（ 因为`/tmp/to_remove`里的目录结构就是没有配置 --prefix 选项时的目录结构 ）

## deb包

方法一、 使用 dpkg 软件管理系统双击直接安装
方法二、 命令行安装
```shell
sudo apt-get install dpkg   #先安装dpkg
dpkg -i filename.deb  #安装软件
dpkg -r filename.deb   #卸载
```
## rpm包
方法一、 先用 alien 命令把 rpm 包转换为 deb 软件包，再安装即可

```shell
sudo apt install alien      #安装alien
alien -d filename.rpm       #使用alien将rpm包转换为deb包
sudo dpkg -i filename.deb   #安装
sudo dpkg -r filename.deb   #卸载
```
方法二、 使用 rpm 命令直接安装

```shell
sudo apt install rpm        #安装 rpm
./alien -i filename.rpm
```

##　bin 包

```shell
sudo chmod a+x filename.bin   #更改执行权限
./filename.bin   #安装
```

## sh 包或 bash 包

```shell
sudo chmod a+x filename.sh filename.bash       # 更改权限
./filename.sh (或 $ ./filename.bash)           #安装软件
```

## 二进制包

* 不用安装，将软件放于某目录下。
* 直接运行软件：`$ ./filename`

## py 包

```shell
sudo apt-get install python    # 安装 python
sudo python3 setup.py install  # 安装 python3 的库
python filename.py             # 安装软件
```

## pl 包

```shell
sudo apt-get install perl    # 安装 perl
perl filename.pl             # 安装软件
```
