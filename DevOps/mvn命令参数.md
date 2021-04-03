## mvn 命令参数

|               | **备注**                                                     |
| ------------- | ------------------------------------------------------------ |
| mvn -v        | --version 显示版本信息;                                      |
| mvn -V        | --show-version 显示版本信息后继续执行Maven其他目标;          |
| mvn -h        | --help 显示帮助信息;                                         |
| mvn -e        | --errors 控制Maven的日志级别,产生执行错误相关消息;           |
| mvn -X        | --debug 控制Maven的日志级别,产生执行调试信息;                |
| mvn -q        | --quiet 控制Maven的日志级别,仅仅显示错误;                    |
| mvn -Pxxx     | 激活 id 为 xxx的profile (如有多个，用逗号隔开);              |
| mvn -Dxxx=yyy | 指定Java全局属性;                                            |
| mvn -o        | --offline 运行offline模式,不联网更新依赖;                    |
| mvn -N        | --non-recursive 仅在当前[项目](http://www.07net01.com/tags-项目-0.html)模块执行命令,不构建子模块; |
| mvn -pl       | --module_name 在指定模块上执行命令;                          |
| mvn -ff       | --fail-fast 遇到构建失败就直接退出;                          |
| mvn -fn       | --fail-never 无论项目结果如何,构建从不失败;                  |
| mvn -fae      | --fail-at-end 仅影响构建结果,允许不受影响的构建继续;         |
| mvn -C        | --strict-checksums 如果校验码不匹配的话,构建失败;            |
| mvn -c        | --lax-checksums 如果校验码不匹配的话,产生告警;               |
| mvn -U        | 强制更新snapshot类型的插件或依赖库(否则maven一天只会更新一次snapshot依赖); |
| mvn -npu      | --no-plugin-s 对任何相关的注册插件,不进行最新检查(使用该选项使Maven表现出稳定行为，该稳定行为基于本地仓库当前可用的所有插件版本); |
| mvn -cpu      | --check-plugin-updates 对任何相关的注册插件,强制进行最新检查(即使项目POM里明确规定了Maven插件版本,还是会强制更新); |
| mvn -up       | --update-plugins [mvn -cpu]的同义词;                         |
| mvn -B        | --batch-mode 在非交互（批处理）模式下运行(该模式下,当Mven需要输入时,它不会停下来接受用户的输入,而是使用合理的默认值); |
| mvn -f        | --file <file> 强制使用备用的POM文件;                         |
| mvn -s        | --settings <arg> 用户配置文件的备用路径;                     |
| mvn -gs       | --global-settings <file> 全局配置文件的备用路径;             |
| mvn -emp      | --encrypt-master-password <password> 加密主安全密码,存储到Maven settings文件里; |
| mvn -ep       | --encrypt-password <password> 加密服务器密码,存储到Maven settings文件里; |
| mvn -npr      | --no-plugin-registry 对插件版本不使用~/.m2/plugin-registry.xml(插件注册表)里的配置; |



