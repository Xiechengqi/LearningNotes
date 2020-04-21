# Flask 学习

### 安装

* 依赖：[Werkzeug](http://werkzeug.pocoo.org/) 和 [Jinja2](http://jinja.pocoo.org/2/) 
  * Werkzeug 是一个 WSGI（在 Web 应用和多种服务器之间的标准 Python 接口) 工具集
  * Jinja2 负责渲染模板

* 安装最新 Flask 库

```bash
$ git clone http://github.com/mitsuhiko/flask.git
Initialized empty Git repository in ~/dev/flask/.git/
$ cd flask
$ virtualenv venv --distribute
New python executable in venv/bin/python
Installing distribute............done.
$ . venv/bin/activate
$ python setup.py develop
...
Finished processing dependencies for Flask
# 这会拉取依赖并激活 git head 作为 virtualenv 中的当前版本。然后你只需要执行 git pull origin 来升级到最新版本
```

