# Dockerfile 解析

* Dockerfile 是一个文本文件，其内包含了一条条的 指令(Instruction)，每一条指令构建一层，因此每一条指令的内容，就是描述该层应当如何构建
* 镜像是多层存储，每一层的东西并不会在下一层被删除，会一直跟随着镜像。因此镜像构建时，一定要确保每一层只添加真正需要添加的东西，任何无关的东西都应该清理掉
* `docker build` 过程中会启动一个临时容器，执行所有 RUN 指令，之后 `docker commit` 将容器报错为镜像，最后删除临时容器

## 常用指令

### `FROM`

* 基础镜像，必须是第一行指令

### `RUN`

* 命令指令

* shell 格式：**`RUN <shell 命令>`**

> Dockerfile 支持 Shell 类的 RUN 行尾添加 `\` 的命令换行方式，以及行首 `#` 进行注释的格式

``` yaml
RUN echo '<h1>Hello, Docker!</h1>' > /usr/share/nginx/html/index.html
```

* exec 格式：**`RUN ["可执行文件", "参数1", "参数2"]`**

``` yaml

```

### `COPY`

* `COPY` 指令将从构建上下文目录中 `<源路径>` 的文件/目录复制到新的一层的镜像内的 `<目标路径>` 位置
* **`<源路径>`** 是以构建上下文路径的**相对路径**，**`<目标路径>`** 可以是容器内的绝对路径，也可以是相对于工作目录的相对路径（工作目录可以用 `WORKDIR` 指令来指定）
* 命令行格式: **`COPY [--chown=<user>:<group>] <源路径>... <目标路径>`**

``` yaml
COPY package.json /usr/src/app/
```

- 函数调用格式: **`COPY [--chown=<user>:<group>] ["<源路径1>",... "<目标路径>"]`**
- **`COPY hom* /mydir/`** - 使用通配符
- **`COPY --chown=55:mygroup files* /mydir/`** - 使用 `--chown=<user>:<group>` 选项来改变文件的所属用户及所属组

## `ADD`

> `ADD` 指令和 `COPY` 的格式和性质基本一致。但是在 `COPY` 基础上增加了一些功能

* ADD 的 `<源路径>` 可以是 URL 或压缩包，分别会自动下载和解压到 `<目标路径>`，下载后文件默认是 600 权限
* 官方最佳实践推荐尽量使用 `COPY` 完成复制文件，因为 `COPY` 的语义很明确，就是复制文件而已，而 `ADD` 则包含了更复杂的功能，其行为也不一定很清晰。最适合使用 `ADD` 的场合，就是需要自动解压缩的场合
* `ADD` 指令会令镜像构建缓存失效，从而可能会令镜像构建变得比较缓慢
* 因此在 `COPY` 和 `ADD` 指令中选择的时候，可以遵循这样的原则，**所有的文件复制均使用 `COPY` 指令，仅在需要自动解压缩的场合使用 `ADD`**
* **`ADD --chown=55:mygroup files* /mydir/·`** - ADD 也可使用 `--chown=<user>:<group>` 选项来改变文件的所属用户及所属组

### `CMD`

- shell 格式：**`CMD <shell 命令>`**

> shell 格式实际的命令会被包装为 `sh -c` 的参数的形式进行执行，例如 `CMD echo $HOME` 会被解析成 `CMD [ "sh", "-c", "echo $HOME" ]` 执行

- exec 格式：**`CMD ["可执行文件", "参数1", "参数2"...]`**

> exec 格式在解析时会被解析为 JSON 数组，因此一定要使用双引号 `"`，而不要使用单引号

``` yaml
# 容器是以前台运行程序的

# nginx 错误启动 CMD 写法
CMD service nginx start
# 或
CMD ["sh", "-c", "service nginx start"]

# nginx 正确启动 CMD 写法。直接执行 nginx 可执行文件，并且要求以前台形式运行
CMD ["nginx", "-g", "daemon off;"]
```



### `ENTRYPOINT`

