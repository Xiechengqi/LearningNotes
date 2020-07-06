# Ubuntu 安装及配置 Navicat 

## 解决乱码

> ubuntu下 navicat 的乱码大致可分为两类，一类是 navicat 软件自身的乱码，另一类是链接到数据库后的乱码，包括编辑器，表格等的乱码

### 1、navicat 自身的乱码解决

编辑 navicat 的启动脚本 - - start_navicat，修改成`export LANG="zh_CN.UTF-8"`即可

### 2、连接数据库后的乱码解决

* 首先在连接数据库时，在高级选项中，设置编码为`UTF-8`，连接成功后进入界面。

* 选择工具-首选项，常规页签下，字体选择`Noto Sans Mono CJK TC`

* 编辑器页签下编辑器字体选择`Noto Sans CJK SC`

* 记录页签下网格字体选择`Noto Sans Mono CJK TC`

* 修改完成后，重启软件后，编码问题即可解决！
