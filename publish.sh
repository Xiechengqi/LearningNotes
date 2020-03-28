#!/bin/bash
# Xiechengqi

echo "切换到 master 仓库..."
cd /LearningNotes

echo "add commit ..."
git add -A && git commit -m 'update'

echo "合并远程 master"
git pull origin master

read -p "是否执行 git install?(y or n): " yorn

case $yorn in
	y)
		gitbook install
		;;
	Y)
		gitbook install
		;;
	*)
		;;
esac

echo "构建 gitbook..."
gitbook build

echo "add commit push origin master"
echo
git add -A && git commit -m "update"
git push origin master
echo "更新 master 仓库成功了!!!"

echo "复制 _book 内容到 gh-pages 仓库..."
echo "注意：删除需要在 gh-pages 中手动删!!!"
cp -r /LearningNotes/_book/* /gh-pages

echo "切换到 gh-pages 仓库..."
cd /gh-pages

echo "add commit push origin gh-pages"
echo
git add -A && git commit -m "update"
git push origin master:gh-pages

echo "更新 gh-pages 仓库成功了！！！"

echo "发布到 Nginx 默认目录..."
echo "注意：删除文件需要手动删!!!"
cp -r /gh-pages/* /pages/

echo "网站已经更新啦!!!"
