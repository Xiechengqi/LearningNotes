# GitLab CI 命令详解

## 目录



|    关键字     | 是否必须 |                             描述                             |
| :-----------: | :------: | :----------------------------------------------------------: |
|    script     |   必须   |                定义Runner需要执行的脚本或命令                |
|     image     |  非必须  | 需要使用的docker镜像，请查阅[该文档](https://docs.gitlab.com/ce/ci/docker/using_docker_images.html#define-image-and-services-from-gitlab-ciyml) |
|   services    |  非必须  | 定义了所需的docker服务，请查阅[该文档](https://docs.gitlab.com/ce/ci/docker/using_docker_images.html#define-image-and-services-from-gitlab-ciyml) |
|     stage     |  非必须  |               定义了工作的场景阶段,默认是test                |
|     type      |  非必须  |                   stage的别名，不赞成使用                    |
|   variables   |  非必须  |                    在job级别上定义的变量                     |
|     only      |  非必须  |               定义哪些git引用（分支）适用该job               |
|    except     |  非必须  |              定义了哪些git引用(分支)不适用该job              |
|     tags      |  非必须  | 定义了哪些runner适用该job（runner在创建时会要求用户输入标签名来代表该runner） |
| allow_failure |  非必须  |        允许任务失败，但是如果失败，将不会改变提交状态        |
|     when      |  非必须  | 定义job什么时候能被执行，可以是on_success,on_failure,always或者manual |
| dependencies  |  非必须  | 定义了该job依赖哪一个job，如果设置该项，你可以通过artifacts设置 |
|   artifacts   |  非必须  | 所谓工件。。就是在依赖项之间传递的东西，类似cache，但原理与cache不同 |
|     cache     |  非必须  |               定义需要被缓存的文件、文件夹列表               |
| before_script |  非必须  |              覆盖在根元素上定义的before_script               |
| after_script  |  非必须  |               覆盖在根元素上定义的after_script               |
|  environment  |  非必须  |                 定义让job完成部署的环境名称                  |
|     retry     |  非必须  |                 定义job失败后的自动重试次数                  |

## `script`

