# Python 学习

## 基础库

sys、os（os.path、os.stat）、time、logging、prarmiko、re、random

## 运维常用 Python 库

1、[psutil](https://github.com/giampaolo/psutil)

是一个跨平台库，能够实现获取系统运行的进程和系统利用率（内存、CPU、磁盘、网络等），主要用于系统监控，分析和系统资源及进程的管理

2、[IPy](http://github.com/haypo/python-ipy)

辅助IP规划

3、[dnspython](http://dnspython.org)

Python实现的一个 DNS 工具包

4、difflib

difflib 作为 Python 的标准模块，无需安装，作用是对比文本之间的差异

5、filecmp

系统自带，可以实现文件，目录，遍历子目录的差异，对比功能

6、smtplib

发送电子邮件模块

7、[pycurl](http://pycurl.sourceforge.net)

是一个用 C 语言写的 libcurl Python 实现，功能强大，支持的协议有：FTP、HTTP、HTTPS、TELNET等，可以理解为 Linux 下 curl 命令功能的Python 封装

8、XlsxWriter

操作 Excel 工作表的文字、数字、公式、图表等

9、rrdtool

用于跟踪对象的变化，生成这些变化的走势图

10、[scapy](http://www.wecdev.org/projects/scapy/)

是一个强大的交互式数据包处理程序，它能够对数据包进行伪造或解包，包括发送数据包、包嗅探、应答和反馈等功能

11、pyClamad

由 Clam Antivirus 开源的防毒软件，可以让 Python 模块直接使用 ClamAV 病毒扫描守护进程 calmd

12、pexpect

可以理解成 Linux 下 expect 的 Python 封装，通过 pexpect 我们可以实现对 ssh、ftp、passwd、telnet 等命令行进行自动交互，而无需人工干涉来达到自动化的目的

13、[paramiko](http://paramiko.org)

是基于 Python 实现的 SSH2 远程安装连接，支持认证及密钥方式。可以实现远程命令执行、文件传输、中间 SSH 代理等功能。相对于pexpect，封装的层次更高，更贴近 SSH 协议的功能

14、[fabric](http://www.fabfile.org)

是基于 Python 实现的 SSH 命令行工具，简化了 SSH 的应用程序部署及系统管理任务，它提供了系统基础的操作组件，可以实现本地或远程 shell 命令，包括命令执行、文件上传、下载及完整执行日志输出等功能。Fabric 在paramiko 的基础上做了更高一层的封装，操作起来更加简单

15、CGIHTTPRequestHandler

实现对 CGI 的支持

16、[ansible](http://www.ansibleworks.com/)

一种集成 IT 系统的配置管理，应用部署，执行特定任务的开源平台。基于 Python 实现，由 Paramiko 和 PyYAML 两个关键模块构建。Ansible 与 Saltstack 最大的区别是 Ansible 无需在被控主机上部署任何客户端，默认直接通过 SSH 通道进行远程命令执行或下发功能

17、YAML

是一种用来表达数据序列的编程语言

18、playbook

一个非常简单的配置管理和多主机部署系统

19、[saltstack](http://saltstack.com)

是一个服务器基础架构集中化管理平台，一般可以理解为简化版的 puppet和加强版的 func。Saltstack 基于 Python 语言实现，结合轻量级消息队列 ZeroMQ，由 Python 第三方模块（Pyzmq、PyCrypto、Pyjinja2、python-msgpack 和 PyYAML 等）构建

20、func

为解决集群管理，监控问题需设计开发的系统管理基础框架

## Python运维常用模块

- [`csv`](https://docs.python.org/3/library/csv.html)：对于读取 csv 文件来说非常便利
- [`collections`](https://docs.python.org/3/library/collections.html)：常见数据类型的实用扩展，包括 `OrderedDict`、`defaultdict` 和 `namedtuple`
- [`random`](https://docs.python.org/3/library/random.html)：生成假随机数字，随机打乱序列并选择随机项
- [`string`](https://docs.python.org/3/library/string.html)：关于字符串的更多函数。此模块还包括实用的字母集合，例如 `string.digits`（包含所有字符都是有效数字的字符串）
- [`re`](https://docs.python.org/3/library/re.html)：通过正则表达式在字符串中进行模式匹配
- [`math`](https://docs.python.org/3/library/math.html)：一些标准数学函数
- [`os`](https://docs.python.org/3/library/os.html)：与操作系统交互
- [`os.path`](https://docs.python.org/3/library/os.path.html)：`os` 的子模块，用于操纵路径名称
- [`sys`](https://docs.python.org/3/library/sys.html)：直接使用 Python 解释器
- [`json`](https://docs.python.org/3/library/json.html)：适用于读写 json 文件（面向网络开发）

## 实用的第三方软件包

- [`IPython`](https://ipython.org/) - 更好的交互式 Python 解释器。
- [`requests`](http://docs.python-requests.org/) - 提供易于使用的方法来发出网络请求。适用于访问网络 API。
- [`Flask`](http://flask.pocoo.org/) - 一个小型框架，用于构建网络应用和 API。
- [`Django`](https://www.djangoproject.com/) - 一个功能更丰富的网络应用构建框架。Django 尤其适合设计复杂、内容丰富的网络应用。
- [`Beautiful Soup`](https://www.crummy.com/software/BeautifulSoup/) - 用于解析 HTML 并从中提取信息。适合网页数据抽取。
- [`pytest`](http://doc.pytest.org/) - 扩展了 Python 的内置断言，并且是最具单元性的模块。
- [`PyYAML`](http://pyyaml.org/wiki/PyYAML) - 用于读写 [YAML](https://en.wikipedia.org/wiki/YAML) 文件。
- [`NumPy`](http://www.numpy.org/) - 用于使用 Python 进行科学计算的最基本软件包。它包含一个强大的 N 维数组对象和实用的线性代数功能等。
- [`pandas`](http://pandas.pydata.org/) - 包含高性能、数据结构和数据分析工具的库。尤其是，pandas 提供 dataframe！
- [`matplotlib`](http://matplotlib.org/) - 二维绘制库，会生成达到发布标准的高品质图片，并且采用各种硬拷贝格式和交互式环境。
- [`ggplot`](http://ggplot.yhathq.com/) - 另一种二维绘制库，基于 R’s ggplot2 库。
- [`Pillow`](https://python-pillow.org/) - Python 图片库可以向你的 Python 解释器添加图片处理功能。
- [`pyglet`](http://www.pyglet.org/) - 专门面向游戏开发的跨平台应用框架。
- [`Pygame`](http://www.pygame.org/) - 用于编写游戏的一系列 Python 模块。
- [`pytz`](http://pytz.sourceforge.net/) - Python 的世界时区定义。