# Docker 小知识

## 目录

* [连接 docker 容器](#连接-docker-容器-top)
* [更换阿里云镜像](#更换阿里云镜像)







## 连接 docker 容器 [[Top]](目录)

1. Docker 原生命令连接容器

**`docker attach \[container\]`**

**`docker exec -i -t \[container\] /bin/bash`**

2. SSH 登录

3. 使用 nsenter、nsinit 等第三方工具

## 更换阿里云镜像

> * https://cr.console.aliyun.com/

`**CentOS**`
```
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://ykawlvjt.mirror.aliyuncs.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
```

`**Ubuntu**`
```
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://ykawlvjt.mirror.aliyuncs.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
```
