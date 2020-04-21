# Tmux 

## 概念

- **Session** 一组窗口的集合，通常用来概括同一个任务。session 可以有自己的名字便于任务之间的切换
- **Window** 单个可见窗口。Windows 有自己的编号，也可以认为和 ITerm2中的 Tab 类似
- **Pane** 窗格，被划分成小块的窗口，类似于 Vim 中 `C-w +v` 后的效果

![](../images/tmux_concept.jpg)

## 快捷键

**tmux command**

|            tmux             |          启动 tmux           |
| :-------------------------: | :--------------------------: |
|           tmux ls           |        显示 tmux 会话        |
|     tmux a [or attach]      | 还原并附加到分离时的 Session |
|      tmux a -t 会话名       |  还原并附加到指定的 Session  |
|     tmux new -s 会话名      |        创建新 Session        |
| tmux kill-session -t 会话名 |         销毁 Session         |

**prefix command - Ctrl b - 前置操作**

|  prefix-command   |         Ctrl + b (默认)         |
| :---------------: | :-----------------------------: |
|         ?         |              帮助               |
|         t         |            显示时间             |
| x [or **`exit`**] |   销毁 window、session、pane    |
|         $         |       重命名当前 Session        |
|         s         |        查看/切换 session        |
|         d         |          离开 Session           |
|         c         |           新建 window           |
|       空格        |    切换到上一个活动的 window    |
|    n[0,1,2...]    |      使用 window 编号切换       |
|        ，         |          重命名 window          |
|         &         |           关闭 window           |
|         %         |      水平拆分出一个新 pane      |
|         "         |      垂直拆分出一个新 pane      |
|         o         |        切换到下一个 pane        |
|      方向键       |      切换到上下左右的 pane      |
|         q         |       查看所有 pane 编号        |
|         z         | 暂时 pane 放到最大，再次 z 恢复 |



## 配置

* 若没有配置文件的话先创建:  `touch ~/.tmux.conf`
* `prefix command` 默认是 `Ctrl b` ，但比较违反人体工学，所以可以把大写键 `caps lock` 改为 `Ctrl` 键，然后设置 `prefix command` 为 `Ctrl a` 
