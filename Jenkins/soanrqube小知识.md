# SonarQube 学习

## 目录

* [通过 API 获取指标](通过-api-获取指标)

* [sonar 错误排查](#sonar-错误排查)

* [ sonar 指定分支](#sonar-指定分支)

* 根据 merge request 触发
* 同步状态到 gitlab
* jenkins 变量查看
* jenkins 常用 option



## jenkins 常用 options

``` yaml
// 在 Jenkinsfile 中配置以跳过默认的 checkout 行为
options {
  skipDefaultCheckout true
}
```







## jenkins 变量查看

* **[Jenkins地址]/env-vars.html** - http://pipeline.paraview.cn/env-vars.html/



## 同步状态到 gitlab

* 配置好 gitlab 插件，在 Pipeline 中指定 `options`：

``` yaml
// Jenkisfile
options {
  gitLabConnection('gitlab')
}
```

* 然后就可以在 post 中根据不同的状态来更新 gitlab 了：

``` yaml
// Jenkisfile
failure {
  updateGitlabCommitStatus name: 'build', state: 'failed'
}
success {
  updateGitlabCommitStatus name: 'build', state: 'success'
}
```



## 根据 merge request 触发

安装 `Gitlab` 插件 - https://github.com/jenkinsci/gitlab-plugin

配置GitLab Connection:

``` yaml
options {
	gitLabConnection('GitlabAccess')
}
```

* 拉代码并合并源分支到目标分支，之后在目标分支构建并测试

``` yaml
// 其中PreBuildMerge会在拉取source branch的代码后，在Jenkins workspace下做一个本地的git merge操作
stage('Checkout') {
	steps {
        checkout changelog: true, poll: true, scm: [
          $class: 'GitSCM',
          branches: [[name: "origin/${env.gitlabSourceBranch}"]],
          doGenerateSubmoduleConfigurations: false,
          extensions: [[
            $class: 'PreBuildMerge',
            options: [
              fastForwardMode: 'FF',
              mergeRemote: 'origin',
              mergeStrategy: 'default',
              mergeTarget: "${env.gitlabTargetBranch}"
            ]
          ]],
          extensions: [[
            $class: 'UserIdentity', 
            email: "${env.gitlabUserEmail}", 
            name: "${env.gitlabUserName}"
          ]],
          submoduleCfg: [],
          userRemoteConfigs: [[
            credentialsId: "${GIT_CREDENTIALS_ID}",
            name: 'origin',
            url: "${env.gitlabSourceRepoURL}"
          ]]
        ]
    }
}
```

更新GitLab状态的post-actions：

``` yaml
post{
    success {
        updateGitlabCommitStatus(name: 'build', state: 'success')
    }
    failure {
        updateGitlabCommitStatus(name: 'build', state: 'failed')
        addGitLabMRComment comment: "Something unexpected happened. Please inspect Jenkins logs."
    }        
}
```

注意：如果一个GitLab merge request还在open状态，每次往这个merge request的source branch提交代码，都会触发一个新的merge request event通知到Jenkins



## 通过 API 获取指标



##　sonar 错误排查

#### 交互式启动

* `/opt/sonar/bin/sonar.sh console`

#### 日志文件

* `/opt/sonar/logs/es.log`
* `/opt/sonar/logs/web.log`
* `/opt/sonar/logs/sonar/log`



## sonar 指定分支

* 插件 url - https://github.com/mc1arke/sonarqube-community-branch-plugin/releases
* 注意插件支持的 SonarQube 的最低版本

* 安装

``` shell
cp sonarqube-community-branch-plugin-1.2.0.jar lib/common/
cp sonarqube-community-branch-plugin-1.2.0.jar extensions/plugins/
# 重启加载生效
./bin/linux-x86-64/sonar.sh restart
```



https://github.com/SonarSource/sonar-scanning-examples



mvn sonar:sonar 参数

``` shell
sonar.exclusions=**/test/**,**/mock/**  //过滤的路径
sonar.dynamicAnalysis=reuseReports   //未知,一般用这个参数
sonar.cpd.exclusions=　　cpd,就是重复代码统计,填上过滤的路径
sonar.jdbc.driver=com.mysql.jdbc.Driver  取决于sonar服务器使用哪个数据库
sonar.branch= 　　每个项目可以设置分支,最好是和代码库分支一致
sonar.host.username 　　sonar服务器用户名(默认是admin)
sonar.host.password　　sonar服务器密码
sonar.host.url　　sonar服务器地址,比如http://localhost:9000 
sonar.projectName  项目名称,可以按自己公司规则指定
```

`mvn sonar:sonar`不会触发`mvn clean install`执行。它仅触发Maven Surefire插件执行。

这就是为什么您需要在每次分析之前执行`mvn clean install`的原因-否则您编译的类将不会是最新的，因此Surefire执行将不包括最近的修改。



```shell
sonar-scanner -Dsonar.host.url=http://10.10.10.12:9000 -Dsonar.login=token -Dsonar.projectKey=$CI_PROJECT_NAME:$CI_COMMIT_REF_NAME -Dsonar.java.binaries=$PWD -Dsonar.dependencyCheck.reportPath=$PWD/reports/dependency-check-report.xml -Dsonar.dependencyCheck.htmlReportPath=$PWD/reports/dependency-check-report.html # 执行扫描，并将报告传输给SonarQube
```

在执行mvn命令时，加上“org.jacoco:jacoco-maven-plugin:prepare-agent”参数即可。 示例：

```shell
mvn clean test org.jacoco:jacoco-maven-plugin:0.7.3.201502191951:prepare-agent install -Dmaven.test.failure.ignore=true
```



sonar-project.properties 内容

``` shell
# required metadata
# 项目key
sonar.projectKey=com.domian.package:projectName
# 项目名称
sonar.projectName=tools
# 项目版本，可以写死，也可以引用变量
sonar.projectVersion=${VER}
# 源文件编码
sonar.sourceEncoding=UTF-8
# 源文件语言
sonar.language=java
# path to source directories (required)
# 源代码目录，如果多个使用","分割 例如：mode1/src/main,mode2/src/main
sonar.sources=src/main
# 单元测试目录，如果多个使用","分割 例如：mode1/src/test,mode2/src/test
sonar.tests=src/test
# Exclude the test source
# 忽略的目录
#sonar.exclusions=*/src/test/**/*
# 单元测试报告目录
sonar.junit.reportsPath=target/surefire-reports
# 代码覆盖率插件
sonar.java.coveragePlugin=jacoco
# jacoco.exec文件路径
sonar.jacoco.reportPath=target/coverage-reports/jacoco.exec
<sonar.jacoco.reportPath>target/jacoco.exec</sonar.jacoco.reportPath>
<sonar.jacoco.itReportPath>target/jacoco-it.exec</sonar.jacoco.itReportPath>
<sonar.language>java</sonar.language>
<sonar.verbose>true</sonar.verbose>
<sonar.java.source>8</sonar.java.source>
# 这个没搞懂，官方示例是配置成jacoco.exec文件路径
sonar.jacoco.itReportPath=target/coverage-reports/jacoco.exec

sonar.core.codeCoveragePlugin=jacoco
sonar.coverage.jacoco.xmlReportPaths=/jacoco/report.xml # 最好写成绝对路径

sonar.java.coveragePlugin=jacoco
sonar.jacoco.itReportPath=target/jacoco.exec
sonar.junit.reportsPath=target/surefire-reports
sonar.surefire.reportsPath=target/surefire-reports

# required metadata
# 项目key
sonar.projectKey=com.domian.package:projectName
# 项目名称
sonar.projectName=tools
# 项目版本，可以写死，也可以引用变量
sonar.projectVersion=${VER}
# 源文件编码
sonar.sourceEncoding=UTF-8
# 源文件语言
sonar.language=java
# path to source directories (required)
# 源代码目录，如果多个使用","分割 例如：mode1/src/main,mode2/src/main
sonar.sources=src/main/java
# 单元测试目录，如果多个使用","分割 例如：mode1/src/test,mode2/src/test
sonar.tests=src/test/java
# java字节码目录
sonar.binaries=target/classes
# 单元测试报告目录
sonar.junit.reportsPath=target/surefire-reports
# 代码覆盖率插件
sonar.java.coveragePlugin=jacoco
# jacoco插件版本
jacoco.version=0.8.1
# jacoco.exec文件路径
sonar.jacoco.reportPath=target/coverage-reports/jacoco.exec
```

``` shell
# required metadata
# 项目key
sonar.projectKey=com.domian.package:projectName
# 项目名称
sonar.projectName=tools
# 项目版本，可以写死，也可以引用变量
sonar.projectVersion=${VER}
# 源文件编码
sonar.sourceEncoding=UTF-8
# 源文件语言
sonar.language=java
# path to source directories (required)
# 源代码目录，如果多个使用","分割 例如：mode1/src/main,mode2/src/main
sonar.sources=src/main
# 单元测试目录，如果多个使用","分割 例如：mode1/src/test,mode2/src/test
sonar.tests=src/test
# Exclude the test source
# 忽略的目录
#sonar.exclusions=*/src/test/**/*
# 单元测试报告目录
sonar.junit.reportsPath=target/surefire-reports
# 代码覆盖率插件
sonar.java.coveragePlugin=jacoco
# jacoco.exec文件路径
sonar.jacoco.reportPath=target/coverage-reports/jacoco.exec
# 这个没搞懂，官方示例是配置成jacoco.exec文件路径
sonar.jacoco.itReportPath=target/coverage-reports/jacoco.exec
```

``` shell
#访问端口
sonar.web.port=4399
#ELASTICSEARCH端口
sonar.search.port=8999
#数据库连接地址
sonar.jdbc.url=jdbc:mysql://192.168.6.49:3306/sonar6?useUnicode=true&characterEncoding=utf8&rewriteBatchedStatements=true&useConfigs=maxPerformance&useSSL=false
#数据库用户名
sonar.jdbc.username=sonar
#数据库密码
sonar.jdbc.password=123456
#字符集编码
sonar.sorceEncoding=UTF-8
#web页面注册的账号
sonar.login=admin
#web页面注册的密码
sonar.password=admin
```



``` shell
sonar.projectKey=$sonarKey
sonar.projectName=$sonarKey
sonar.projectVersion=1.0
sonar.sourceEncoding=UTF-8
sonar.language=java
sonar.sources=$WORKSPACE/cjia-springcloud-user-impl/src/main/java/
sonar.sources=$WORKSPACE/cjia-springcloud-user-api/src/main/java/
sonar.java.binaries=$WORKSPACE/cjia-springcloud-user-impl/target/classes/
sonar.java.binaries=$WORKSPACE/cjia-springcloud-user-api/target/classes/
sonar.test.inclusions=$WORKSPACE/cjia-springcloud-user-impl/src/test/

sonar.projectKey=com.company.projectkey1   # 项目标识
sonar.projectName=My Project Name          # 项目名称，会显示在sonar检查结果的目录
sonar.sources=.                            # 待检查的代码目录
sonar.java.binaries=target/classes/        # 待检查的代码编译后class目录
sonar.exclusions=**/*_test.go,**/vendor/** # 在排除的，不需要检查的目录
```



```  shell
#key，唯一标识，直接用项目名即可
sonar.projectKey=项目名
sonar.projectName=项目名
sonar.projectVersion=1.0
#要扫描的代码路径，sonar-project.properties文件的相对路径。【配成.或src】
sonar.java.binaries=target/classes
sonar.sourceEncoding=UTF-8
sonar.language=java
```



``` shell
sonar-scanner  -Dsonar.host.url=http://xxxxxx:9000  \
    -Dsonar.projectKey=${projectName}${i}  \
    -Dsonar.projectName=${projectName}${i}  \
    -Dsonar.projectVersion=${scanTime} \
    -Dsonar.login=admin \
    -Dsonar.password=admin \
    -Dsonar.ws.timeout=30 \
    -Dsonar.projectDescription="my first project!"  \
    -Dsonar.links.homepage=http://www.baidu.com \
    -Dsonar.sources=src \
    -Dsonar.sourceEncoding=UTF-8 \
    -Dsonar.java.binaries=target/classes \
    -Dsonar.java.test.binaries=target/test-classes \
    -Dsonar.java.surefire.report=target/surefire-reports
```



``` shell
# Required metadata
sonar.projectKey=thiagodnf.jacof
sonar.projectName=jacof
sonar.projectVersion=1.0
sonar.language=java
sonar.java.source=1.8

# Path to the parent source code directory.
# Path is relative to the sonar-project.properties file. Replace "\" by "/" on Windows.
# Since SonarQube 4.2, this property is optional. If not set, SonarQube starts looking for source code
# from the directory containing the sonar-project.properties file.
sonar.sources=src/main/java
sonar.tests=src/test/java

#sonar.modules=adiaco-core,adiaco-ge,adiaco-problem,adiaco-algorithm,adiaco-exec
#sonar.modules=jacof

#sonar.exclusions=src/test/**

#jacof.sonar.projectName=jacof
#adiaco-ge.sonar.projectName=adiaco-ge
#adiaco-problem.sonar.projectName=adiaco-problem
#adiaco-algorithm.sonar.projectName=adiaco-algorithm
#adiaco-exec.sonar.projectName=adiaco-exec

# Import tests execution reports (JUnit XML format).
# Set the property to the path of the directory containing all the XML reports.
##sonar.junit.reportsPath=target/surefire-reports

# Import tests execution reports (JUnit XML format).
# Set the property to the path of the directory containing all the XML reports.
#sonar.surefire.reportsPath=target/surefire-reports
 
# Import JaCoCo code coverage report.
# Set the property to the path of the JaCoCo .exec report.
sonar.jacoco.reportPaths=target/jacoco.exec
##sonar.java.coveragePlugin=jacoco
##sonar.dynamicAnalysis=reuseReports

# Import Cobertura code coverage report.
# Set the property to the path of the Cobertura .ser report.
##sonar.cobertura.reportPath=target/site/cobertura/coverage.xml
 
# Encoding of the source code
sonar.sourceEncoding=UTF-8


#####sonar.tests=src/test/java
sonar.jacoco.reportPaths=target/jacoco.exec
sonar.java.binaries=target/classes
#Tells SonarQube where the integration tests code coverage report is
#sonar.jacoco.itReportPath=reports/jacoco/jacoco-it.exec
```





jenkins 要安装插件 [Sonar Quality Gates Plugin](https://link.ld246.com/forward?goto=https%3A%2F%2Fgithub.com%2Fjenkinsci%2Fsonar-quality-gates-plugin%2Fblob%2Fmaster%2FREADME.md)
 这样 pipeline 中就可以获取 sonar 执行后的状态了
 `updateGitlabCommitStatus` 用来更新状态到 gitlab,只有成功 gitlab 才会允许 merge 就实现了

```
stage ('静态扫描') {
  steps {
      updateGitlabCommitStatus name: 'build', state: 'running'
  
      script {
          withSonarQubeEnv('sonar') {
              sh "mvn validate sonar:sonar -Dsonar.java.binaries=target/sonar"
              }
          def qg = waitForQualityGate() 
          
          if (qg.status != 'OK') {
              error "未通过Sonarqube的代码质量阈检查，请及时修改！failure: ${qg.status}"
              updateGitlabCommitStatus name: 'build', state: 'failed'
          }
          if (qg.status == 'OK') {
              echo "通过Sonarqube的代码质量检测"
              updateGitlabCommitStatus name: 'build', state: 'success'
          }
      }
  }
}
```

如果想拿到 sonar 扫描后生成的 url 发邮件，可以通过一个脚本实现

```bash
#!/bin/sh
# 获取sonar扫描后返回的url，jenkins中使用方法：/data/tools/sonarurl ${JOB_URL}
JOB_URL=${1/jenkins.hhotel.com/127.0.0.1:8080}
id=`wget -qO- --content-on-error --no-proxy --auth-no-challenge --http-user=admin --http-password=297UVZU0u*5*1KNQ "${JOB_URL}/lastBuild/consoleText"  | grep "More about the report processing" | head -n1 | awk -F "=" '{print $2}'`
projectkey=`wget -qO- "http://sonar.hhotel.com/api/ce/task?id=${id}" --no-proxy --content-on-error | jq -r '.task' | jq -r '.componentKey'`
sonarurl=http://sonar.hhotel.com/dashboard?id=${projectkey}
echo ${sonarurl}
```

