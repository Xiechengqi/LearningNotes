# GitLab 小知识

## 目录

* **[重要文件加入 .gitignore 防止修改](#重要文件加入-gitignore-防止修改)**



## 重要文件加入 .gitignore 防止修改

* 项目中有些文件是共用的，比如 maven 的 pom.xml、gitlab ci 的 .gitlab-ci.yml 等，当一个项目有多人参与时，容易发生这种文件被误修改并合并到主分支
* 可以在 `.gitignore` 文件中加入这类文件名，这样开发 pull 到本地，即使修改了里面内容，也不会覆盖到仓库

