# Maven 配置文件 settings.xml 详解

> * https://ehlxr.me/2020/03/02/maven-setting-config/

* `settings.xml` 是 `maven` 的配置文件，用户配置文件存放于 `${user.home}/.m2/` 目录下，系统全局配置文件放置于 `${maven.home}/conf/` 目录下，`pom.xml` 是 `maven` 的项目的配置文件

* Maven 配置文件有以下三处，**优先级由高到低，同时存在：不同内容合并，相同内容优先级最高的生效**：
  * 项目配置: `项目根目录/pom.xml`
  * 用户配置: `$HOME/.m2/settings.xml`，没有的话，可自行创建
  * 全局配置: `$MAVEN_HOME/conf/settings.xml`，也可以使用 `mvn -X` 命令查看
* 配置详解

**`settings.xml 中的顶级元素`**

``` xml
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0
                          https://maven.apache.org/xsd/settings-1.0.0.xsd">
  <localRepository/>
  <interactiveMode/>
  <usePluginRegistry/>
  <offline/>
  <pluginGroups/>
  <servers/>
  <mirrors/>
  <proxies/>
  <profiles/>
  <activeProfiles/>
</settings>
```

``` xml
<?xml version="1.0" encoding="UTF-8"?>
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">
    <!-- 构建系统本地仓库的路径。其默认值：~/.m2/repository -->
    <!-- <localRepository>${user.home}/.m2/repository</localRepository> -->

    <!-- 是否需要和用户交互以获得输入。默认为 true -->
    <!-- <interactiveMode>true</interactiveMode> -->

    <!-- 是否需要使用 ~/.m2/plugin-registry.xml 文件来管理插件版本。默认为 false -->
    <!-- <usePluginRegistry>false</usePluginRegistry> -->

    <!-- 是否需要在离线模式下运行，默认为 false。当由于网络设置原因或者安全因素，构建服务器不能连接远程仓库的时候，该配置就十分有用 -->
    <!-- <offline>false</offline> -->

    <!-- 当插件的 groupId 没有显式提供时，供搜寻插件 groupId 的列表。使用某个插件，如果没有指定 groupId 的时候，maven 就会使用该列表。
        默认情况下该列表包含了 org.apache.maven.plugins 和 org.codehaus.mojo -->
    <!-- <pluginGroups> -->
        <!-- plugin 的 groupId -->
        <!-- <pluginGroup>org.codehaus.mojo</pluginGroup> -->
    <!-- </pluginGroups> -->

    <!-- 配置服务端的一些设置。如安全证书之类的信息应该配置在 settings.xml 文件中，避免配置在 pom.xml 中 -->
    <!-- <servers> -->
        <!-- <server> -->
            <!-- 这是 server 的 id（注意不是用户登陆的 id），该 id 与 distributionManagement 中 repository 元素的 id 相匹配 -->
            <!-- <id>server001</id> -->
            <!-- 鉴权用户名 -->
            <!-- <username>my_login</username> -->
            <!-- 鉴权密码 -->
            <!-- <password>my_password</password> -->
            <!-- 鉴权时使用的私钥位置。默认是 ${user.home}/.ssh/id_dsa -->
            <!-- <privateKey>${usr.home}/.ssh/id_dsa</privateKey> -->
            <!-- 鉴权时使用的私钥密码 -->
            <!-- <passphrase>some_passphrase</passphrase> -->
            <!-- 文件被创建时的权限。如果在部署的时候会创建一个仓库文件或者目录，这时候就可以使用该权限。其对应了 unix 文件系统的权限，如：664、775 -->
            <!-- <filePermissions>664</filePermissions> -->
            <!-- 目录被创建时的权限 -->
            <!-- <directoryPermissions>775</directoryPermissions> -->
        <!-- </server> -->
    <!-- </servers> -->

    <!-- 下载镜像列表 -->
    <mirrors>
        <!-- 设置多个镜像只会识别第一个镜像下载 jar 包-->
        <mirror>
            <!-- 该镜像的唯一标识符。id 用来区分不同的 mirror 元素 -->
            <id>aliyunmaven</id>
            <!-- 被镜像的服务器的 id。如果我们要设置了一个 maven 中央仓库（http://repo.maven.apache.org/maven2/）的镜像，就需要将该元素设置成 central。
                可以使用 * 表示任意远程库。例如：external:* 表示任何不在 localhost 和文件系统中的远程库，r1,r2 表示 r1 库或者 r2 库，*,!r1 表示除了 r1 库之外的任何远程库 -->
            <mirrorOf>*</mirrorOf>
            <!-- 镜像名称 -->
            <name>阿里云公共仓库</name>
            <!-- 镜像的 URL -->
            <url>https://maven.aliyun.com/repository/public</url>
        </mirror>
    </mirrors>

    <!-- 用来配置不同的代理 -->
    <proxies>
        <proxy>
            <!-- 代理的唯一定义符，用来区分不同的代理元素 -->
            <id>myproxy</id>
            <!-- 是否激活。当我们声明了一组代理，而某个时候只需要激活一个代理的时候 -->
            <active>false</active>
            <!-- 代理的协议 -->
            <protocol>http</protocol>
            <!-- 代理的主机名 -->
            <host>proxy.somewhere.com</host>
            <!-- 代理的端口 -->
            <port>8080</port>
            <!-- 代理的用户名，用户名和密码表示代理服务器认证的登录名和密码 -->
            <username>proxyuser</username>
            <!-- 代理的密码 -->
            <password>somepassword</password>
            <!-- 不该被代理的主机名列表。该列表的分隔符由代理服务器指定；例子中使用了竖线分隔符，逗号分隔也很常见 -->
            <nonProxyHosts>*.google.com|ibiblio.org</nonProxyHosts>
        </proxy>
    </proxies>

    <!-- 根据环境参数来调整构建配置的列表。对应 pom.xml 中 profile 元素（只包含 id、activation、repositories、pluginRepositories 和 properties 元素）
        如果一个 settings.xml 中的 profile 被激活，它的值会覆盖任何定义在 pom.xml 中带有相同 id 的 profile -->
    <profiles>
        <profile>
            <!-- profile 的唯一标识 -->
            <id>test</id>
            <!-- 自动触发 profile 的条件逻辑。也可通过 activeProfile 元素以及使用 -P 标记激活（如：mvn clean install -P test）
                在 maven 工程的 pom.xml 所在目录下执行 mvn help:active-profiles 命令可以查看生效的 profile -->
            <activation>
                <!-- 默认是否激活 -->
                <activeByDefault>false</activeByDefault>
                <!-- 当匹配的 jdk 被检测到，profile 被激活。例如：1.4 激活 JDK1.4、1.4.0_2，而 !1.4 激活所有版本不是以 1.4 开头的 JDK -->
                <jdk>1.8</jdk>
                <!-- 当匹配的操作系统属性被检测到，profile 被激活。os 元素可以定义一些操作系统相关的属性 -->
                <os>
                    <!-- 激活 profile的 操作系统的名字 -->
                    <name>Windows XP</name>
                    <!--激活 profile 的操作系统所属家族。如：windows -->
                    <family>Windows</family>
                    <!--激活 profile 的操作系统体系结构 -->
                    <arch>x86</arch>
                    <!--激活p rofile 的操作系统版本 -->
                    <version>5.1.2600</version>
                </os>
                <!-- 如果 maven 检测到某一个属性（其值可以在 pom.xml 中通过 ${name} 引用），其拥有对应的 name=值，Profile 就会被激活。如果值字段是空的，
                    那么存在属性名称字段就会激活 profile，否则按区分大小写方式匹配属性值字段 -->
                <property>
                    <!-- 激活 profile 的属性的名称 -->
                    <name>mavenVersion</name>
                    <!-- 激活 profile 的属性的值 -->
                    <value>2.0.3</value>
                </property>
                <!-- 通过检测该文件的存在或不存在来激活 profile-->
                <file>
                    <!-- 如果指定的文件存在，则激活 profile -->
                    <exists>${basedir}/file2.properties</exists>
                    <!-- 如果指定的文件不存在，则激活 profile -->
                    <missing>${basedir}/file1.properties</missing>
                </file>
            </activation>
            <!-- 对应 profile 的扩展属性列表。maven 属性和 ant 中的属性一样，可以用来存放一些值。这些值可以在 pom.xml 中的任何地方使用标记 ${X} 来使用，这里 X 是指属性的名称。
                属性有五种不同的形式，并且都能在 settings.xml 文件中访问：
                1. env.X：在一个变量前加上 "env." 的前缀，会返回一个 shell 环境变量。例如："env.PATH" 指代了 $path 环境变量（在 Windows 上是 %PATH%）
                2. project.x：指代了 pom.xml 中对应的元素值。例如：<project><version>1.0</version></project> 通过 ${project.version} 获得 version 的值
                3. settings.x：指代了 settings.xml 中对应元素的值。例如：<settings><offline>false</offline></settings> 通过 ${settings.offline} 获得 offline 的值
                4. Java System Properties：所有可通过 java.lang.System.getProperties() 访问的属性都能在 pom.xml 中使用该形式访问，例如：${java.home}
                5. x：在 <properties/> 元素中，或者外部文件中设置，以 ${someVar} 的形式使用
            -->
            <properties>
                <!-- 如果该 profile 被激活，则可以在 pom.xml 中使用 ${user.install} -->
                <user.install>${user.home}/our-project</user.install>
            </properties>
            <!-- 远程仓库列表。它是 maven 用来填充构建系统本地仓库所使用的一组远程仓库 -->
            <repositories>
                <!--包含需要连接到远程仓库的信息 -->
                <repository>
                    <!-- 远程仓库唯一标识 -->
                    <id>codehausSnapshots</id>
                    <!-- 远程仓库名称 -->
                    <name>Codehaus Snapshots</name>
                    <!-- 如何处理远程仓库里 releases 的下载 -->
                    <releases>
                        <!-- 是否开启 -->
                        <enabled>false</enabled>
                        <!-- 该元素指定更新发生的频率。maven 会比较本地 pom.xml 和远程 pom.xml 的时间戳。
                            这里的选项是：always（一直），daily（默认，每日），interval：X（这里 X 是以分钟为单位的时间间隔），或者 never（从不）。 -->
                        <updatePolicy>always</updatePolicy>
                        <!-- 当 maven 验证构件校验文件失败时该怎么做：ignore（忽略），fail（失败），或者 warn（警告）-->
                        <checksumPolicy>warn</checksumPolicy>
                    </releases>
                    <!-- 如何处理远程仓库里快照版本的下载。有了 releases 和 snapshots 这两组配置，pom.xml 就可以在每个单独的仓库中，为每种类型的构件采取不同的策略。
                        例如：可能有人会决定只为开发目的开启对快照版本下载的支持 -->
                    <snapshots>
                        <enabled/>
                        <updatePolicy/>
                        <checksumPolicy/>
                    </snapshots>
                    <!-- 远程仓库 URL -->
                    <url>http://snapshots.maven.codehaus.org/maven2</url>
                    <!-- 用于定位和排序构件的仓库布局类型。可以是 default（默认）或者 legacy（遗留）-->
                    <layout>default</layout>
                </repository>
            </repositories>
            <!-- 插件的远程仓库列表。和 repositories 类似，repositories 管理 jar 包依赖的仓库，pluginRepositories 则是管理插件的仓库 -->
            <pluginRepositories>
                <!-- 每个 pluginRepository 元素指定一个 maven 可以用来寻找新插件的远程地址 -->
                <pluginRepository>
                    <id/>
                    <name/>
                    <releases>
                        <enabled/>
                        <updatePolicy/>
                        <checksumPolicy/>
                    </releases>
                    <snapshots>
                        <enabled/>
                        <updatePolicy/>
                        <checksumPolicy/>
                    </snapshots>
                    <url/>
                    <layout/>
                </pluginRepository>
            </pluginRepositories>
        </profile>
    </profiles>

    <!-- 手动激活 profiles 的列表 -->
    <!-- <activeProfiles> -->
        <!-- 要激活的 profile id。例如：env-test，则在 pom.xml 或 settings.xml 中对应 id 的 profile 会被激活。如果运行过程中找不到对应的 profile 则忽略配置 -->
        <!-- <activeProfile>env-test</activeProfile> -->
  <!-- </activeProfiles> -->
</settings>
```


