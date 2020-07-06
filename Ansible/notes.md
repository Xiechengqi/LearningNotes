

ansible + coballor 可以实现裸机上先安装操作系统在自动化部署软件

ansible 旨在减少重复劳动，但可能在配置 ansible 过程中反而增加了重复劳动

ansible 使用 module 的幂等行实现部署的确定性，保证每个步骤都是可重复的。（原子性）

shell 部署脚本在已经部署了的机器上，就可能报错。ansible 就可以多次执行 playbook，但多次运行部署仍然是可行的，幂等性

playbook 可以看一些比较成熟的 playbook 学习

playbook task 顺序执行

应该将 shell 脚本尽可能多的转换为 ansible 的模块，这样可以保证执行的等幂性

如果没有合适的模块，可能就需要自己编写一个模块

github.com/openshift/ansible

safe

