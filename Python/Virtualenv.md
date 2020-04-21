# Virtualenv

* virtualenv 为应用提供了隔离的 Python 运行环境，解决了不同应用间多版本的冲突问题 

* 安装

```bash
# mac linux
$ sudo easy_install virtualenv
# or
$ sudo pip install virtualenv
# or Ubuntu
$ sudo apt install python-virtualenv
```

* 创建、启动、关闭 python virtualenv

**`创建`**

```bash
# 在当前目录下创建一个名为 venv 的 python virtualenv
$ virtualenv venv
Using base prefix '/usr'
  No LICENSE.txt / LICENSE found in source
New python executable in /root/Python/virtualenv/venv/bin/python3
Also creating executable in /root/Python/virtualenv/venv/bin/python
Installing setuptools, pip, wheel...
done.
```

**`启动`**

``` bash
$ . ./venv/bin/activate
# or
$ source ./venv/bin/activate
```

**`关闭`**

```bash
# 可以在任何目录执行
$ deactivate
```
