# pipeline 代码归纳

### groovy 执行 Linux 命令

``` shell
def r = "sshpass -p xiechengqi123 ssh -o StrictHostKeyChecking=no root@install.paraview.cn bash /opt/OSC6/tag.sh".execute()
def result = r.in.text
```

### checkout git 仓库代码

``` groovy
checkout([
    $class: 'GitSCM',
    branches: [[name: "refs/tags/${tagName}"]],
    doGenerateSubmoduleConfigurations: false,
    extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: "${buildName}"]],
    submoduleCfg: [],
    userRemoteConfigs: [[credentialsId: "${credentialsID}", url: "${gitlabUrl}"]]
])
```

### input 选择按钮

``` groovy
steps {
	script {
		input (
            message: 'http://192.168.3.19，开发环境自测是否成功？',
            ok: '确认',
            submitter: 'xiechengqi',
            submitterParameter: 'name'
        )
	}
}
```

### input 选择下拉框

``` groovy
steps {
	script {
	    // 初始化列表集合 tagList
		def tagList = ['4.7.0.0-a1-2020-10-21', '4.7.0.0-a2-2020-11-01', '4.7.0.0-a3-2020-12-12']
		input (
            message: '请选择一个发版 tag',
            ok: '确认',
            parameters: [
                choice(choices: tagList, description: '先检查和 gitlab 发版 tag 一致，再点击确认', name: 'TAG')
            ]
        )
	}
}
```

### input 勾选框

``` groovy
input (
    message: '发版提测流水线',
    ok: '确认',
    parameters: [
        booleanParam(defaultValue: 'false', description: '二、是否更新数据库', name: 'choose')
    ]
)
```

### 获取 job 触发用户名

``` groovy
// 触发人变量
steps {
    wrap([$class: 'BuildUser']) {
        script {
            BUILD_USER = "${env.BUILD_USER}"
        }
    }
}
```

### mvn 编译

``` shell
cd 项目根目录
mvn ${mvnOptions} clean install/package/deploy
```

### npm 编译

``` shell
cd 项目根目录
cnpm install && npm run build
```

### 清空编译机本地备份

``` shell
rm -rf ${backupPath} && mkdir -p ${backupPath}
```

###  传输制品到编译机本地备份

``` shell
cp -v ${outPath} ${backupPath}
```

### 清空制品服务器相同版本的备份

``` shell
rm -rf ${backupPath}/${version}
```

### 传输编译机本地备份到制品服务器对应版本目录

``` shell
mkdir -p ${backupPath}/${version}
scp ${backupPath} root@${dataIp}:${backupPath}/${version}
```

### 清空开发、测试、演示环境本地制品备份

``` shell
rm -rf ${backupPath} && mkdir -p ${backupPath}
```

### 开发、测试、演示环境拉取最新制品

``` shell
scp root@${dataIp}:${backupPath}/${version}/* ${backupPath}
```

### jar 包重启

``` shell
systemctl restart xxx.serivce
```

### war 包重启

``` shell
/etc/init.d/tomcat restart
```

### Sonar 扫描

``` shell

```

### 邮件通知

``` shell
bash /data/backup/pipeline/scripts/mail/mail.sh ${devReceiverEmails} -n ${BUILD_USER} -m 开发环境部署完成，请前往自测 -j ${JOB_NAME} -t ${tagName} -b ${BUILD_NUMBER} -u ${jenkinsWebUrl} -w ${devUrl}
```

### 飞书通知

``` shell
bash /data/backup/pipeline/scripts/feishu/feishu.sh ${devReceiverEmails} -a ${chatName} -m 开发环境部署完成，请前往自测 -J ${jenkins} -j ${JOB_NAME} -g ${tagName} -u ${BUILD_USER} -n ${BUILD_NUMBER} -w ${devUrl} -c blue
```



