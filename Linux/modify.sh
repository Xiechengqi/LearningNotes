#!/usr/bin/env bash

for i in `ls|grep *.md`
do
sed -i 's/<kbd>\*\*/\*\*\`/g' $i
sed -i 's/\*\*<\/kbd>/\`\*\*/g' $i
done
