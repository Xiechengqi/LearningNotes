# Git 源码安装最新版

> * CentOS7 yum 安装的 Git 版本是 1.8.5.1，而最新的官方版本已经到了 **[2.3.1.0](https://github.com/git/git/releases)** ，使用 GitLab runner 时，总是报一些莫名的错误，最后发现是 git 版本太低导致
> * Git Github 仓库: https://github.com/git/git/

* 查看当前操作系统版本号

``` shell
$ sudo cat /etc/redhat-release
```

* 安装依赖及编译工具

``` shell
$ sudo yum install curl-devel expat-devel gettext-devel openssl-devel zlib-devel -y
$ sudo yum install gcc perl-ExtUtils-MakeMaker -y
```

* 下载 Git 源码

``` shell
$ sudo cd /usr/src/
$ sudo wget https://github.com/git/git/archive/refs/tags/v2.31.0.tar.gz
$ sudo tar zxvf v2.31.0.tar.gz
$ sudo cd v2.31.0
```

* 编译安装

``` shell
# 编译
$ sudo make prefix=/usr/local/git all
# 编译无报错，卸载原有 git 并安装
$ sudo rpm -e --nodeps git
$ sudo make prefix=/usr/local/git install
$ sudo ln -s  /usr/local/git/bin/git /usr/bin/git
```

* 查看 git 版本

``` shell
$ git --version
git version 2.31.0
```