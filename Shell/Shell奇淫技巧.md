# Shell 奇淫技巧

> * [commandlinefu.com](https://www.commandlinefu.com/)

## 匹配变量名

`${!string*}`或`${!string@}`返回所有匹配给定字符串 string 的变量名

``` bash
$ echo ${!H*}
HADOOP_HOME HISTCMD HISTCONTROL HISTFILE HISTFILESIZE HISTSIZE HOME HOSTNAME HOSTTYPE
```

## 匹配除`.`和`..`文件的所有隐藏文件

``` bash
$ echo .[!.]*
.git .github .gitignore .nojekyll
```

## 计算字符串的长度

**`${#字符串}`**

``` bash
str="hello world!"
${#str}
12：未找到命令
```

## 通过 `username` 返回 github 用户所有的 repos

```bash
$ curl -s https://api.github.com/users/<username>/repos?per_page=1000 | grep git_url | awk '{print $2}' |  sed 's/"\(.*\)",/\1/'
```

```bash
$ curl -s "https://api.github.com/users/<username>/repos?per_page=1000" | jq '.[].git_url'
```

```bash
$ curl -s "https://api.github.com/users/<username>/repos?per_page=1000" | python <(echo "import json,sys;v=json.load(sys.stdin);for i in v:; print(i['git_url']);" | tr ';' '\n')
```

```bash
$ curl -s https://api.github.com/users/<username>/repos?per_page=1000 | grep -oP '(?<="git_url": ").*(?="\,)'
```

## 显示所有进程的端口和 pid

```bash
$ ss -plunt
```

## 单行显示所有可更新的 deb 包

```bash
$ apt list --upgradable | grep -v 'Listing...' | cut -d/ -f1 | tr '\r\n' ' ' | sed '$s/ $/\n/'
```

