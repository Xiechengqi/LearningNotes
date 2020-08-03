# Linux 下 Navicat 持续激活

* Navicat 默认是有一个月的使用时间，到了一个月后，删除 `~/.navicat64/system.reg` 则会重新计时

* 如果重新安装 Navicat，必须先手动删除 `~/.navicat64` 文件夹，否则安装会加载这个文件夹，导致使用出错
