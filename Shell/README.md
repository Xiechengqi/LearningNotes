# Bash Shell 

> * [Bahs 脚本教程 - 阮一峰](https://wangdoc.com/bash/)
> * [运维职业中所用到的技能技巧知识](https://github.com/leops-china/leops-cheatsheet/tree/master/website/docs/cheatsheet)
> * [热门应用的常用配置](https://github.com/leops-china/leops-cheatsheet/tree/master/website/docs/conf)
> * [日常运维的常用脚本](https://github.com/leops-china/leops-cheatsheet/tree/master/website/docs/scripts)

* Bash 只有一种数据类型，就是字符串。不管用户输入什么数据，Bash 都视为字符串
* Bash 没有数据类型的概念，所有的变量值都是字符串


## Bash 规范

#### 目录路径变量带不带 `/`

* 写路径变量和用路径变量有个头痛的问题就是目录的路径变量最后有没有 `/`，虽然 Linux 对于路径中的多个 `/` 都会自动识别成一个，但在使用向 `rsync` 时候，就得纠结路径变量最后有没有 `/`
* 目前我的想法是所有路径变量都不用 '/' 结尾

#### 当 `rm -rf` 后包含变量时候必须谨慎

* 先来个及其危险的写法
``` shell
rm -rf /$fileName/
```
* 上面当 `$filename` 为空时候，就会直接执行 `rm -rf /`，如果你在生产服务器中某个脚本包含这样的代码，就是个定时炸弹！每每想到这个，就脊背发凉
* 比较保险的写法
``` shell
cd /$filename/ && rm -rf ./
```

## Bash 常用快捷键

| 命令    |    解释            | Command | 解释                 |
| :-----: | :----------------- | :-----: | :------------------- |
| Ctrl r  | 搜索使用过的命令   | Ctrl g  | 从 Ctrl r 搜索中退出 |
| Ctrl p  | 显示上一个命令，同向上 | Ctrl n  | 显示下一个命令，同向下 |
| Ctrl a  | 跳转行首           | Ctrl e  | 跳转行末             |
| Ctrl k  | 剪切至行末         | Ctrl u  | 剪切至行首           |
| Ctrl f  | 右移一个字符       | Ctrl b  | 左移一个字符         |
| Ctrl c  | 关闭一个前台进程   | Ctrl d  | 关闭当前 Shell 会话  |
| Ctrl w  | 剪切前一个单词     | Ctrl y  | 粘贴                 |
| Ctrl z  | 暂停正在运行的任务 | Ctrl h  | 删除前一个字符       |
| Ctrl s  | 锁定界面           | Ctrl q  | 解除锁定             |

## Bash 脚本调试工具 - bashdb


