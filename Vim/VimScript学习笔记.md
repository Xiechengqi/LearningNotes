# VimScript 学习笔记

## 常用命令

命令 | 详解 | 例子 | 说明
------ | ------ | ------ | ------
:echo | 打印信息 | :echo 'hello' | 打印输出 'hello'
:echom | 打印信息，并保存信息 | :echom 'hello' | 打印输出并保存 'hello'，使用命令 :messages 可以查看
:message |
:map \ :noremap | 常规模式、视图模式下都适用的映射，加 nore 表示非递归映射，默认是递归映射 | :map - x | 在各种模式下，用 - 代替 x （删除光标后一个字符）
:nmap \ :nnoremap | 模式映射 | :nmap \ dd | 在 Normal 模式下，用 \ 代替 dd （删除整行）
:vmap \ :vnoremap | 视图映射 | :vmap \ U | 在 visual 模式下，用 \ 代替 U (将选中文本转换成大写格式）
:imap \ :inoremap | 插入映射 | :imap \ <ESC> | 在 Insert 模式下，用 \ 代替 esc 键 （退出 Insert 模式到 Normal 模式）
:cmap \ :cnoremap | 命令行映射 | :

### 命令详解补充

* 递归映射和非递归映射

``` vimscript
map a b
map b c
```
> * 对于上面例子
>   * 递归映射：等价于`map a c`
>   * 非递归映射：a 只能映射到 b ，b 只能映射到 c ，a 无法映射到 c
  
* 映射键常用表示

键盘上的键位 | 在 vim 中的表示
-- | --
大小写英文字母 - eg:<Kbd>a</kbd>、<kbd>A</kbd> | 就是大小写英文字母 - `a`、`A`
符号 - eg:<kbd>:</kbd>| 就是符号 - `:`
<kbd>Ctrl</kbd> | `<C>`
<kbd>esc</kbd> | `<ESC>`
<kbd>enter</kbd> | `<CR>`
<kbd>backspace</kbd> | `<BS>`
<kbd>↑</kbd> | `<Up>`
<kbd>↓</kbd> | `<Down>`
<kbd>←</kbd> | `<Left>`
<kbd>→</kbd> | `<Right>`
<kbd>Ctrl</kbd> + <kbd>a</kbd> | `<C-a>`
<kbd>Ctrl</kbd> + <kbd>esc</kbd> | `<C-ESC>`
<kbd>Ctrl</kbd> + <kbd>w</kbd> + <kbd>w</kbd> | `<C-w>w`
<kbd>Shift</kbd> | `<S>`
<kbd>Shift</kbd> + <kbd>F1</kbd> | `<S-F1>`
<kbd>cmd</kbd> 或 <kbd>Win</kbd> | `<D>`
<kbd>Alt</kbd> | `<M-key> 或 <A-key>`

## 

