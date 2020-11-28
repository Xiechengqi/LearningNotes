# 测试

根据软件开发的过程和由细节到外部的顺序，将软件测试划分为 5 个阶段：

* 代码质量检查：对代码的格式、潜在的 Bug 进行检查，常用的工具有 Checkstyle、PMD、FindBugs
  * Checkstyle 是一个开源代码格式的分析工具，侧重于遵循 Java 编码约定（例如行长度和缩进）而不是 Bug 模式
  * PMD 是一个开源 Java 源码分析器，它分析 Java 源代码并找出潜在的 Bug
  * FindBugs 是另一个开源静态代码分析工具，它与 PMD 的不同之处在于，它分析编译后的字节码，而不是分析源代码
* 单元测试：对代码的功能进行测试，常用的工具有 JUnit、EasyMock
* 单元测试覆盖率：jacoco
* 性能测试：对代码的性能进行测试，常用的工具有 JMeter、Profiler、loadrunner
* 自动构建：对代码进行自动构建和持续集成测试、部署，常用的工具有 Ant、Maven、CruiseControl
* 项目管理：对软件测试中的 Bug 进行跟踪和知识管理，常用的工具有 JIRA、Confluence



