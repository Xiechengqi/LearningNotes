

> * 构建镜像 与 `Dockerfile` 语法 - https://juejin.cn/post/6874551682559115277
> * 深入理解 Docker 构建上下文 - https://blog.csdn.net/qianghaohao/article/details/87554255
> * [为什么需要.dockerignore及最佳实践](https://my.oschina.net/andChow/blog/3078351)



## `.dockerignore` 文件

`.dockerignore`是一个类似 `.gitignore` 的文件，用于在构建上下文时忽略某些文件，它支持正则和通配符，它的规则定义如下

``` shell
# 语法

#	注释
*	匹配0或多个非/的字符
?	匹配1个非/的字符
**	0个或多个目录
!	除...外，需结合上下文语义

# 除README*.md外，所有其他md文件(包括README-secret.md)都被docker忽
*.md
!README*.md
README-secret.md
```

