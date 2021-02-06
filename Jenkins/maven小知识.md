# Maven 小知识

## 目录

* [生命周期](#生命周期)



## 生命周期

* maven 有三大生命周期，分别是 clean、default 和 site，三个生命周期相互独立，可以只调用一个，比如 `mvn clean`，也可以同时多个，比如 `mvn clean install site`
  * Clean - 在进行真正的构建之前进行一些清理工作
    * pre-clean: 执行一些需要在 clean 之前完成的工作
    * clean: 移除所有上一次构建生成的文件
    * post-clean: 执行一些需要在 clean 之后立刻完成的工作
  * Default - 构建的核心部分，编译、测试、打包、部署等等
    * validate：validate the project is correct and all necessary information is available.
    * initialize：initialize build state, e.g. set properties or create directories.
    * generate-sources：generate any source code for inclusion in compilation.
    * process-sources：process the source code, for example to filter any values.
    * generate-resources：generate resources for inclusion in the package.
    * process-resources：copy and process the resources into the destination directory, ready for packaging.
    * compile：compile the source code of the project.
    * process-classes：post-process the generated files from compilation, for example to do bytecode enhancement on Java classes.
    * generate-test-sources：generate any test source code for inclusion in compilation.
    * process-test-sources：process the test source code, for example to filter any values.
    * generate-test-resources：create resources for testing.
    * process-test-resources：copy and process the resources into the test destination directory.
    * test-compile：compile the test source code into the test destination directory
    * process-test-classes：post-process the generated files from test compilation, for example to do bytecode enhancement on Java classes. For Maven 2.0.5 and above.
    * test：run tests using a suitable unit testing framework. These tests should not require the code be packaged or deployed.
    * prepare-package：perform any operations necessary to prepare a package before the actual packaging. This often results in an unpacked, processed version of the package. (Maven 2.1 and above)
    * package：take the compiled code and package it in its distributable format, such as a JAR.
    * pre-integration-test：perform actions required before integration tests are executed. This may involve things such as setting up the required environment.
    * integration-test：process and deploy the package if necessary into an environment where integration tests can be run.
    * post-integration-test：perform actions required after integration tests have been executed. This may including cleaning up the environment.
    * verify：run any checks to verify the package is valid and meets quality criteria.
    * install：install the package into the local repository, for use as a dependency in other projects locally.
    * deploy：done in an integration or release environment, copies the final package to the remote repository for sharing with other developers and projects.
  * Site - 生成项目报告，站点，发布站点
    * pre-site: 执行一些需要在生成站点文档之前完成的工作
    * site: 生成项目的站点文档
    * post-site: 执行一些需要在生成站点文档之后完成的工作，并且为部署做准备
    * site-deploy: 将生成的站点文档部署到特定的服务器上