## Maven 配置使用私服

* Maven 配置私服下载有两种方式：
  * setting.xml：该文件配置的是全局模式
  * pom.xml：该文件的配置的是项目独享模式

* 当我们在 maven 使用 maven-public 仓库地址的时候，会按照如下顺序访问：本地仓库 --> 私服 maven-releases --> 私服 maven-snapshots --> 远程阿里云 maven 仓库 --> 远程中央仓库

**`通过 setting.xml 文件配置`**
> setting.xml 文件配置样例如下。配置后不需要再配置 pom.xml 文件，即可通过私服下载 jar 依赖包

``` xml
<mirrors>
    <mirror>
        <!--该镜像的唯一标识符。id用来区分不同的mirror元素。 -->
        <id>maven-public</id>
        <!--镜像名称 -->
        <name>maven-public</name>
        <!--*指的是访问任何仓库都使用我们的私服-->
        <mirrorOf>*</mirrorOf>
        <!--该镜像的URL。构建系统会优先考虑使用该URL，而非使用默认的服务器URL。 -->
        <url>http://192.168.60.133:8081/repository/maven-public/</url>
    </mirror>
</mirrors>
```
> 如果我们并没有搭建私服，属于个人开发，那么也可以直接配置使用阿里 云maven 仓库

``` xml 
<mirror>
  <id>nexus-aliyun</id>
  <name>Nexus aliyun</name>
  <mirrorOf>*</mirrorOf>
  <url>http://maven.aliyun.com/nexus/content/groups/public</url>
</mirror>
```



