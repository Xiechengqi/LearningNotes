`mvn sonar:sonar`不会触发`mvn clean install`执行。它仅触发Maven Surefire插件执行。

这就是为什么您需要在每次分析之前执行`mvn clean install`的原因-否则您编译的类将不会是最新的，因此Surefire执行将不包括最近的修改。



```shell
sonar-scanner -Dsonar.host.url=http://10.10.10.12:9000 -Dsonar.login=token -Dsonar.projectKey=$CI_PROJECT_NAME:$CI_COMMIT_REF_NAME -Dsonar.java.binaries=$PWD -Dsonar.dependencyCheck.reportPath=$PWD/reports/dependency-check-report.xml -Dsonar.dependencyCheck.htmlReportPath=$PWD/reports/dependency-check-report.html # 执行扫描，并将报告传输给SonarQube
```