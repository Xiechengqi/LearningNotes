# GitLab CI 学习

## 目录

* **[GitLab Runner](#gitlab-runner)**

* **[pipeline、stages、stage 和 job 关系](#pipelinestagesstage-和-job-关系)**



## GitLab Runner

> * **[GitLab-CI与GitLab-Runner](https://www.jianshu.com/p/2b43151fb92e)**
> * **[Gitlab-Runner原理与实现](https://blog.csdn.net/yejingtao703/article/details/83065591)**

* GitLab-Runner 就是一个用来执行软件集成脚本的东西。你可以想象一下：Runner 就像一个个的工人，而 GitLab-CI 就是这些工人的一个管理中心，所有工人都要在 GitLab-CI 里面登记注册，并且表明自己是为哪个工程服务的。当相应的工程发生变化时，GitLab-CI 就会通知相应的工人执行 CI 脚本
* GitLab 与 GitLab Runner 的版本需要匹配使用，如果版本不匹配会出现 runner 无法注册、runner 注册后无法连接、runner 无法运行 executor 等一系列莫名其妙的错误

![](./images/gitlab-ci-0.jpg)

### GitLab Runner 安装





### Shared Runner 和 Specific Runner

> GitLab-Runner 可以分类两种类型：**Shared Runner（共享型）**和**Specific Runner（指定型）**

* **Shared Runner：**这种 Runner（工人）是所有工程都能够用的。只有系统管理员能够创建 Shared Runner。
* **Specific Runner：**这种 Runner（工人）只能为指定的工程服务。拥有该工程访问权限的人都能够为该工程创建 specific runner

* 什么情况下需要注册Shared Runner？

 比如，GitLab上面所有的工程都有可能需要在公司的服务器上进行编译、测试、部署等工作，这个时候注册一个Shared Runner供所有工程使用就很合适。

* 什么情况下需要注册Specific Runner？

比如，我可能需要在我个人的电脑或者服务器上自动构建我参与的某个工程，这个时候注册一个Specific Runner就很合适。

* 什么情况下需要在同一台机器上注册多个Runner？

 比如，我是GitLab的普通用户，没有管理员权限，我同时参与多个项目，那我就需要为我的所有项目都注册一个Specific Runner，这个时候就需要在同一台机器上注册多个Runner



作者：tsyeyuanfeng
链接：https://www.jianshu.com/p/2b43151fb92e
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

## pipeline、stage 和 job 关系

* commit 或 merge request 等可以触发 pipeline

``` shell
+------------------+           +----------------+
|                  |  trigger  |                |
|   Commit / MR    +---------->+    Pipeline    |
|                  |           |                |
+------------------+           +----------------+
```

* stage 是 pipeline 构建阶段
  * 所有 Stage 顺序运行，即当一个 Stage 完成后，下一个 Stage 才会开始
  * 只有当所有 Stage 完成后，该构建任务 (Pipeline) 才会成功
  * 如果任何一个 Stage 失败，那么后面的 Stage 不会执行，该构建任务 (Pipeline) 失败

``` shell
+--------------------------------------------------------+
|                                                        |
|  Pipeline                                              |
|                                                        |
|  +-----------+     +------------+      +------------+  |
|  |  Stage 1  |---->|   Stage 2  |----->|   Stage 3  |  |
|  +-----------+     +------------+      +------------+  |
|                                                        |
+--------------------------------------------------------+
```

* job 是 stage 中真正执行构建的代码块
  * 相同 Stage 中的 Jobs 会并行执行
  * 相同 Stage 中的 Jobs 都执行成功时，该 Stage 才会成功
  * 如果任何一个 Job 失败，那么该 Stage 失败，即该构建任务 (Pipeline) 失败

``` shell
+------------------------------------------+
|                                          |
|  Stage 1                                 |
|                                          |
|  +---------+  +---------+  +---------+   |
|  |  Job 1  |  |  Job 2  |  |  Job 3  |   |
|  +---------+  +---------+  +---------+   |
|                                          |
+------------------------------------------+
```

