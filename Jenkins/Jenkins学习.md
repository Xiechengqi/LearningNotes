

**`安装`**

https://jenkins.io/zh/download/

**`更换软件源`**

> [清华 Jenkins 软件源](https://mirrors.tuna.tsinghua.edu.cn/jenkins/updates/update-center.json)

``` bash
$ cd ~/updates
$ sed -i 's/http:\/\/updates.jenkins-ci.org\/download/https:\/\/mirrors.tuna.tsinghua.edu.cn\/jenkins/g' default.json && sed -i 's/http:\/\/www.google.com/https:\/\/www.baidu.com/g' default.json
```

