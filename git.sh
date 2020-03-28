#!/bin/bash

echo "暂存..."
git add -A && git commit -m 'update'

echo "合并远程 master 仓库"
git pull origin master


echo "开始提交 add commit push origin master ..."
echo

git push origin master
