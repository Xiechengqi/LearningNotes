案例一、

``` shell
#!/usr/bin/env bash

Green_background_prefix="\033[42;37m" && Font_color_suffix="\033[0m"

check_root(){
        [[ $EUID != 0 ]] && echo -e "${Error} 当前非ROOT账号(或没有ROOT权限)，无法继续操作，请更换ROOT账号或使用$
{Green_background_prefix}sudo su${Font_color_suffix} 命令获取临时ROOT权限（执行后可能会提示输入当前账号的密码）。" 
&& exit 1
}
check_root
```

### echo

> `echo -e` —— 开启转义，即可读取 '\n' 为换行


shell 脚本中 echo 显示内容带颜色显示，echo 显示带颜色，需要使用参数 -e 

例如：

``` shell
echo -e "\033[41;36m something here \033[0m" 
```

其中 41 的位置代表底色， 36 的位置是代表字的颜色 

> 注： 
> 1. 字背景颜色和文字颜色之间是英文的 "" 
> 2. 文字颜色后面有个 m 
> 3. 字符串前后可以没有空格，如果有的话，输出也是同样有空格 

**下面是相应的字和背景颜色，可以自己来尝试找出不同颜色搭配**

字颜色：30—–37 
```shell
　　echo -e “\033[30m 黑色字 \033[0m” 
　　echo -e “\033[31m 红色字 \033[0m” 
　　echo -e “\033[32m 绿色字 \033[0m” 
　　echo -e “\033[33m 黄色字 \033[0m” 
　　echo -e “\033[34m 蓝色字 \033[0m” 
　　echo -e “\033[35m 紫色字 \033[0m” 
　　echo -e “\033[36m 天蓝字 \033[0m” 
　　echo -e “\033[37m 白色字 \033[0m” 
```

字背景颜色范围：40—–47 
``` shell
   echo -e “\033[40;37m 黑底白字 \033[0m” 
　　echo -e “\033[41;37m 红底白字 \033[0m” 
　　echo -e “\033[42;37m 绿底白字 \033[0m” 
　　echo -e “\033[43;37m 黄底白字 \033[0m” 
　　echo -e “\033[44;37m 蓝底白字 \033[0m” 
　　echo -e “\033[45;37m 紫底白字 \033[0m” 
　　echo -e “\033[46;37m 天蓝底白字 \033[0m” 
　　echo -e “\033[47;30m 白底黑字 \033[0m” 
```

最后面控制选项说明 
```
　　\33[0m 关闭所有属性 
　　\33[1m 设置高亮度 
　　\33[4m 下划线 
　　\33[5m 闪烁 
　　\33[7m 反显 
　　\33[8m 消隐 
　　\33[30m — \33[37m 设置前景色 
　　\33[40m — \33[47m 设置背景色 
　　\33[nA 光标上移n行 
　　\33[nB 光标下移n行 
　　\33[nC 光标右移n行 
　　\33[nD 光标左移n行 
　　\33[y;xH设置光标位置 
　　\33[2J 清屏 
　　\33[K 清除从光标到行尾的内容 
　　\33[s 保存光标位置 
　　\33[u 恢复光标位置 
　　\33[?25l 隐藏光标 
　　\33[?25h 显示光标
```

案例二、`id -u `（显示当前用户的 uid ）

``` shell
[ $(id -u) != "0" ] && echo "Error: You must be root to run this script" && exit 1
或
[ `id -u` != "0" ] && echo "Error: You must be root to run this script" && exit 1
```

案例三、`whoami`（显示当前用户的用户名）

``` shell
# != 两边一定要有空格，中括号内两侧也一定要有一个空格
[ $(whoami) != "root" ] && echo  "Error: You must be root to run this script" && exit 1
或
[ `whoami` != "root" ] && echo  "Error: You must be root to run this script" && exit 1
```
