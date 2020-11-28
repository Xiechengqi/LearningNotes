## Yum 和 RPM

RedHat 系列软件安装大致可以分为两种：

- rpm 文件安装 - 使用 rpm 指令 类似 [ubuntu] deb 文件安装，使用 dpkg指令
- yum 安装 - 类似 [ubuntu] apt 安装

## RPM

### rpm 包命名规范

* **`包名`**-**`版本信息`**-**`发布版本号`**.**`运行平台`**

* ```bash
  zabbix-agent-4.4.0-1.el7.x86_64.rpm 
  zabbix-release-4.4-1.el7.noarch.rpm   # noarch 代表的是软件可以平台兼容
  ```

### 常用命令

* **`查看已安装软件信息`**
  * **`rpm -qa`** - 查看系统中已经安装的软件
  * **`rpm -qf \[文件绝对路径\]`** - 查看一个已经安装的文件属于哪个软件包
  * **`rpm -ql \[软件名\]`** - 查看已安装软件包的安装路径，`[软件名]` 是 rpm 包去除平台信息和后缀后的信息
  * **`rpm -qi [软件名]`** - 查看已安装软件包的信息
  * **`rpm -qc [软件名]`** - 查看已安装软件的配置文件
  * **`rpm -qd [软件名]`** - 查看已经安装软件的文档安装位置
  * **`rpm -qR [软件名]`** - 查看已安装软件所依赖的软件包及文件

* **`查看未安装软件信息`** 
  * **`rpm -qpi [rpm文件]`** - 查看软件包的用途、版本等信息
  * **`rpm -qpl [rpm文件]`** - 查看软件包所包含的文件
  * **`rpm -qpc [rpm文件]`** - 查看软件包的配置文件
  * **`rpm -qpR [rpm文件]`** - 查看软件包的依赖关系
* **`软件包的安装、升级、删除等`** - 
  * **`rpm -ivh [rpm文件]`** - 安装
  * **`rpm -Uvh [rpm文件]`** - 升级
  * **`rpm -e [软件名]`** - 删除
  * **`rpm -e [软件名] --nodeps`** - 不管依赖问题，强制删除软件
  * **`rpm --import [签名文件]`** - 导入签名

## YUM

* yum 可以更方便的添加、删除、更新 RPM 包，并且能自动解决包的倚赖问题

**`rpm -ivh https://opsx.alibaba.com/mirror/detail/1859610790?lang=zh-CN`** - 安装 yum 	

**`yum check-update`** - 检查可以更新的软件包 

**`yum -y update`** - 升级所有包同时也升级软件和系统内核

**`yum -y upgrade`** - 只升级所有包，不升级软件和系统内核

**`yum update [软件名]`** - 更新特定的软件包 

**`yum install [rpm文件]`** - 安装 rpm 包

**`yum remove [rpm文件]`** - 删除 rpm 包

**`yum clean all`** - 清除缓存中旧的 rpm 头文件和包文件 

**`yum clean packages`** - 清楚缓存中 rpm 包文件

**`yum clean  headers`** - 清楚缓存中 rpm 的头文件

**`yum clean old headers`** - 清除缓存中旧的头文件 

**`yum list`** - 列出资源库中所有可以安装或更新的 rpm 包

**`yum list google*`** - 可以在 rpm 包名中使用通配符,查询类似的 rpm 包

**`yum list updates`** - 列出资源库中所有可以更新的 rpm 包 

**`yum list installed`** - 列出已经安装的所有的 rpm 包 

**`yum list extras`** - 列出已经安装的但是不包含在资源库中的 rpm 包 

**`yum info** ` - 列出资源库中所有可以安装或更新的 rpm 包的信息

**`yum info google*`** - 列出资源库中特定的可以安装或更新以及已经安装的  rpm 包的信息

**`yum info updates`** - 列出资源库中所有可以更新的 rpm 包的信息 

**`yum info installed`** - 列出已经安装的所有的 rpm 包的信息 

**`yum info extras`** - 列出已经安装的但是不包含在资源库中的 rpm 包的信息 

**`yum search google`** - 搜索匹配特定字符的 rpm 包

**`yum provides google`** - 搜索包含特定文件的 rpm 包

