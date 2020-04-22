# 静态网站的持续集成和持续部署

>  **本地工作区** - **远程源代码仓库** - **触发编译** - **部署到服务器或oss或其他仓库**

一、**`本地仓库内修改`** -> **`本地 git repo push 到 github repo`** ->**`触发 github action 或 travis 或 jenkins 等`** -> **`编译并 push 到 aliyun oss、aliyun ecs、gitee repo 等`** -> **`成功更新网站`**

