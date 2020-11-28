# Github Actions 学习

> * [Github 官方文档](https://help.github.com/en/articles/workflow-syntax-for-github-actions)
> * [Github Actions 入门教程 - 阮一峰](http://www.ruanyifeng.com/blog/2019/09/getting-started-with-github-actions.html)
> * [Github awesome actions 项目](https://github.com/sdras/awesome-actions)
> * [Github Actions 通过 SSH 自动备份到代码托管网站](https://blog.csdn.net/z_johnny/article/details/104061608)
> * [GitHub action for deploying a project to GitHub pages](https://github.com/JamesIves/github-pages-deploy-action)

## 基础知识

Github Action 其实就是通过编写项目根目录下 `.github/workflow/xxx.yml` 配置文件，触发 Github 提供的 docker 虚拟机完成 CI 和 CD

### 定时任务

### 手动点击 star 触发 CI

### 使用 ssh 私钥同步部署到 github、gitee、coding 等代码托管平台或远程服务器、对象存储等


## QA

1、Github Actions 设置 serects(`SSH_PRIVATE_KEY`) 时必须完全复制粘贴 `~/.ssh/id_rsa` 内容

``` bash
# 包括 BEGIN 和 END 行
-----BEGIN RSA PRIVATE KEY-----
......
-----END RSA PRIVATE KEY-----
```
