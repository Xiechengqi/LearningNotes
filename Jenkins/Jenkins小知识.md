# Jenkins 小知识

> * Jenkins 作为使用最为广泛的 CI/CD 平台，网上流传着无数的脚本和攻略，在学习和开发的时候一定要从基本出发，了解内部原理，多看官方的文档，不要拿到一段代码就开始用，这样才能不会迷失在各式各样的脚本之中。
> * 更重要的是要结合自己的业务需求，开发和定制属于自己的流程，不要被 Jenkins 的框架限制住。比如我们是否可以定义一个自己的 YAML 配置文件，然后根据 YAML 来生成 Pipeline，不需要业务自己写 Pipeline 脚本，规范使用，提前检查不合法的脚本，核心的模块共同升级，避免了一个流程小改动需要所有项目组同步更新

## 目录

* https://blog.csdn.net/liumiaocn/article/details/104586482
* [Method code too large问题对应方法](#method-code-too-large-问题对应方法)
* [pipeline 中 agent 使用](#pipeline-中-agent-使用)
* [pipeline 常用 options](#pipeline-常用-options)
* [获取 job 持续时间](#获取-job-持续时间)
* [pipeline 中使用 archiveArtifacts 存档文件](#pipeline-中使用-archiveArtifacts-存档文件)
* [并行任务和并行任务流](#并行任务和并行任务流)

## Method code too large 问题对应方法

**`报错信息`**

``` shell
Started by user devops
Running in Durability level: MAX_SURVIVABILITY
org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
General error during class generation: Method code too large!
```

* 出现这个问题的原因是 Jenkins 将整个声明性管道 ( pipeline { ... } ) 放入单个方法中，且大小不能超过 JVM 单个方法大小限制 64KB
* Jenkins Jira Issue: [Method code too large using declarative pipelines](https://issues.jenkins.io/browse/JENKINS-50033)

**`解决方法`**

一、将步骤放到管道外的方法中

二、从声明式迁移到脚本式管道

三、使用 	Shared Libraries

## pipeline 中 agent 使用

* jenkins pipeline 可以支持指定任意节点(any)，不指定(none)，标签(label)，节点(node)，docker，dockerfile 和 kubernetes

**`docker`**

``` shell
agent {
    docker {
        image 'myregistry.com/node'
        label 'my-defined-label'
        registryUrl 'https://myregistry.com/'
        registryCredentialsId 'myPredefinedCredentialsInJenkins'
        args '-v /tmp:/tmp'
    }
}
```

## pipeline 常用 options

**`skipDefaultCheckout()`** - 
**`timestamps()`** - 控制台输出时间
**`buildDiscarder(logRotator(numToKeepStr: '20', artifactNumToKeepStr: '20'))`** - 限制保留历史构建
**`checkoutToSubdirectory('foo')`** - 拉代码到子目录
**`disableConcurrentBuilds()`** - 不允许同时执行流水线
**`skipDefaultCheckout()`** - 在`agent` 指令中，跳过从源代码控制中检出代码的默认情况
**`timeout`** - 设置流水线运行的超时时间，超时后将 abort 流水线
**`retry()`** - 在失败时, 重试此阶段指定次数，例如: options { retry(3) }

## pipeline 获取 job 持续时间

* 安装插件：Build Timestamp Plugin - This plugin adds BUILD_TIMESTAMP to Jenkins variables and system properties

## pipeline 中使用 archiveArtifacts 存档文件

* pipeline 中可以使用 `archiveArtifacts` 命令存档文件
* 存档的文件会保存到 Jenkins 的 `jobs/JOB_NAME/builds/BUILD_NUMBER` 目录下
* `**` 表示匹配任意数目路径节点

**`steps 中使用 archiveArtifacts`**

``` shell
pipeline {
    agent any
    stages {
        stage('Archive') {
            steps {
                archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true 
            }
        }
    }
}
```

**`post 中使用 archiveArtifacts`**

``` shell
always{
    script{
        node(win_node){
            // delete report file
            println "Start to delete old html report file."
            bat("del /s /q C:\\JenkinsNode\\workspace\\selenium-pipeline-demo\\test-output\\*.html")
            // list the log files on jenkins ui
            archiveArtifacts artifacts: 'log/*.*'
        }
    }
}


always {
	archiveArtifacts artifacts: 'build/libs/**/*.jar', fingerprint: true
	junit 'build/reports/**/*.xml'
}
```



## 并行任务和并行任务流

**并行任务**

``` shell
stages {
	stage('stage1') {
		parallel {
			stage('stage2.1') {
				steps {
					echo '在任务 stage2.1'
				}
			}
			stage('stage2.2') {
                steps {
					echo '在任务 stage2.2'
				}
			}
		}
	}
	stage('stage3') {
		steps {
			echo '在任务 stage3'
		}
	}
}
```



![](./images/Jenkins_并行任务1.jpg)

**并行任务流**

``` shell
stages {
	stage('stage1') {
		parallel {
			stage('windows
				stages {
					stage('stage2.1.0') {
						steps {
                            echo '在任务 stage2.1.0'
                        }
					}
					stage('stage2.1.1') {
						steps {
                            echo '在任务 stage2.1.1'
                        }
					}
					stage('stage2.1.2') {
						steps {
                            echo '在任务 stage2.1.2'
                        }
					}
				}
			}
			stage('linux')
				stages {
					stage('stage2.2.0') {
						steps {
                            echo '在任务 stage2.2.0'
                        }
					}
					stage('stage2.2.1') {
						steps {
                            echo '在任务 stage2.2.1'
                        }
					}
					stage('stage2.2.2') {
						steps {
                            echo '在任务 stage2.2.2'
                        }
					}
				}
			}
		}
	}
	stage('stage3') {
		steps {
            echo '在任务 stage3'
        }
	}
}
```



![](./images/Jenkins_并行任务2.jpg)
