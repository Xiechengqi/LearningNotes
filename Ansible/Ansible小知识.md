# Ansible

## 目录

* **[playbook 中定义变量 - vars、set_fact 和 register](#playbook-中定义变量---vars、set_fact-和-register)**
* [task 调用 - import_tasks、include_tasks]









* ansible + coballor 可以实现裸机上先安装操作系统在自动化部署软件

* ansible 使用 module 的幂等行实现部署的确定性，保证每个步骤都是可重复的。（原子性）
* 应该将 shell 脚本尽可能多的转换为 ansible 的模块，这样可以保证执行的等幂性

### playbook 中定义变量 - vars、set_fact 和 register

* 在 playbook 中可以使用 register 将捕获命令的输出保存在临时变量中，然后使用 debug 模块进行显示输出
* 当我们需要判断对执行了某个操作或者某个命令后，如何做相应的响应处理，也就是说在 ansible 的 playbook 中 task 之间的相互传递变量，可以使用  register
* 当 shell 执行完后，使用 register 获取 shell 的运行结果存放到 shellreturn(名字随便) 这个变量中，shellreturn 是一个 key value 字典，输出形式为 shellreturn.stdout