> YouCompleteMe 一开始折腾 Vundle 时就想装，第一次安装耗时 2 天，浏览器导航条开页面开的只有一条图标了，还是没装上，装到怀疑人生！后来又反反复复折腾了两三次，又没装上！今天，改变策略，“啃”英文手册，豁然开朗！有时候 Google 搜索再多不如一步一步照着文档来，思维定式，认为中文安装博客很多，随便就装上了，但每个人安装环境都不一样，即使操作系统一样也没用！**以后安装只看官方文档了！！！**

## 预备环境

* Ubuntu 18.04
* Vundle
* vim  >= 7.4.1578 
```
vim
:version
```
* YoucompleteMe git 库 - https://github.com/ycm-core/YouCompleteMe.git - <kbd>浏览器翻墙下，命令行下要人命</kbd>
* 其他需要用到再加

## 流程

1. 在 <kbd>~/.vimrc</kbd> 的 Vundle Plugin 中加入：`Plugin 'Valloric/YouCompleteMe'`
> * 不要运行 `:PluginInstall` 或 `:PluginUpdate`，不然就卡那了
2. 下载解压生成 Youcomplete git 库到 <kbd>~/.vim/bundle/YoucompleteMe/<\kbd>
3. `cd  ~/.vim/bundle/YoucompleteMe/`
4. 安装 YCM 依赖：`git submodule update --init --recursive`
> * 较慢，逃不掉的
5. 之后需要针对是否支持 C 语言家族、Java、JavaScript、Go 等等安装不同依赖和执行不同编译操作

### 不指定语言

``` shell
cd ~/.vim/bundle/YouCompleteMe
./install.py
```

### C Family

> * 预备环境
  > * libclang >= 9.0.0
  > * clangd >= 9.0.0  http://releases.llvm.org/download.html
