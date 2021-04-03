# GitLab CI 学习

## 目录

* **[GitLab-CI 变量](#gitlab-ci-变量)**

* **[GitLab Runner](#gitlab-runner)**

* **[pipeline、stages、stage 和 job 关系](#pipelinestagesstage-和-job-关系)**



## GitLab-CI 变量

> * **[Syntax of CI/CD variables in job scripts](https://docs.gitlab.com/ce/ci/variables/README.html#syntax-of-cicd-variables-in-job-scripts)**

* GitLab CI 两种变量
  * **[Custom variables](https://docs.gitlab.com/ce/ci/variables/README.html#custom-cicd-variables)**: 自定义变量
  * **[Predefined variables](https://docs.gitlab.com/ce/ci/variables/predefined_variables.html)**: GitLab 预定义变量

### 预定义变量

* 在 `script` 下使用 `export` 可以输出所有环境变量

``` shell
# 查看 gitlab pipeline 输入
$ export
declare -x CI="true"
declare -x CI_API_V4_URL="http://gitlab.paraview.cn/api/v4"
declare -x CI_BUILDS_DIR="/home/gitlab-runner/builds"
declare -x CI_BUILD_BEFORE_SHA="14b7725c81135245fba949cbe9ec84bf205fe573"
declare -x CI_BUILD_ID="1565"
declare -x CI_BUILD_NAME="build-code-job"
declare -x CI_BUILD_REF="6a14c3b51dcdd013de8cf5997a84aa0966c3bd1d"
declare -x CI_BUILD_REF_NAME="master"
declare -x CI_BUILD_REF_SLUG="master"
declare -x CI_BUILD_STAGE="build"
declare -x CI_BUILD_TOKEN="[MASKED]"
declare -x CI_COMMIT_BEFORE_SHA="14b7725c81135245fba949cbe9ec84bf205fe573"
declare -x CI_COMMIT_BRANCH="master"
declare -x CI_COMMIT_DESCRIPTION=""
declare -x CI_COMMIT_MESSAGE="Update .gitlab-ci.yml"
declare -x CI_COMMIT_REF_NAME="master"
declare -x CI_COMMIT_REF_PROTECTED="true"
declare -x CI_COMMIT_REF_SLUG="master"
declare -x CI_COMMIT_SHA="6a14c3b51dcdd013de8cf5997a84aa0966c3bd1d"
declare -x CI_COMMIT_SHORT_SHA="6a14c3b5"
declare -x CI_COMMIT_TITLE="Update .gitlab-ci.yml"
declare -x CI_CONCURRENT_ID="0"
declare -x CI_CONCURRENT_PROJECT_ID="0"
declare -x CI_CONFIG_PATH=".gitlab-ci.yml"
declare -x CI_DEFAULT_BRANCH="master"
declare -x CI_JOB_ID="1565"
declare -x CI_JOB_JWT="[MASKED]"
declare -x CI_JOB_NAME="build-code-job"
declare -x CI_JOB_STAGE="build"
declare -x CI_JOB_STATUS="running"
declare -x CI_JOB_TOKEN="[MASKED]"
declare -x CI_JOB_URL="http://gitlab.paraview.cn/devops/pipeline/-/jobs/1565"
declare -x CI_NODE_TOTAL="1"
declare -x CI_PAGES_DOMAIN="example.com"
declare -x CI_PAGES_URL="http://devops.example.com/pipeline"
declare -x CI_PIPELINE_ID="253"
declare -x CI_PIPELINE_IID="24"
declare -x CI_PIPELINE_SOURCE="push"
declare -x CI_PIPELINE_URL="http://gitlab.paraview.cn/devops/pipeline/-/pipelines/253"
declare -x CI_PROJECT_DIR="/home/gitlab-runner/builds/nUYFnZsC/0/devops/pipeline"
declare -x CI_PROJECT_ID="743"
declare -x CI_PROJECT_NAME="pipeline"
declare -x CI_PROJECT_NAMESPACE="devops"
declare -x CI_PROJECT_PATH="devops/pipeline"
declare -x CI_PROJECT_PATH_SLUG="devops-pipeline"
declare -x CI_PROJECT_REPOSITORY_LANGUAGES="groovy,html,shell,css,python"
declare -x CI_PROJECT_ROOT_NAMESPACE="devops"
declare -x CI_PROJECT_TITLE="pipeline"
declare -x CI_PROJECT_URL="http://gitlab.paraview.cn/devops/pipeline"
declare -x CI_PROJECT_VISIBILITY="private"
declare -x CI_REGISTRY_PASSWORD="[MASKED]"
declare -x CI_REGISTRY_USER="gitlab-ci-token"
declare -x CI_REPOSITORY_URL="http://gitlab-ci-token:[MASKED]@gitlab.paraview.cn/devops/pipeline.git"
declare -x CI_RUNNER_DESCRIPTION="javaBuildMachine"
declare -x CI_RUNNER_EXECUTABLE_ARCH="linux/amd64"
declare -x CI_RUNNER_ID="3"
declare -x CI_RUNNER_REVISION="54944146"
declare -x CI_RUNNER_SHORT_TOKEN="nUYFnZsC"
declare -x CI_RUNNER_TAGS="java"
declare -x CI_RUNNER_VERSION="13.10.0"
declare -x CI_SERVER="yes"
declare -x CI_SERVER_HOST="gitlab.paraview.cn"
declare -x CI_SERVER_NAME="GitLab"
declare -x CI_SERVER_PORT="80"
declare -x CI_SERVER_PROTOCOL="http"
declare -x CI_SERVER_REVISION="15c2c8c66db"
declare -x CI_SERVER_URL="http://gitlab.paraview.cn"
declare -x CI_SERVER_VERSION="13.3.6"
declare -x CI_SERVER_VERSION_MAJOR="13"
declare -x CI_SERVER_VERSION_MINOR="3"
declare -x CI_SERVER_VERSION_PATCH="6"
declare -x CI_SHARED_ENVIRONMENT="true"
```



### 自定义变量

* 自定义变量有两种方式：
* 值只能是 **整型** 和 **字符串** 类型
* 定义再 pipeline 最上面，作用域为全局；定义在 job 内，作用域为当前 job。job 内同名的变量会覆盖全局的变量

## GitLab Runner

> * **[GitLab-CI 与 GitLab-Runner](https://www.jianshu.com/p/2b43151fb92e)**
> * **[Gitlab-Runner 原理与实现](https://blog.csdn.net/yejingtao703/article/details/83065591)**

* GitLab-Runner 就是一个用来执行软件集成脚本的东西。你可以想象一下：Runner 就像一个个的工人，而 GitLab-CI 就是这些工人的一个管理中心，所有工人都要在 GitLab-CI 里面登记注册，并且表明自己是为哪个工程服务的。当相应的工程发生变化时，GitLab-CI 就会通知相应的工人执行 CI 脚本
* GitLab 与 GitLab Runner 的版本需要匹配使用，如果版本不匹配会出现 runner 无法注册、runner 注册后无法连接、runner 无法运行 executor 等一系列莫名其妙的错误

![](./images/gitlab-ci-0.jpg)

### GitLab Runner 安装



### GitLab Runner 配置文件

* `~/.gitlab-runner/config.toml` - Linux 非 root 用户配置文件
* `/etc/gitlab-runner/config.toml` - Linux root 用户配置文件
* `./config.toml` - 非 Linux 配置文件



### GitLab Runner 命令

> * **[GitLab Runner commands](https://gitlab.com/gitlab-org/gitlab-runner/-/blob/master/docs/commands/README.md)**

``` shell
# 查看帮助
gitlab-runner --help / gitlab-runner <command> --help

# 调试模式运行
gitlab-runner --debug <command>

# 默认交互模式下使用，非交互模式添加 --non-interactive
gitlab-runner register  

# 此命令列出了保存在配置文件中的所有运行程序
gitlab-runner list

# 此命令检查注册的 runner 是否可以连接，但不验证 GitLab 服务是否正在使用runner。--delete 删除
gitlab-runner verify

# 该命令使用 GitLab 取消已注册的 runner
gitlab-runner unregister

# 使用 token 注销
gitlab-runner unregister --url http://gitlab.example.com/ --token t0k3n

# 使用名称注销（同名删除第一个）
gitlab-runner unregister --name test-runner

# 注销所有
gitlab-runner unregister --all-runners

# 将 gitlab-runner 注册为 service，使用 systemctl status gitlab-runner 管理
gitlab-runner install

# 去掉 gitlab-runner service
gitlab-runner uninstall

# 常规操作 gitlab-runner
gitlab-runner status | start | stop | restart
```

#### 注册 GitLab Runner

![](./images/GitLab-Runner-0.jpg)

**`交互式注册`**

* 格式：**`gitlab-runner regesitry 参数`**

``` shell
$ sudo gitlab-runner register

# 也可以提前传入
$ sudo gitlab-runner register --name my-runner --url http://gitlab.example.com --registration-token my-registration-token
# 或
$ export CI_SERVER_URL=http://gitlab.example.com
$ export RUNNER_NAME=my-runner
$ export REGISTRATION_TOKEN=my-registration-token
$ export REGISTER_NON_INTERACTIVE=true
$ sudo gitlab-runner register

```

`参数`

* `--non-interactivec` - 非交互式注册，默认是交互式
* `--executor "shell"` - 执行器
* `--url "http://gitlab.paraview.cn/"` - GitLab 地址
* `--registration-token "yhiarw4saBG-EzAC-vzT"` - 注册 token
* `--description "devops-runner"` - 描述
* ` --tag-list "build,deploy"` - tag 列表
* `--run-untagged="true"`
* `--locked="false"` - 
* `--access-level="not_protected"` - 
* `--template-config /tmp/test-config.template.toml` -
* `--docker-image ruby:2.6` - 

**`非交互式注册`**

* 格式：**`gitlab-runner regesitry --non-interactive 参数`**

``` shell
$ sudo gitlab-runner register \
  --non-interactive \
  --url "https://gitlab.com" \
  --registration-token "$REGISTRATION_TOKEN" \
  --template-config /tmp/test-config.template.toml \
  --description "gitlab-ce-ruby-2.6" \
  --executor "docker" \
  --docker-image ruby:2.6


export REGISTER_NON_INTERACTIVE=true
gitlab-runner register
```




#### 删除 GitLab Runner

``` shell
# 先取消注册
gitlab-runner unregister --url http://gitlab.paraview.cn --token _ww3Rk4HZmTvyfy9JnRo

# 再删除
root@javaBuildMachine:~# gitlab-runner verify
Runtime platform                                    arch=amd64 os=linux pid=18494 revision=54944146 version=13.10.0
Running in system-mode.                            
                                                   
ERROR: Verifying runner... is removed               runner=_ww3Rk4H
Verifying runner... is alive                        runner=nUYFnZsC
FATAL: Failed to verify runners                    
root@javaBuildMachine:~# gitlab-runner verify --delete
Runtime platform                                    arch=amd64 os=linux pid=18504 revision=54944146 version=13.10.0
Running in system-mode.                            
                                                   
ERROR: Verifying runner... is removed               runner=_ww3Rk4H
Verifying runner... is alive                        runner=nUYFnZsC
Updated /etc/gitlab-runner/config.toml             
root@javaBuildMachine:~# gitlab-runner verify
Runtime platform                                    arch=amd64 os=linux pid=18513 revision=54944146 version=13.10.0
Running in system-mode.                            
                                                   
Verifying runner... is alive

```

### GitLab Runner 由于 git 版本过低报错

![](./images/gitlab-ci-git-version-error.jpg)

* centos7 默认版本为 1.8.x，升级为 2.x 版本即可
* 升级 git 后需要重新注册 GitLab Runner 到 GitLab

### Shared Runner 、Group Runner 和 Specific Runner

> GitLab-Runner 可以分类两种类型：**Shared Runner（共享型）**和 **Specific Runner（指定型）**

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

