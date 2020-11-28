# Shell 文本处理常用工具补遗



sort

uniq

count

cut

wc

find

xargs

tr

paste

join

paste

split

## sort

* **对文本的行排序**
* sort 将文件的每一行作为一个单位，相互比较，默认比较原则是从首字符向后，依次按 ASCII 码值进行比较，最后将它们按升序输出
* <kbd>**sort [选项] file**</kbd>
* <kbd>**[选项]**</kbd>
  * <kbd>-r</kbd> - 逆序排序 ( 从大到小 )
  * <kbd>-u</kbd> - 去掉重复的行
  * <kbd>-k N</kbd> - 指定按第N列排序
  * <kbd>-n</kbd> - 按数字进行排序，**sort 默认是按字符进行排序**
  * <kbd>-d</kbd> - 按字典序进行排序 
  * <kbd>-t</kbd> - 指定分隔符，默认分隔符是制表符
  * <kbd>-k [n,m]</kbd> - 按照指定的字段范围排序。从第 n 个字段开始，到第 m 个字段（ 默认到行尾 ）
  * <kbd>-f</kbd> - 忽略大小写
  * <kbd>-b</kbd> - 忽略每行前面的空白部分
  * <kbd>-o <输出文件></kbd> - 将排序后的结果存入指定的文件

### 常用命令

``` bash
# 以冒号分割 /etc/passwd 每行，并按第 1 列字符排序
$ cat /etc/passwd | sort -t ':' -k1

# 以冒号分割 /etc/passwd 每行，并按第 3 列数字排序
$ cat /etc/passwd | sort -t ':' -k 3n
$ cat /etc/passwd | sort -n -t ":" -k 3
$ cat /etc/passwd | sort -n -t ":" -k 3,3
# -k 3 ：代表从第三个字段到行尾都排序（第一个字段先排序，如果一致，则第二个字段再排序，直到行尾）
# -k 3,3：代表仅对第三个字段进行排序，后面字段按原来顺序
```

## uniq

* **检查并删除文本中相邻重复出现的行**

* <kbd>**uniq [选项] 文件**</kbd>

* <kbd>**[选项]**</kbd>

  * <kbd>空</kbd> - 默认将相邻或连续相同的行删除到只剩一行，并输出

  * -c 在每列旁边显示该行重复出现的次数

