# KVM 安装 Windows Server 2016

## 实验环境

* CentOS 7
* KVM

## 安装 windows 的 virtio 驱动

* 查看 virtio 软件包信息

``` shell
yum info virtio-win
已加载插件：fastestmirror
Determining fastest mirrors
 * base: mirrors.aliyuncs.com
 * extras: mirrors.aliyuncs.com
 * updates: mirrors.aliyuncs.com
错误：没有匹配的软件包可以列出
```

* 以上说明缺少 virtio-win 的 yum 软件源

1、使用 wget 下载 virtio-win.repo

``` shell
wget https://fedorapeople.org/groups/virt/virtio-win/virtio-win.repo -O /etc/yum.repos.d/virtio-win.repo

2、或手动添加 

```
vim /etc/yum.repos.d/virtio-win.repo
### 写入一下内容:
# virtio-win yum repo
# Details: https://fedoraproject.org/wiki/Windows_Virtio_Drivers
 
[virtio-win-stable]
name=virtio-win builds roughly matching what was shipped in latest RHEL
baseurl=http://fedorapeople.org/groups/virt/virtio-win/repo/stable
enabled=1
skip_if_unavailable=1
gpgcheck=0
 
[virtio-win-latest]
name=Latest virtio-win builds
baseurl=http://fedorapeople.org/groups/virt/virtio-win/repo/latest
enabled=0
skip_if_unavailable=1
gpgcheck=0
 
[virtio-win-source]
name=virtio-win source RPMs
baseurl=http://fedorapeople.org/groups/virt/virtio-win/repo/srpms
enabled=0
skip_if_unavailable=1
gpgcheck=0
```

* 再次执行

``` shell
# yum info virtio-win
已加载插件：fastestmirror
Loading mirror speeds from cached hostfile
 * base: mirrors.aliyuncs.com
 * extras: mirrors.aliyuncs.com
 * updates: mirrors.aliyuncs.com
base                                                                                                             | 3.6 kB  00:00:00
docker-ce-stable                                                                                                 | 3.5 kB  00:00:00
epel                                                                                                             | 4.7 kB  00:00:00
extras                                                                                                           | 2.9 kB  00:00:00
updates                                                                                                          | 2.9 kB  00:00:00
virtio-win-stable                                                                                                | 3.0 kB  00:00:00
(1/3): epel/x86_64/updateinfo                                                                                    | 1.0 MB  00:00:00
(2/3): epel/x86_64/primary_db                                                                                    | 6.8 MB  00:00:00
(3/3): virtio-win-stable/primary_db                                                                              | 2.7 kB  00:00:07
可安装的软件包
名称    ：virtio-win
架构    ：noarch
版本    ：0.1.171
发布    ：1
大小    ：64 M
源    ：virtio-win-stable
简介    ： VirtIO para-virtualized drivers for Windows(R)
网址    ：http://www.redhat.com/
协议    ： BSD and Apache and GPLv2
描述    ： VirtIO para-virtualized Windows(R) drivers for 32-bit and 64-bit
         : Windows(R) guests.
```

virt-install --name server2016 --memory 4096 --vcpus sockets=1,cores=2,threads=2 \
--disk device=cdrom,path=/kvm/iso/cn_windows_server_2016_x64_dvd_9718765.iso \
--disk device=cdrom,path=/usr/share/virtio-win/virtio-win.iso \
--disk path=/disk2/kvm/images/server2016.img,size=50,bus=virtio \
--network bridge=br0,model=virtio \
--noautoconsole --accelerate --hvm \
--graphics vnc,listen=0.0.0.0,port=20006 --video vga --input tablet,bus=usb --cpu host-passthrough

virt-install --name win2016 --virt-type kvm --hvm --os-type windows --memory 2048 --vcpus 1 \
--network bridge=br0,model=virtio \
--cdrom /data/iso/cn_windows_server_2016_x64_dvd_9718765.iso \
--disk path=/data/kvm/images/win2016.qcow2,bus=ide \
--graphics vnc 

root@cagetest-inner1:~# virt-install \
--name windows2016 \
--os-type=windows \
--ram=2048 --vcpus=2 \
--disk /data/kvm/win2016.qcow2,bus=virtio,size=50 \
--disk /data/iso/virtio-win-0.1.141_amd64.vfd,device=floppy \
--cdrom=/data/iso/cn_windows_server_2016_vl_x64_dvd_11636695.iso  \
--network bridge=br0,model=virtio \
--graphic vnc,listen=0.0.0.0,port=5905 \
--virt-type kvm


查看虚拟机的vnc端口号：virsh vncdisplay windows2016

显示虚拟机的xml信息：virsh dumpxml windows2016
