## 配置 `root passwd `登录

* 首先使用 Google Cloud SSH 连接上去
* 切换到 root：`sudo -i`
* 编辑 ssh 配置文件：`vim /etc/ssh/sshd_config`
* 修改以下内容即可
```
PermitRootLogin yes
PasswordAuthentication yes
```
* 重启 ssh：`service sshd restart`
