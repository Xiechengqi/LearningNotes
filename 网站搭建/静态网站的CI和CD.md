# 静态网站的持续集成和持续部署

>  **本地工作区** - **远程源代码仓库** - **触发编译** - **部署到服务器或oss或其他仓库**

一、**`本地仓库内修改`** -> **`本地 git repo push 到 github repo`** ->**`触发 github action 或 travis 或 jenkins 等`** -> **`编译并 push 到 aliyun oss、aliyun ecs、gitee repo 等`** -> **`成功更新网站`**

> 使用 github action 终于实现了 gh-pages 和 aliyun oss 的自动部署，但仍然有不满意的地方，比如：每次集成部署时间太长了（10分钟左右），还有就是静态网站无法实现 web 端在线编辑，在 web 端实时编辑功能一直都想有，这样就不局限在哪一台电脑了！！！
