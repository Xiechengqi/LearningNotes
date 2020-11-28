# Go 学习

## Go 相关环境变量

* 查看

``` shell
$ go env //打印Go所有默认环境变量
$ go env GOPATH //打印某个环境变量的值
```
* 常用环境变量详解
  * `GOROOT` - 表示 Go 语言的安装目录
  * `GOPATH` - 指定我们的开发工作区(workspace)，用于存放源代码、测试文件、库静态文件、可执行文件等
  * `GOBIN` - 表示我们开发程序编译后二进制命令的安装目录，一般我们将 `GOBIN` 设置为 `GOPATH/bin` 目录
  * `GOOS` - 操作系统，也可以是 windows、linux、darwin 等
  * `GOARCH` - CPU 架构，如 386、amd64、arm 等
> * `GOOS` 和 `GOARCH` 使 go 交叉编译其他平台的二进制制品十分方便

## Go 常用命令

**`go build`**
> * go 构建

``` shell
$ go build -o hello
```

**`go fmt`**
> * go 代码格式化

``` shell
$ go fmt main.go
```
