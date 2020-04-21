# Vim 小知识

## 快捷键

![](images/vim_s1.jpg)

![](images/vim_s2.jpg)

## 使用vim编辑一个文档，保存的时侯提示你没有权限

```bash
:w !sudo tee %
```

## 全部Tab替换为空格

```shell
:set ts=4
:set expandtab 
:%retab!
# 不加感叹号!，则只处理行首的Tab
```

## 全部空格替换为Tab

```shell
:set ts=4
:set noexpandtab
:%retab!
# 不加感叹号!，则只处理首行的空格
```