**`通过 pom.xml 文件配置`**
> pom.xml 文件配置样例如下。如果我们配置了 pom.xml，则以 pom.xml 为准

``` xml
<repositories>
    <repository>
        <id>maven-nexus</id>
        <name>maven-nexus</name>
        <url>http://192.168.60.133:8081/repository/maven-public/</url>
        <releases>
            <enabled>true</enabled>
        </releases>
        <snapshots>
            <enabled>true</enabled>
        </snapshots>
    </repository>
</repositories>
```

> 如果没有私服，我们同样也可以配置阿里云 maven 仓库

``` xml <repositories>
   <repository>
      <id>maven-aliyun</id>
      <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
      <releases>
         <enabled>true</enabled>
      </releases>
      <snapshots>
         <enabled>true</enabled>
         <updatePolicy>always</updatePolicy>
         <checksumPolicy>fail</checksumPolicy>
      </snapshots>
   </repository>
</repositories>
```

## Maven 配置使用私服（下载插件）
> 使用 pom.xml 配置样例
``` xml
<pluginRepositories>
    <pluginRepository>
        <id>maven-nexus</id>
        <name>maven-nexus</name>
        <url>http://10.172.0.201:8081/nexus/repository/maven-public/</url>
        <releases>
            <enabled>true</enabled>
        </releases>
        <snapshots>
            <enabled>true</enabled>
        </snapshots>
    </pluginRepository>
</pluginRepositories>
```

