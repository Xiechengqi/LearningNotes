# ab 压力测试



## 参数



-n  在测试会话中所执行的请求个数。默认时，仅执行一个请求。

-c  一次产生的请求个数。默认是一次一个。

-t  测试所进行的最大秒数。其内部隐含值是-n 50000，它可以使对服务器的测试限制在一个固定的总时间以内。默认时，没有时间限制。

-p  包含了需要POST的数据的文件。

-P  对一个中转代理提供BASIC认证信任。用户名和密码由一个:隔开，并以base64编码形式发送。无论服务器是否需要(即, 是否发送了401认证需求代码)，此字符串都会被发送。

-T  POST数据所使用的Content-type头信息。

-v  设置显示信息的详细程度-4或更大值会显示头信息，3或更大值可以显示响应代码(404,200等),2或更大值可以显示警告和其他信息。

-V  显示版本号并退出。

-w  以HTML表的格式输出结果。默认时，它是白色背景的两列宽度的一张表。

-i  执行HEAD请求，而不是GET。

-x  设置<table>属性的字符串。

-X  对请求使用代理服务器。

-y  设置<tr>属性的字符串。

-z  设置<td>属性的字符串。

-C  对请求附加一个Cookie:行。其典型形式是name=value的一个参数对，此参数可以重复。

-H  对请求附加额外的头信息。此参数的典型形式是一个有效的头信息行，其中包含了以冒号分隔的字段和值的对(如,"Accept-Encoding:zip/zop;8bit")。

-A  对服务器提供BASIC认证信任。用户名和密码由一个:隔开，并以base64编码形式发送。无论服务器是否需要(即,是否发送了401认证需求代码)，此字符串都会被发送。

-h  显示使用方法。

-d  不显示"percentage served within XX [ms] table"的消息(为以前的版本提供支持)。

-e  产生一个以逗号分隔的(CSV)文件，其中包含了处理每个相应百分比的请求所需要(从1%到100%)的相应百分比的(以微妙为单位)时间。由于这种格式已经“二进制化”，所以比'gnuplot'格式更有用。

-g  把所有测试结果写入一个'gnuplot'或者TSV(以Tab分隔的)文件。此文件可以方便地导入到Gnuplot,IDL,Mathematica,Igor甚至Excel中。其中的第一行为标题。

-i  执行HEAD请求，而不是GET。

-k  启用HTTP KeepAlive功能，即在一个HTTP会话中执行多个请求。默认时，不启用KeepAlive功能。

-q  如果处理的请求数大于150，ab每处理大约10%或者100个请求时，会在stderr输出一个进度计数。此-q标记可以抑制这些信息。



## 常用命令

``` shell
$ ab -c 10 -n 100 http://a.ilanni.com/index.php
#    -c    10 表示并发用户数为 10
#    -n    100 表示请求总数为 100
#    http://a.ilanni.com/index.php 表示请求的目标 URL
#    这行表示同时处理 100 个请求并运行 10 次 index.php 文件

Benchmarking 47.93.96.25 (be patient).....done

Server Software:        Apache/2.4.29  ## apache 版本 
Server Hostname:        ip地址   ## 请求的机子 
Server Port:            80  ## 请求端口

Document Path:          index.php
Document Length:        18483 bytes  ##页面长度

Concurrency Level:      10  ##并发数
Time taken for tests:   25.343 seconds  ##共使用了多少时间
Complete requests:      100  ##请求数
Failed requests:        11  ##失败请求
   (Connect: 0, Receive: 0, Length: 11, Exceptions: 0)
Total transferred:      1873511 bytes  ##总共传输字节数，包含http的头信息等
HTML transferred:       1848311 bytes  ##html字节数，实际的页面传递字节数
Requests per second:    3.95 [#/sec] (mean)  ##每秒多少请求，这个是非常重要的参数数值，服务器的吞吐量
Time per request:       2534.265 [ms] (mean)  ##用户平均请求等待时间
Time per request:       253.426 [ms] (mean, across all concurrent requests)  ##服务器平均处理时间，
Transfer rate:          72.19 [Kbytes/sec] received  ##每秒获取的数据长度

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    8   3.9     10      13
Processing:  1222 2453 322.6   2520    3436
Waiting:     1175 2385 320.4   2452    3372
Total:       1222 2461 322.5   2528    3444

Percentage of the requests served within a certain time (ms)
  50%   2528  ## 50%的请求在25ms内返回 
  66%   2534  ## 60%的请求在26ms内返回 
  75%   2538
  80%   2539
  90%   2545
  95%   2556
  98%   3395
  99%   3444
 100%   3444 (longest request)
```

