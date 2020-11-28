#  Linux 各种安装下载慢解决方法

由于墙或服务器在境外的原因，导致基本所有命令行工具安装下载速度都极慢，一般解决办法有以下三种：

1、更换国内镜像源（部分工具有国内镜像源）

2、使用 VPN 代理 + 流量转发工具

3、离线包安装

> * 终端代理 + 流量转发针对所有走 http、https 的工具都有效
> * 依据这三种方式介绍 pip、git、npm、brower、gem、apt、yum 等（后续持续更新）
> * **`[registry url]`** 指的就是镜像源网站, 比如 http://registry.npm.taobao.org/

## 一、更换国内镜像源

> * 最推荐使用这种方法

## Pip

**`[registry url]`**

> * 阿里云 https://mirrors.aliyun.com/pypi/simple/
> * 豆瓣 http://pypi.douban.com/simple/
> * 清华大学 https://pypi.tuna.tsinghua.edu.cn/simple/
> * 中科大 https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple/
> * pypi 	 https://pypi.python.org/simple/

**临时生效**

```bash
$ pip install modules -i [registry url]
$ pip3 install modules -i [registry url]
```

**永久生效** (pip 和 pip3 都一样)

```bash
# 先使用 updatedb 命令更新 locate 查找的数据
$ updatedb
# 使用 locate 查找 pip.conf
# 没有 pip.conf 则自行创建 ~/.pip/pip.conf
$ locate pip.conf
/home/xcq/.pip/pip.conf
/home/xcq/.pip/pip.conf.bak
# 在 pip.conf 添加以下内容
[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple	
```

**使用 `pqi` 管理镜像** - https://github.com/yhangf/PyQuickInstall

```bash
# 安装
$ pip install pqi
$ pqi 
Usage:
  pqi ls
  pqi use <name>
  pqi show
  pqi add <name> <url>
  pqi remove <name>
  pqi (-h | --help)
  pqi (-v | --version)
Options:
  -h --help        Show this screen.
  -v --version     Show version.
```

## Git

* Git 主要是在克隆 Github 仓库时很慢，但并不能通过修改软件源增速
* 介绍三种方法：
  * 修改 hosts 文件，网上很多教程
  * 先使用 gitee clone ，再 clone gitee 仓库
  * 使用代理 + 流量转发，这个最好用！

## NPM

**`[registry url]`**

* **淘宝npm镜像**
  * 搜索地址：http://npm.taobao.org/
  * registry地址：http://registry.npm.taobao.org/

* **cnpmjs镜像**

  * 搜索地址：http://cnpmjs.org/

  * registry地址：http://r.cnpmjs.org/

**临时生效**

```bash
$ npm install --registry [registry url]
```

**永久生效**

```bash
# npm config 配置
$ npm config set registry [registry url]
# 或修改 ~/.npmrc 文件，添加如下内容
registry=https://registry.npm.taobao.org

# 验证是否成功
npm config get registry
# 或
npm info express
```

**使用 `nrm` 模块管理镜像** - https://github.com/Pana/nrm

``` bash
# 安装
$ npm install -g nrm
$ nrm
Usage: nrm [options] [command]

Options:
  -V, --version                           output the version number
  -h, --help                              output usage information

Commands:
  ls                                      List all the registries
. . .
# 查看有哪些镜像
$ nrm ls
# 对比各个镜像的访问速度
$ nrm test 镜像名
# 使用淘宝的镜像
$ nrm use taobao
```

## gem

使用以下命令替换 gems 默认源

```bash
# 添加 TUNA 源并移除默认源
gem sources --add https://mirrors.tuna.tsinghua.edu.cn/rubygems/ --remove https://rubygems.org/
# 列出已有源
gem sources -l
# 应该只有 TUNA 一个
```

或者，编辑 `~/.gemrc`，将 `https://mirrors.tuna.tsinghua.edu.cn/rubygems/` 加到 `sources` 字段

## bundler

使用以下命令替换 bundler 默认源 

```bash
bash bundle config mirror.https://rubygems.org https://mirrors.tuna.tsinghua.edu.cn/rubygems
```