### Maven 配置使用私服（发布依赖）

1、首先修改 setting.xml 文件，指定 releases 和 snapshots server 的用户名和密码

``` xml
<servers>
    <server>
        <id>releases</id>
        <username>admin</username>
        <password>123</password>
    </server>
    <server>
        <id>snapshots</id>
        <username>admin</username>
        <password>123</password>
    </server>
</servers>
```

2、接着在项目的 pom.xml 文件中加入 distributionManagement 节点
> 注意：repository 里的 id 需要和上一步里的 server id 名称保持一致
``` xml
<distributionManagement>
    <repository>
        <id>releases</id>
        <name>Releases</name>
        <url>http://192.168.60.133:8081/repository/maven-releases/</url>
    </repository>
    <snapshotRepository>
        <id>snapshots</id>
        <name>Snapshot</name>
        <url>http://192.168.60.133:8081/repository/maven-snapshots/</url>
    </snapshotRepository>
</distributionManagement>
```
3、执行 `mvn deploy` 命令发布

4、登录 Nexus，查看对应的仓库已经有相关的依赖包了


* package 命令完成了项目编译、单元测试、打包功能，但没有把打好的可执行jar包（war包或其它形式的包）布署到本地maven仓库和远程maven私服仓库
* install 命令完成了项目编译、单元测试、打包功能，同时把打好的可执行jar包（war包或其它形式的包）布署到本地maven仓库，但没有布署到远程maven私服仓库
* deploy 命令完成了项目编译、单元测试、打包功能，同时把打好的可执行jar包（war包或其它形式的包）布署到本地maven仓库和远程maven私服仓库