> * **[有了 CMD，为什么还要 ENTRYPOINT? ENTRYPOINT 使用场景](https://vuepress.mirror.docker-practice.com/image/dockerfile/entrypoint/)**

* `ENTRYPOINT` 的目的和 `CMD` 一样，都是在指定容器启动程序及参数
* 当指定了 `ENTRYPOINT` 后，`CMD` 的含义就发生了改变，不再是直接的运行其命令，而是将 `CMD` 的内容作为参数传给 `ENTRYPOINT` 指令

### `ENV`

* 使用 `ENV` 设置的环境变量将一直存在于构建镜像时以及镜像容器运行时，可以使用 `docker inspect` 查看设置变量

- 空格格式: **`ENV <key> <value>`**
- 赋值格式: **`ENV <key1>=<value1> <key2>=<value2>...`**

``` yaml
ENV VERSION=1.0 DEBUG=on NAME="Happy Feet"
```

### `ARG`

* `ARG` 设置的变量只存在于镜像构建的时候，一旦镜像构建完成就失效了

* 格式: **`ARG <参数名>[=<默认值>]`**

* 默认值可以在构建命令 `docker build` 中用 `--build-arg <参数名>=<值>` 来覆盖



> * **只在构建镜像时用到的环境变量，使用 `ARG`；若容器运行时也用到才使用 `ENV`**
> * **使用 `ENV` 指令定义的环境变量会覆盖同名的 `ARG` 指令定义的变量**
> * **在多阶段构建过程中，可以在 `FROM` 之前定义 `ARG`，这样定义的变量只能用在所有的 `FROM` 指令中间

``` yaml
# 多阶段构建
ARG DOCKER_USERNAME=library
FROM ${DOCKER_USERNAME}/alpine
# 在FROM 之后使用变量，必须在每个阶段分别指定
ARG DOCKER_USERNAME=library
RUN set -x ; echo ${DOCKER_USERNAME}
FROM ${DOCKER_USERNAME}/alpine
# 在FROM 之后使用变量，必须在每个阶段分别指定
ARG DOCKER_USERNAME=library
RUN set -x ; echo ${DOCKER_USERNAME}
```

### `VOLUME`

* 为了防止运行时用户忘记将动态文件所保存目录挂载为卷，在 `Dockerfile` 中，我们可以事先指定某些目录挂载为匿名卷，这样在运行时如果用户不指定挂载，其应用也可以正常运行，不会向容器存储层写入大量数据

- 格式: **`VOLUME ["<路径1>", "<路径2>"...]`**
- **`VOLUME /data`** - 这里的 `/data` 目录就会在容器运行时自动挂载为匿名卷，任何向 `/data` 中写入的信息都不会记录进容器存储层，从而保证了容器存储层的无状态化
- 运行容器时可以覆盖 `VOLUME` 设置的挂载，例如：**`docker run -d -v mydata:/data xxxx`**

### `EXPOSE`

* 声明容器运行时提供服务的端口
* **`EXPOSE <端口1> [<端口2>...]`**
* **`docker run -P xxx`** - 自动随机映射 EXPOSE 的端口

### `WORKDIR`

* 指定之后指令的工作目录，若目录不存在则自动创建
* **`WORKDIR <工作目录路径>**`

### `USER`

* 指定之后指令执行的用户，若用户不存在，则无法切换。所以需要提前创建好用户
* **`USER <用户名>[:<用户组>]`**

### `HEALTHCHECK`

* 判断容器的状态是否正常
* **`HEALTHCHECK [选项] CMD <命令>`** - 设置检查容器健康状况的命令
* **`HEALTHCHECK NONE`** - 如果基础镜像有健康检查指令，使用这行可以屏蔽掉其健康检查指令

``` yaml
FROM nginx
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
HEALTHCHECK --interval=5s --timeout=3s CMD curl -fs http://localhost/ || exit 1
```

### `ONBUILD`


* **`ONBUILD <其它指令>`**






## Demo

### Redis

``` yaml
FROM debian:stretch

RUN set -x; buildDeps='gcc libc6-dev make wget' \
    && apt-get update \
    && apt-get install -y $buildDeps \
    && wget -O redis.tar.gz "http://download.redis.io/releases/redis-5.0.3.tar.gz" \
    && mkdir -p /usr/src/redis \
    && tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1 \
    && make -C /usr/src/redis \
    && make -C /usr/src/redis install \
    && rm -rf /var/lib/apt/lists/* \
    && rm redis.tar.gz \
    && rm -r /usr/src/redis \
    && apt-get purge -y --auto-remove $buildDeps
```



### Node

``` yaml
ENV NODE_VERSION 7.2.0

RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" \
  && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
  && gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc \
  && grep " node-v$NODE_VERSION-linux-x64.tar.xz\$" SHASUMS256.txt | sha256sum -c - \
  && tar -xJf "node-v$NODE_VERSION-linux-x64.tar.xz" -C /usr/local --strip-components=1 \
  && rm "node-v$NODE_VERSION-linux-x64.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt \
  && ln -s /usr/local/bin/node /usr/local/bin/nodejs
```

