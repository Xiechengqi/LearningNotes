# Jenkins Post 学习

* **[always](#always)**



## always



``` groovy
#!/usr/bin/env groovy

post{
​    always{
​        script{
​            node(win_node){
​                //delete report file
​                println "Start to delete old html report file."
​                bat("del /s /q C:\\JenkinsNode\\workspace\\selenium-pipeline-demo\\test-output\\*.html")
​                //list the log files on jenkins ui
​                //archive 'log/*.log'
​                archiveArtifacts artifacts: 'log/*.log'
​            }
​        }
​    }
}
```



## fail

```

```