# 安装 rdesktop 

> 最近需要使用 rdesktop 远程连接公司的 windows server，一直在用 rdesktop，但最近总是报“核心已转储”的错，搜了一圈发现竟然是最新版本的 rdesktop 存在 bug，需要安装旧版本的 rdesktop，并阻止其自动升级到故障版本

## 卸载并安装稳定的旧版本

``` shell
sudo apt purge rdesktop
wget http://mirrors.ustc.edu.cn/ubuntu/pool/universe/r/rdesktop/rdesktop_1.8.3-1_amd64.deb
sudo dpkg -i rdesktop_1.8.3-1_amd64.deb
```

## 暂时阻止 rdesktop 升级到故障版本

``` shell
sudo apt-mark hold rdesktop
```

## 查看被锁定的软件包

``` shell
dpkg --get-selections | grep hold
```

## 解除软件包的锁定

``` shell
sudo apt-mark unhold rdesktop
```
