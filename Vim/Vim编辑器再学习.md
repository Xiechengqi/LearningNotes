# Vim 编辑器再学习

> * 使用 Ubuntu 已经两年了，对于 Vim 的利用只能算是小半桶水水平，一直感觉利用 Vim 编程非常麻烦，几次尝试系统学习 Vim，并从此转换到 Vim 使用者一族，但都半途而废。现在终于下定决心，即使摸着石头也要过了这条 “河”。我认为这就好比当年从 Windows 迁移到 Linux 上，一开始一直犹犹豫豫，但后来看到一片令我茅塞顿开的文章，那天下午我就开始了 Linux 的生涯，凡事都要迈出第一步嘛！
> * 对于大多数用户来说，Vim 有着一个比较陡峭的学习曲线。这意味着开始学习的时候可能会进展缓慢，但是一旦掌握一些基本操作之后，能大幅度提高编辑效率。在Vim 用户手册中更加详细的描述了 Vim 的基础和进阶功能。可以在Vim中输入 `:help user-manual` 进入用户手册。手册除了原始的英文版本之外，也被志愿者翻译成了各国文字，其中包括中文。 --- Wiki
> * 通篇教程以 Ubuntu 18.04 LTS 为例

## 参考 && 扩展

> * [vim字符串替换及小技巧](https://blog.csdn.net/nitweihong/article/details/7221930)

## Vim 安装、卸载

> **Vim Github :** https://github.com/vim/vim

### 安装方法

> 安装很简单，方法如下，具体步骤百度、Google 一下即可

1. Github 源码安装
2. 本地软件源安装：`sudo apt install vim`
3. 添加软件源安装

### 卸载

> 卸载有些地方需要注意

1. 老版本 Vim 完全卸载

* 首先检查本地安装的 Vim 相关的软件

``` shell
dpkg -l | grep vim
```

* apt 卸载

``` shell
sudo apt-get remove vim
sudo apt-get remove vim-runtime
sudo apt-get remove vim -tiny
sudo apt-get remove vim-common
sudo apt-get remove vim-doc
sudo apt-get remove vim-scripts
```

2. 使用包管理器 apt 卸载

``` shell
# 卸载 Vim，只删除 Vim 包本身
sudo apt remove vim
# 卸载 Vim 及其依赖软件包
sudo apt remove --auto-remove vim
# 清除 Vim 配置/数据，注意清除的配置及数据无法恢复
sudo apt purge vim
# &
sudo apt purge --auto-remove vim
```

## Vim 的配置

### Vim 配置文件 - `vimrc`

1. 系统级 Vim 配置文件

* `/etc/vim/vimrc`
系统的每个用户在打开 Vim 时都会载入它
* `/usr/share/vim/vimrc`
是一个链接到 `/etc/vim/vimrc` 的链接文件
``` shell
lrwxrwxrwx 1 root root 14 Apr 11  2018 vimrc -> /etc/vim/vimrc
```
2. 用户级 Vim 配置文件

* ~/.vimrc

> * 在 Linux 和 Mac OS X 中，这个文件位于你的 home 文件夹，并以 `.vimrc` 命名；在 Windows 中，这个文件位于你的 home 文件夹，并以 `_vimrc`命名

> * 应该在这里编辑自己的 Vim 配置信息，**这个文件里不要有重复的配置**，比如 `filetype plugin indent on` 和 `filetype plugin on` `filetype indent on` 重复。之前直接复制了别人的部分配置，正巧就发生了上面的重复，直接导致 vim 缓冲区出现问题，导致无法正常打开文件，而且这样的错误很难发现排除

### VimScript - Vim 的自定义配置

1. 简介

* 一门用于定制 Vim 的脚本语言
* vimrc 和 Vim 中的插件（ .vim ）都是使用 Vim 脚本语言 - vimscript 编写的

2. Vimscript

> * VimScript 系统学习：http://learnvimscriptthehardway.onefloweroneworld.com/
> * [我的学习 VimScript 笔记](./VimScript学习.md)

**记录一些 vimrc 的技巧用法**

* 要让 .vimrc 变更内容生效，一般的做法是先保存 .vimrc 再重启 vim 。增加如下设置，可以实现保存 .vimrc (`:w`) 时自动重启加载
``` shell
autocmd BufWritePost $MYVIMRC source $MYVIMRC
```
* 设置 html / css / python 等文件的默认模板

1. 在`~/.vim/vimfiles`目录下建一个自定义后缀的模板文件，比如 template.html，在里面输入你自己想要初始化模板的内容 
2. 在 `~/.vimrc` 或 `/etc/vim/vimrc` 文件中添加
```
autocmd BufNewFile *.html 0r ~/.vim/vimfiles/template.html
```

* 支持中文不乱码
```
# 设置编码
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
```
> * 与 Vim 编码有关的变量包括：encoding、fileencoding、termencoding
>   * encoding 选项用于缓存的文本、寄存器、Vim 脚本文件等
>   * fileencoding 选项是 Vim 写入文件时采用的编码类型
>   * termencoding 选项表示输出到终端时采用的编码类型

* 显示空格和 tab 键
``` shell
set listchars=tab:>-,trail:-
```
> * Vim 编辑器中默认不显示文件中的 tab 和空格符，方便定位输入错误

* 括号自动补全

```
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i
```

## buffer \ tab \ windows 详解

> * A buffer is the in-memory text of a file
> * A window is a viewport on a buffer
> * A tab page is a collection of windows

## Buffer

> A buffer is an area of Vim’s memory used to hold text read from a file. In addition, an empty buffer with no associated file can be created to allow the entry of text. – vim.wikia
