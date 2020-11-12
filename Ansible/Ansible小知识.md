# Ansible

## 目录

* [常用 facts](#常用-facts)

* [替换模块 - lineinfile 和 replace](#替换模块---lineinfile-和-replace)
* **[条件判断](#条件判断)**
* **[playbook 中定义变量 - vars、set_fact 和 register](#playbook-中定义变量---vars、set_fact-和-register)**
* [task 调用 - import_tasks、include_tasks]()







* ansible + coballor 可以实现裸机上先安装操作系统在自动化部署软件
* ansible 使用 module 的幂等行实现部署的确定性，保证每个步骤都是可重复的。（原子性）
* 应该将 shell 脚本尽可能多的转换为 ansible 的模块，这样可以保证执行的等幂性



## 常用 facts

>  主机名、内核版本、网卡接口、IP 地址、操作系统版本、环境变量、CPU 核数、可用内存、可用磁盘 等等……

```yaml
# playbook 中关闭自动获取 facts
---
# facts 使用
- hosts: proxyservers
# 关闭 facts 变量
  gather_facts: no
```

| command                         | eg                | 解释           |
| ------------------------------- | ----------------- | -------------- |
| ansible_distribution            | CentOS            | 发行版本       |
| ansible_os_family               | RedHat            | 操作系统系列名 |
| ansible_distribution_version    | 7.8               | 发行版本号     |
| ansible_pkg_mgr                 | yum / apt         | 软件管理命令   |
| ansible_default_ipv4.address    | 192.168.7.12      | 默认 ipv4 地址 |
| ansible_default_ipv4.macaddress | 00:0c:29:70:19:ed | mac 地址       |
| ansible_default_ipv4.netmask    | 255.255.224.0     | 子网掩码       |
| ansible_default_ipv4.interface  | ens192            | 接口名         |
| ansible_default_ipv4.gateway    | 192.168.1.1       | 网关           |
| ansible_hostname                | xcq-7-12          | 主机名         |
| ansible_python_version          | 2.7.5             | python 版本    |
| ansible_selinux.status          | dsiabled          | selinux 状态   |

### 替换模块 - lineinfile 和 replace

* linefile - 操作单行
* replace - 可以同时操作多行



### 条件判断

* when
* changed_when
* failed_when

### playbook 中定义变量 - vars、set_fact 和 register

* 在 playbook 中可以使用 register 将捕获命令的输出保存在临时变量中，然后使用 debug 模块进行显示输出
* 当我们需要判断对执行了某个操作或者某个命令后，如何做相应的响应处理，也就是说在 ansible 的 playbook 中 task 之间的相互传递变量，可以使用  register
* 当 shell 执行完后，使用 register 获取 shell 的运行结果存放到 shellreturn(名字随便) 这个变量中，shellreturn 是一个 key value 字典，输出形式为 shellreturn.stdout