## 二、VPN 代理 + 流量转发工具

> 折腾终端开启代理实在是一波三折，反反复复尝试了数次，之前没一次成功，但每次遇到需要安装国外源的软件时就痛不欲生！跨度一两年的一个问题终于解决了，记录一下

* 终端代理究其原理和 chrome 扩展 Proxy SwitchyOmega 是一样的，都是为了将 socks 协议的数据转换成 http 协议, 因为终端很多下载安装命令 - wget、curl、git、brew 等等都是使用的 http 协议
* VPN 代理一般有 `shadowsocks` 和 `v2ray` 
* 流量转发工具，主要是为了实现 socks5 和 http 加密数据间的转换，常用的有 `polipo` 和 `privoxy` 

### **`v2ray`** + **`polipo`** + **`http_proxy`** + **`curl ip.gs`**

1、v2ray 客户端和服务端安装配置很简单 - [v2ray 官方安装教程](https://www.v2ray.com/chapter_00/install.html)

* v2ray 客户端和服务端一定要在 `/etc/v2ray/config.json` 文件添加日志路径！！！

```shell
"log": {
    "loglevel": "warning",
    "access": "/var/log/v2ray/access.log",
    "error": "/var/log/v2ray/error.log"
  }
```

2、安装 polipo

``` shell
## Ubuntu 下的安装
sudo apt-get install polipo
 
## CentOS 下的安装
sudo yum install polipo

## 编辑配置文件 /etc/polipo/config
vim /etc/polipo/config
# This file only needs to list configuration variables that deviate
# from the default values.  See /usr/share/doc/polipo/examples/config.sample
# and "polipo -v" for variables you can tweak and further information.

logSyslog = true
logFile = /var/log/polipo/polipo.log

proxyAddress = "0.0.0.0"

socksParentProxy = "127.0.0.1:1080"
socksProxyType = socks5

chunkHighMark = 50331648
objectHighMark = 16384

serverMaxSlots = 64
serverSlots = 16
serverSlots1 = 32

# This file only needs to list configuration variables that deviate
# from the default values.  See /usr/share/doc/polipo/examples/config.sample
# and "polipo -v" for variables you can tweak and further information.

logSyslog = true
logFile = /var/log/polipo/polipo.log

# socks 代理地址
socksParentProxy = "127.0.0.1:1080"
# 类型
socksProxyType = socks5
# 转换为 HTTP 之后的端口
proxyPort = 8123
# 下面不清楚，但需要
chunkHighMark = 50331648
objectHighMark = 16384
serverMaxSlots = 64
serverSlots = 16
serverSlots1 = 32
```

3、确保服务器 v2ray、客户端 v2ray 和 polipo 服务都正常运行，且查看日志没有报错！

4、在客户端本地 `~/.bashrc` 文件中设置 `export http_proxy=http://127.0.0.1:8123
export https_proxy=http://127.0.0.1:8123` 别名

``` shell
# 添加如下
alias hp="export http_proxy=http://127.0.0.1:8123"
alias hps="export https_proxy=http://127.0.0.1:8123"
```

5、使用 `curl ip.gs` 查看是否成功实现代理，若不成功，检查如下

* 本地和服务器防火墙是否开启，都没开启则跳过这项；本地防火墙开启的话，检查 8123 和 1080 端口是否开启 tcp；服务器防火墙开启的话，检查 v2ray 配置的端口是否开启 tcp，以上端口没开启的话，都要开启
* 登录 VPS 控制台，检查安全组（称呼不一，阿里云叫防火墙）里的 v2ray 端口是否开启 tcp
* 可以在本地使用 `paping -p port hostip` 检查服务器和本地端口开启情况
* 一般修改安全组，需要重启服务器才有效
* 设置了安全组就可以不设置云服务器防火墙，因为安全组规则相对于云服务器防火墙是在更上一层的拦截！比如，安全组开启了 10001 端口的 tcp，如果开启防火墙的服务器没有开启 10001 端口的 tcp ，外面也是无法连接的。

6、重启服务，再次使用 `curl ip.gs` 检查是否代理成功，不成功，就 Google！



