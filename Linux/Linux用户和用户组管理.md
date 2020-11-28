# Linux 用户和用户组管理



相关配置文件：

   /etc/passwd
       用户账户信息。

   /etc/shadow
       安全用户账户信息。

   /etc/group
       组账户信息。

   /etc/gshadow
       安全组账户信息

一台服务器至少应该设置两个用户，一个是 root,另外一个是拥有 root 权限的普通用户（通过配置 `/etc/sudoers` 可以实现），这样就能够保证一个密码出错后还可以通过另外一个用户登录服务器重置密码

chmod

chown

chgrp

useradd

userdel [username] - 删除 username 用户，但不删除该用户主目录

userdel -r [username] - 删除 username 用户，一并删除该用户主目录

groupadd

groupdel

passwd

gpasswd -a [username] [groupname] - 将用户 username 添加到 groupname 组

gpasswd -d [username] [groupname] - 将用户 username 从 groupname 组中删除

cat -n /etc/group | grep [groupname] - 单独查看 groupname 组信息

cat -n /etc/passwd | grep [username] - 单独查看 username 用户信息

id [username] - 查看 username 用户信息和该用户的组信息

usermod

suid/guid

**`useradd`**

**`userdel`**

**`usermod`**

**`groupadd`**

**`groupdel`**

**`groupmod`**

**`chmod`**
