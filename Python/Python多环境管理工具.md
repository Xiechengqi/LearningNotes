# Python 多环境管理工具

## Pyenv

> * https://github.com/pyenv/pyenv

> * 通过对 Python 版本进行管理，实现不同版本间的切换和使用

* 原理：通过改变环境变量实现 Python 多版本的切换




## Virtualenv

> * 通过创建虚拟隔离环境，实现系统 Python 环境和虚拟环境的 Python 隔离

* 原理：基于 Python 开发。在需要的地方使用 `virtualenv` 创建虚拟工作目录，使用时激活 - `source 虚拟工作目录/bin/activate`，然后安装的 Python 环境（标准库、第三方库等）都是只属于该目录，开发完成直接退出 - `deactivate` 即可回到系统环境

``` shell
# 安装
pip install virtualenv
```
