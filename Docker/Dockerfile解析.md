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

