# SSH 详解

## 目录

* [SSH 介绍](#ssh-介绍-top)

* [应用篇](#应用篇-top)
  * [Linux SSH 相关命令](#linux-ssh-相关命令)
  * [SSH 密码或无密码( 密钥 )登录](#ssh-密码或无密码-密钥-登录)

* [原理篇](#原理篇-top)
  * [密码学加密算法](#密码学加密算法)
  * [SSH 登录原理](#ssh-登录原理)

* [SSH 中间人攻击](#ssh-中间人攻击-top)

## SSH 介绍 [[Top]](#目录)

* **Secure Shell**（安全外壳协议，简称 **SSH**）是一种加密的[网络传输协议](https://zh.wikipedia.org/wiki/网络传输协议)，可在不安全的网络中为网络服务提供安全的传输环境
* SSH 通过在网络中创建[安全隧道](https://zh.wikipedia.org/w/index.php?title=安全隧道&action=edit&redlink=1)来实现 SSH 客户端与服务器之间的连接
* 在设计上，SSH 是 [Telnet](https://zh.wikipedia.org/wiki/Telnet) 和非安全 [shell](https://zh.wikipedia.org/wiki/Unix_shell) 的替代品，Telnet 和 Berkeley [rlogin](https://zh.wikipedia.org/w/index.php?title=Rlogin&action=edit&redlink=1)、[rsh](https://zh.wikipedia.org/wiki/远程外壳)、[rexec ](https://zh.wikipedia.org/w/index.php?title=Rexec&action=edit&redlink=1)等协议采用[明文](https://zh.wikipedia.org/wiki/明文)传输，使用不可靠的密码，容易遭到监听、[嗅探](https://zh.wikipedia.org/wiki/數據包分析器)和[中间人攻击](https://zh.wikipedia.org/wiki/中间人攻击)
* SSH使用[客户端-服务器](https://zh.wikipedia.org/wiki/主從式架構)模型，标准端口为 22。服务器端需要开启SSH[守护进程](https://zh.wikipedia.org/wiki/守护进程)以便接受远端的连接，而用户需要使用 SSH 客户端与其创建连接
* SSH 的经典用途是登录到远程电脑中执行命令。除此之外，SSH 也支持[隧道协议](https://zh.wikipedia.org/wiki/隧道协议)、[端口映射](https://zh.wikipedia.org/wiki/端口映射)和 [X11](https://zh.wikipedia.org/wiki/X_Window系統) 连接。借助 [SFTP](https://zh.wikipedia.org/wiki/SSH文件传输协议) 或 [SCP](https://zh.wikipedia.org/wiki/安全复制) 协议，SSH 还可以传输文件

## 应用篇 [[Top]](#目录)

### Linux SSH 相关命令

**`ssh -v <user>@<hostip>`** - 打印运行情况和调试信息

**`ssh -vv <user>@<hostip>`** - 打印更详细的运行情况和调试信息

**`ssh -vvv <user>@<hostip>`** - 打印最详细的运行情况和调试信息

**`ssh -T git@xxx.com`** - 测试 ssh 密钥连接是否成功
> 比如测试 github: `ssh -T git@github.com`，gitee: `ssh -T git@gitee.com`

**`ssh <user>@<hostip>`** - 登录 host

**`ssh -J  <跳板机登录用户>@<ip>:<port> <目标机登录用户>@<ip> -p <port> `**- 通过跳板机登录目标机

> ssh 命令登录失败后，重试时总是卡住，一般在重试前先重启 sshd 服务就可以解决

**`ssh <user>@<hostip> <command>`** - 登录 host 直接执行命令

**`ssh <user>@<hostip> 'tar cz file' | tar zxv`** - 本地`~/file` 文件通过 ssh 加密传输到 hostip 的`~` 目录下

**`ssh <user>@<hostip> 'tar cz file' | tar xzv`** - hostip 的`~/file` 文件通过 ssh 加密传输到本地的 `~` 目录下

**`scp <local_file_path> <user>@<hostip>:<remote_folder_path>`** - 通过 scp 命令上传本地**文件**到远程

**`scp -r <local_file_path> <user>@<hostip>:<remote_folder_path>`** - 通过 scp 命令上传本地**文件夹**到远程

**`scp <user>@<hostip>:<remote_folder_path>  <local_file_path>`** - 通过 scp 命令传下载远程**文件**到本地

**`scp -r <user>@<hostip>:<remote_folder_path>  <local_file_path>`**- 通过 scp 命令传下载远程**文件**夹到本地

```
scp -o "ProxyCommand=nc -X connect -x proxy_ip:proxy_port %h %p"  filename  username@target_ip:/target_path
scp -o "ProxyCommand=nc -X connect -x 47.101.133.201:22 %h %p"  /home/xcq/test1  root@54.250.52.188:/root

```

**`ssh-keygen`** - 默认在`~/.ssh/` 下生成 RSA 公私密钥对

**`ssh-keygen -t dsa`** - 在`~/.ssh/` 下生成 dsa 公私密钥对

**`ssh-keygen -t rsa -C '电子邮箱'`**

**`ssh-keygen -f ~/.ssh/id_rsa -y > ~/.ssh/id_rsa.pub`** - 如果您有 OpenSSH 私钥（`id_rsa` 文件），则可以使用以下命令生成 OpenSSH 公钥文件
 

**`ssh-keyscan`**

**`ssh-add`**

**`ssh-keysign`**
**`ssh-copy-id <user>@<hostip>`**  -  默认将本地主机公钥 `~/.ssh/id_rsa.pub ` 添加到远程服务器 `<user>/.ssh/authorized_keys` 文件中，实现无密码登录

**`ssh-copy-id -i <公钥路径>/id_rsa.pub <user>@<hostip>`** - 将本地主机公钥 `公钥路径` 中的 `id_rsa.pub`  添加到远程服务器 `<user>/.ssh/authorized_keys`  文件中，实现无密码登录

**`/etc/ssh/ssh.config`** - 客户端配置文件

**`/etc/ssh/sshd.config`** - 服务的配置文件

* **`开启密钥认证登录`**

 ```bash
  # 开启密钥验证
  RSAAuthentication yes
  PubkeyAuthentication yes RSAAuthentication yes
  # 制定公钥文件路径
  AuthorsizedKeysFile $h/.ssh/authorized_keys
 ```

* **`关闭密码登录`** 

 ```bash
  PasswordAuthentication no
 ```

**`~/.ssh/known_hosts`** - 查看已知主机的公钥

* **`关闭 hostkeychecking，初次登录时不用输入 yes`**

 ```bash
  StrictHostKeyChecking no  
 ```

**`~/.ssh/authorized_keys`** - 存放需要密钥登录本机的 host 公钥

### SSH 密码或无密码( 密钥 )登录

* SSH 登录通常有**密码登录**和**密钥登录 ( 或无密码直接登录 )**

**`密码登录`**

* [云服务器创建配后置密码登录](https://github.com/Xiechengqi/XcqDailyLearningNotes/blob/master/Linux/VPS/AWS/lightsail.md)

**`无密码登录`**

1. 生成本地 RSA 或 DSA 密钥对

```bash
$ ssh-keygen
# 一路回车就可
# root 用户生成公私钥在：/root/.ssh/
# 非 root 用户：在自己主目录下的 .ssh/
```

2. 将本地公钥内容追加到远程服务器的`/root/.ssh/authorized_keys` 或 用户目录下的`.ssh/authorized_keys`

``` bash
# 也可以使用 ssh-copy-id
$ ssh-copy-id root@目标节点IP

# ssh-copy-id root@192.168.56.101
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/root/.ssh/id_rsa.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
root@192.168.56.101's password: 

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'root@192.168.56.101'"
and check to make sure that only the key(s) you wanted were added.
```

3. 重启 ssh, 退出再次登陆即可实现无密码登录

## 原理篇 [[Top]](#目录)

### 密码学加密算法

* 加密方法可以分为两大类，一类是单钥加密（ private key cryptography ），还有一类叫做双钥加密（ public key cryptography ）。前者的加密和解密过程都用同一套密码，后者的加密和解密过程用的是两套密码

> * 【mì yuè】读音下的“密钥”的意思：紧密的锁闭。这里的用法用了“密钥”的动词性质。
> * 【 mì yào】读音下的“密钥”的意思：密码学中的专有名词，指解密所需要的特殊代码。这里用了“密钥”的名词性

**`对称密钥加密 - Symmetric-key algorithm`** 

* 又称为对称加密、私钥加密、共享密钥加密、单钥加密

* 这类算法在加密和解密时使用相同的密钥，或是使用两个可以简单地相互推算的密钥，所以这被称为 "对称加密算法"
* 1976 年以前，所有的加密算法都使用 "对称加密算法"，通用的单钥加密算法为 DES（ Data Encryption Standard ）
* 在对称密钥加密的情况下，密钥只有一把，所以密钥的保存变得很重要。一旦密钥泄漏，密码也就被破解

**`公开密钥加密 - Public-key cryptography`**

* 又称为非对称加密 - asymmetric cryptography

* 公开密钥加密需要两个密钥，一个是公开密钥（ 加密使用 ），另一个是私有密钥（ 解密使用 ）

### SSH 原理简述

**`ssh 密码登录原理`**

<div align=center>
<img src="./images/sshPrinciple.png" /></br>
</div>

1. 用户使用`ssh user@host` 命令对远程主机发起登陆
2. 远程主机将自己的公钥返回给请求主机
3. 请求主机使用公钥对用户输入的密码进行加密
4. 请求主机将加密后的密码发送给远程主机
5. 远程主机使用私钥对密码进行解密
6. 最后，远程主机判断解密后的密码是否与用户密码一致，一致就同意登陆，否则反之

**`ssh 密钥登录原理`**

<div align=center>
<img src="./images/sshPubKeyLoginPrinciple.png" /></br>
</div>

1. 用户使用`ssh user@host` 命令对远程主机发起登陆
2. 远程主机对用户返回一个随机串
3. 用户所在主机使用私钥对这个随机串进行加密，并将加密的随机串返回至远程主机
4. 远程主机使用分发过来的公钥对加密随机串进行解密
5. 如果解密成功，就证明用户的登陆信息是正确的，则允许登陆；否则反之

### SSH 中间人攻击 [[Top]](#目录)

​    由于 SSH 不像 https 协议那样，SSH 协议的公钥是没有证书中心（CA）公证的，也就是说，都是自己签发的。这就导致如果有人截获了登陆请求，然后冒充远程主机，将伪造的公钥发给用户，那么用户很难辨别真伪，用户再通过伪造的公钥加密密码，再发送给冒充主机，此时冒充的主机就可以获取用户的登陆密码了，那么 SSH 的安全机制就荡然无存了，这也就是我们常说的中间人攻击

## 参考

* **[SSH Kung Fu](https://blog.tjll.net/ssh-kung-fu/)**

* [scp 跨机远程拷贝](https://linuxtools-rst.readthedocs.io/zh_CN/latest/tool/scp.html)

* [如何透过 SSH 代理穿越跳板机](https://www.hi-linux.com/posts/929.html)

* [数字签名是什么？- 阮一峰](http://www.ruanyifeng.com/blog/2011/08/what_is_a_digital_signature.html)
* [SSH原理与运用 - 阮一峰](http://www.ruanyifeng.com/blog/2011/12/ssh_remote_login.html)
* [SSH原理与运用（一）：远程登录 - 阮一峰](http://www.ruanyifeng.com/blog/2011/12/ssh_remote_login.html)
* [SSH原理与运用（二）：远程操作与端口转发 - 阮一峰](https://www.ruanyifeng.com/blog/2011/12/ssh_port_forwarding.html)

* [详解SSH原理 - 果冻想](https://www.jellythink.com/archives/555)
* [Linux ssh命令详解 - 小a玖拾柒](https://www.cnblogs.com/ftl1012/p/ssh.html)
