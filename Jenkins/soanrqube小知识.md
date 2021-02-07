https://github.com/SonarSource/sonar-scanning-examples





`

`mvn sonar:sonar`不会触发`mvn clean install`执行。它仅触发Maven Surefire插件执行。

这就是为什么您需要在每次分析之前执行`mvn clean install`的原因-否则您编译的类将不会是最新的，因此Surefire执行将不包括最近的修改。



```shell
sonar-scanner -Dsonar.host.url=http://10.10.10.12:9000 -Dsonar.login=token -Dsonar.projectKey=$CI_PROJECT_NAME:$CI_COMMIT_REF_NAME -Dsonar.java.binaries=$PWD -Dsonar.dependencyCheck.reportPath=$PWD/reports/dependency-check-report.xml -Dsonar.dependencyCheck.htmlReportPath=$PWD/reports/dependency-check-report.html # 执行扫描，并将报告传输给SonarQube
```

在执行mvn命令时，加上“org.jacoco:jacoco-maven-plugin:prepare-agent”参数即可。 示例：

```shell
mvn clean test org.jacoco:jacoco-maven-plugin:0.7.3.201502191951:prepare-agent install -Dmaven.test.failure.ignore=true
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

