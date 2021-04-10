# Docker 命令解析

## 目录

* **[docker run](#docker-run)**
* **[docker image](#docker image)**



## docker run

* **`docker run -it --rm ubuntu:18.04 bash`**

> * `-i`：交互式操作
> * `-t`：终端
> * `--rm`：容器关闭自动删除，默认不会
> * `bash`：容器启动命令，bash 会进入容器终端



## docker image

* **`docker image ls -f dangling=true`** - 查看所有虚悬镜像（dangling image)

  ```bash
  REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
  <none>              <none>              00285df0df87        5 days ago          342 MB
  ```

* **`docker image purne`** - 删除虚悬镜像（未使用的镜像）

* **`docker image ls`** - 显示所有顶层镜像

* **`docker image ls -a`** - 显示所有镜像，包含中间层镜像

* **`docker image ls --digests`** - 显示镜像摘要

* **`docker image ls ubuntu`** - 显示部分镜像

* **`docker image ls -f since=mongo:3.2`** - 显示 mongo:3.2 之后建立的镜像，`-f` 全称 `--filter` 过滤器

* **`docker image ls -f before=mongo:3.2`** - 显示 mongo:3.2 之前建立的镜像

* **`docker image ls -q`** - 指输出镜像的 image ID

* **`docker image ls --format "{{.ID}}: {{.Repository}}"`** - 使用 `--format` 格式化输出。格式化输出只包含镜像ID和仓库名

* **`docker image ls --format "table {{.ID}}\t{{.Repository}}\t{{.Tag}}"`** - 等距显示，并且有标题行

* **`docker image rm [选项] <镜像1> [<镜像2> ...]`**

> * `<镜像>` 可以是 `镜像短 ID`、`镜像长 ID`、`镜像名` 或者 `镜像摘要`

* **`docker image rm $(docker image ls -q redis)`** - 删除所有仓库名是 `redis` 的镜像
* **`docker image rm $(docker image ls -q -f before=mongo:3.2)`** - 删除所有在 mongo:3.2 之前创建的镜像



## docker diff

* **`docker diff <容器>`** - 查看容器具体改动



## docker history

* **`docker history <镜像>`** - 查看镜像所有层

## docker commit

> **docker commit 可以用于保存容器现场，但不要使用它定制镜像，定制镜像应该使用 `Dockerfile` 来完成**

* **`docker commit [选项] <容器ID或容器名> [<仓库名>[:<标签>]]`** - 将运行中容器保存为镜像

``` shell
$ docker commit --author "Tao Wang <twang2218@gmail.com>" --message "修改了默认网页" webserver nginx:v2
sha256:07e33465974800ce65751acc279adc6ed2dc5ed4e0838f8b86f0c87aa1795214
```

> * `--author` - 修改作者
> * `--message` - 修改信息，可以省略

## docker build

* **`docker build [选项] <上下文路径/URL/->`**

> * **[镜像构建中的上下文](https://vuepress.mirror.docker-practice.com/image/build/#%E9%95%9C%E5%83%8F%E6%9E%84%E5%BB%BA%E4%B8%8A%E4%B8%8B%E6%96%87-context)**

* **`docker build -t hello-world https://github.com/docker-library/hello-world.git#master:amd64/hello-world`**  - 直接用 Git repo 进行构建，Docker 会 `git clone` 这个项目、切换到指定分支（这里是 master）、并进入到指定目录（这里是 amd64/hello-world）后开始构建
* **`docker build http://server/context.tar.gz`** - 用给定的 tar 压缩包构建，Docker 引擎会下载这个包，并自动解压缩，以其作为上下文，开始构建
* **`docker build - < Dockerfile`** 或 **`cat Dockerfile | docker build -`** - 从标准输入中读取 Dockerfile 进行构建
* **`docker build - < context.tar.gz`** -  从标准输入中读取上下文压缩包进行构建，标准输入的文件格式是 `gzip`、`bzip2` 以及 `xz` 的话，将会使其为上下文压缩包，直接将其展开，将里面视为上下文，并开始构建

## docker import

* **`docker import [选项] <文件>|<URL>|- [<仓库名>[:<标签>]]`**

> 压缩包可以是本地文件、远程 Web 文件，甚至是从标准输入中得到

* **`docker import http://download.openvz.org/template/precreated/ubuntu-16.04-x86_64.tar.gz openvz/ubuntu:16.04`** - 自动下载了 `ubuntu-16.04-x86_64.tar.gz` 文件，并且作为根文件系统展开导入，并保存为镜像 `openvz/ubuntu:16.04`



## docker save

* **`docker save alpine -o alpine.tar`** - 将镜像保存为归档文件
* **`docker save alpine | gzip > alpine-latest.tar.gz`** - 保存归档文件并解压

## docker load

* **`docker load -i alpine-latest.tar.gz`** - 加载镜像
* **`docker save <镜像名> | bzip2 | pv | ssh <用户名>@<主机名> 'cat | docker load'`** - 从一个机器将镜像迁移到另一个机器，并且带进度条的功能



## docker volume

* **`docker volume create my-vol`** - 创建数据卷
* **`docker volume ls`** - 查看所有数据卷
* **`docker volume inspect my-vol`** - 查看指定数据卷信息
* **`docker run -d -P --name web --mount source=my-vol,target=/usr/share/nginx/html nginx:alpine`** - 容器启动时挂载一个数据卷
* **`docker volume rm my-vol`** - 删除数据卷
* **`docker rm -v 容器名`** - 删除容器时一同删除挂载的数据卷，默认删除容器也不会删除数据卷
* **`docker volume prune`** - 删除未使用的数据卷

## docker inspect

* **`docker inspect 容器名`** - 查看指定容器信息

## docker logs

