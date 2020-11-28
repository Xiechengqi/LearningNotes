# SonarQube 学习

### sonar 与 jenkins 集成的方式
* pipeline + maven

``` shell
stage('依赖安全检查') {
    steps{
        dependencyCheckAnalyzer datadir: '', hintsFile: '', includeCsvReports: false, includeHtmlReports: true, includeJsonReports: false, includeVulnReports: true, isAutoupdateDisabled: false, outdir: '', scanpath: '', skipOnScmChange: false, skipOnUpstreamChange: false, suppressionFile: '', zipExtensions: ''
    }
}

stage('静态代码检查') {
    steps {
        echo "starting codeAnalyze with SonarQube......"
        withSonarQubeEnv('sonar') {
            //注意这里withSonarQubeEnv()中的参数要与之前SonarQube servers中Name的配置相同
            withMaven(maven: 'M3') {
                sh "mvn clean package -Dmaven.test.skip=true sonar:sonar -Dsonar.projectKey={项目key} -Dsonar.projectName={项目名称} -Dsonar.projectVersion={项目版本} -Dsonar.sourceEncoding=UTF-8 -Dsonar.exclusions=src/test/** -Dsonar.sources=src/ -Dsonar.java.binaries=target/classes -Dsonar.host.url={SonarQube地址} -Dsonar.login={SonarQube的token}"
            }
        }
        script {
            timeout(1) {
                //这里设置超时时间1分钟，不会出现一直卡在检查状态
                //利用sonar webhook功能通知pipeline代码检测结果，未通过质量阈，pipeline将会fail
                def qg = waitForQualityGate('sonar')
                //注意：这里waitForQualityGate()中的参数也要与之前SonarQube servers中Name的配置相同
                if (qg.status != 'OK') {
                    error "未通过Sonarqube的代码质量阈检查，请及时修改！failure: ${qg.status}"
                }
            }
        }
    }
}
```

* 配置在 jenkins 构建任务中、直接使用 sonar 脚本


``` shell
mvn sonar:sonar -Dsonar.jdbc.driver=com.mysql.jdbc.Driver -Dsonar.branch=z123_test -Dsonar.host.username=admin -Dsonar.host.password=admin -Dsonar.host.url=http://{ip地址}:9000 -Dsonar.projectName=项目名称
```
mvn 调用maven插件命令
参数-D
sonar.exclusions=**/test/**,**/mock/**  //过滤的路径
sonar.dynamicAnalysis=reuseReports   //未知,一般用这个参数
sonar.cpd.exclusions=　　cpd,就是重复代码统计,填上过滤的路径
sonar.jdbc.driver=com.mysql.jdbc.Driver  取决于sonar服务器使用哪个数据库
sonar.branch= 　　每个项目可以设置分支,最好是和代码库分支一致
sonar.host.username 　　sonar服务器用户名(默认是admin)
sonar.host.password　　sonar服务器密码
sonar.host.url　　sonar服务器地址,比如http://localhost:9000
sonar.projectName  项目名称,可以按自己公司规则指定
