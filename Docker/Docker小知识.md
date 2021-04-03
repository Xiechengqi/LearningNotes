# Docker 小知识

## 目录

* [虚悬镜像](#虚悬镜像)

* [连接 docker 容器](#连接-docker-容器)
* [更换阿里云镜像](#更换阿里云镜像)





## 虚悬镜像

* 新旧镜像同名，旧镜像名称被取消，从而出现仓库名、标签均为 `<none>` 的镜像。这类无标签镜像也被称为 **虚悬镜像(dangling image)** 

``` shell
# 查看虚悬镜像
$ docker image ls -f dangling=true
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
<none>              <none>              00285df0df87        5 days ago          342 MB

# 删除虚悬镜像
$ docker image prune
```



## 连接 docker 容器

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
