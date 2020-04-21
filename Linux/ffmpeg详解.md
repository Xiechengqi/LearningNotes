# FFmpeg - [[github]](https://github.com/FFmpeg/FFmpeg)


* FFmpeg 是处理多媒体内容（ 如音频，视频，字幕和相关元数据 ）的库和工具的集合

## 库

* libavcodec 提供更广泛的编解码器的实现。
* libavformat 实现流协议，容器格式和基本 I / O 访问。
* libavutil 包括垫圈，解压缩器和其他实用功能。
* libavfilter 提供通过过滤器链改变解码的音频和视频的方法。
* libavdevice 提供访问捕获和回放设备的抽象。
* libswresample 实现音频混合和重采样例程。
* libswscale 实现颜色转换和缩放例程

## 工具

* ffmpeg
* ffplay
* ffprobe

## ffmpeg

* ffmpeg 是一个非常强大的工具，它可以转换任何格式的媒体文件，并且还可以用自己的 AudioFilter 以及 VideoFilter 进行处理和编辑。有了它，我们就可以对媒体文件做很多我们想做的事情了

### 预备知识

* codec - 编码解码器

> * A codec is a device or computer program for encoding or decoding a digital data stream or signal. Codec is a portmanteau of coder-decoder.
> * A codec encodes a data stream or a signal for transmission and storage, possibly in encrypted form, and the decoder function reverses the encoding for playback or editing. Codecs are used in videoconferencing, streaming media, and video editing applications.

### 使用 FFmpeg 视频分割

``` shell 
# 这个例子是将 test.mp4 视频的前 3 秒，重新生成一个新视频
ffmpeg -ss 00:00:00 -t 00:00:03 -y -i test.mp4 -vcodec copy -acodec copy test1.mp4  

[参数]
-ss 开始时间，如： 00:00:00，表示从 0 秒开始，也可以写成 00:00:0
-t 时长，如： 00:00:03，表示截取 3 秒长的视频，也可以写成 00:00:3
-y 如果文件已存在强制替换
-i 输入，后面是空格，紧跟着就是输入视频文件
-vcodec [copy] 视频的编码格式，copy 表示保持视频编码格式不变 
-acodec [copy] 音频的编码格式，copy 表示保持音频编码格式不变
```

### 使用 FFmpeg 从视频中制作 GIF 图

### 使用 FFmpeg 转换 flv 到 mp4

``` shell 
ffmpeg -i input.flv -vcodec copy -acodec copy output.mp4
```

### 使用 FFmpeg 给视频添加水印

``` shell
# 给视频添加图片水印，水印居中显示
ffmpeg -i input.mp4 -i watermark.png -filter_complex overlay="(main_w/2)-(overlay_w/2):(main_h/2)-(overlay_h)/2" output.mp4
# 给视频添加 GIF 动态图水印，水印居中显示
ffmpeg -i input.mp4 -i watermark.gif -filter_complex overlay="(main_w/2)-(overlay_w/2):(main_h/2)-(overlay_h)/2" output.mp4
# 给视频添加文字水印，水印左上角显示
ffmpeg -i input.mp4 -vf "drawtext=/usr/share/fonts/truetype/source-code-pro/SourceCodePro-BlackIt.ttf:text='视频添加文字水印':x=10:y=10:fontsize=24:fontcolor=yellow:shadowy=2" output.mp4

[参数]
overlay="(main_w/2)-(overlay_w/2):(main_h/2)-(overlay_h)/2" 设置水印的位置，居中显示
```
参数 overlay 详解

* overlay 设置位置格式：`overlay="x:y[:1]"
> * x:y 以左上的视频界面顶点为原点，向右为 x 轴正方向，向下为 y 轴正方向的直角坐标系中一点的横纵坐标
> * :1  表示支持透明水印
overlay 可选参数 | 说明 
------ | ------ 
main_w | 视频单帧图像宽度
main_h | 视频单帧图像高度
overlay_w | 水印图片的宽度
overlay_h | 水印图片的高度
(main_w/2)-(overlay_w/2):(main_h/2)-(overlay_h)/2 | 相对位置（居中显示）
10:10 | 绝对位置（距离上边和左边都是 10 像素）	
main_w-overlay_w-10:10 | 绝对位置（距离上边和右边都是 10 像素）


> * 水印图片的尺寸不能大于视频单帧图像尺寸，否则会出错

### 使用 FFmpeg 提取视频中的音频文件( aac、mp3 等 )

``` shell
# 一、提取的音频格式是 mp3 的情况
# 先查看自己的 ffmpeg 的库依赖有没有编码 mp3 的库（通常是 libmp3lame，而且一般安装 ffmpeg 时只有解码 mp3 的库）
ffmpeg -codecs | grep mp
# 提取视频中音，音频格式为 mp3
ffmpeg -i input.mp4 -f mp3 -vn output.mp3
# 或
ffmpeg -i input.mp4 -acodec libmp3lame -vn output.mp3
[参数]
-vn 禁止视频输出 
-f 输出编码格式
-acodec 音频编码器
# 二、提取的音频格式是 acc 的情况
# 一般 acc 编码器默认已经装上
ffmpeg -i input.mp4 -c copy output.acc
```

### 使用 FFmpeg 合并多个视频或多个音频

#### 一、合并多个音频

``` shell
ffmpeg -i input1.mp3 -i input2.mp4 output.mp3
```
#### 二、合并多个视频

> [更多方法](https://blog.csdn.net/doublefi123/article/details/47276739)

**FFmpeg concat 分离器（需要 FFmpeg 1.1 以上版本，最通用方法）**

1. 先创建一个文本文件(.txt)
```
# 例如文件 inputfilelist.txt 内容
file 'input1.mp4'
file 'input2.mp4'
file 'input3.mp4'
```
> 文件新建在当前目录下，文件存放待合并的视频文件名，注意格式：file 'xxx'
2. 然后执行命令
``` shell
ffmpeg -f concat -i inputfilelist.txt -c copy output.mp4
```
### 使用 FFmpeg 将字幕文件集成到视频文件

#### 字幕文件格式间转换

``` shell
# 将 .srt 文件转换为 .ass 文件
ffmpeg -i subtitle.srt subtitle.ass
# 将 .ass 文件转换为 .srt 文件
ffmpeg -i subtitle.ass subtitle.srt
```

* 由于 mp4 容器，不像 mkv 等容器有自己的字幕流
* mkv 这种容器的视频格式中，会带有一个字幕流，可以在播放中，控制字幕的显示与切换，也可以通过工具或命令，将字幕从视频中分离出来
* mp4 格式的容器，是不带字幕流的，所以如果要将字幕添加进去，就需要将字幕文件烧进视频中去。烧进去的视频，不能再分离出来，也不能控制字幕的显示与否

``` shell
# 比如将 input.srt 烧入 input.mp4 中，将合并的视频拷到 output.mp4
# input.srt、input.mp4、output.mp4都是相对当前目录下 
ffmpeg -i input.mp4 -vf subtitles=input.srt output.srt

[参数]
-y :覆盖同名的输出文件 
-i  ：资源文件
-vf：一般用于设置视频的过滤器 ( set video filters )
subtitles= ：后面跟字幕文件，可以是 srt，ass
```

## ffplay
* ffplay 是以 FFmpeg 框架为基础，外加渲染音视频的库 libSDL 构建的媒体文件播放器

### 格式 - `ffplay [选项] ['输入文件']`

### 主要选项

```
'-x width'        强制以 "width" 宽度显示
'-y height'       强制以 "height" 高度显示
'-an'             禁止音频
'-vn'             禁止视频
'-ss pos'         跳转到指定的位置(秒)
'-t duration'     播放 "duration" 秒音/视频
'-bytes'          按字节跳转
'-nodisp'         禁止图像显示(只输出音频)
'-f fmt'          强制使用 "fmt" 格式
'-window_title title'  设置窗口标题(默认为输入文件名)
'-loop number'    循环播放 "number" 次(0将一直循环)
'-showmode mode'  设置显示模式

可选的 mode
'0, video'    显示视频
'1, waves'    显示音频波形
'2, rdft'     显示音频频带
默认值为 'video'，你可以在播放进行时，按 "w" 键在这几种模式间切换
'-i input_file'   指定输入文件
```

### 一些高级选项
```
'-sync type'          设置主时钟为音频、视频、或者外部。默认为音频。主时钟用来进行音视频同步
'-threads count'      设置线程个数
'-autoexit'           播放完成后自动退出
'-exitonkeydown'      任意键按下时退出
'-exitonmousedown'    任意鼠标按键按下时退出
'-acodec codec_name'  强制指定音频解码器为 "codec_name"
'-vcodec codec_name'  强制指定视频解码器为 "codec_name"
'-scodec codec_name'  强制指定字幕解码器为 "codec_name"
```

### 一些快捷键
```
'q, ESC'            退出
'f'                 全屏
'p, SPC'            暂停
'w'                 切换显示模式(视频/音频波形/音频频带)
's'                 步进到下一帧
'left/right'        快退/快进 10 秒
'down/up'           快退/快进 1 分钟
'page down/page up' 跳转到前一章/下一章(如果没有章节，快退/快进 10 分钟)
'mouse click'       跳转到鼠标点击的位置(根据鼠标在显示窗口点击的位置计算百分比)
```

## ffprobe

* ffprobe 是 ffmpeg 命令行工具中是用来查看媒体文件格式的工具

``` shell
xcq@xcq-HP-Pavilion-Notebook:~/桌面$ ffprobe test.mp4
ffprobe version 3.4.4-0ubuntu0.18.04.1 Copyright (c) 2007-2018 the FFmpeg developers
  built with gcc 7 (Ubuntu 7.3.0-16ubuntu3)
  configuration: --prefix=/usr --extra-version=0ubuntu0.18.04.1 --toolchain=hardened --libdir=/usr/lib/x86_64-linux-gnu --incdir=/usr/include/x86_64-linux-gnu --enable-gpl --disable-stripping --enable-avresample --enable-avisynth --enable-gnutls --enable-ladspa --enable-libass --enable-libbluray --enable-libbs2b --enable-libcaca --enable-libcdio --enable-libflite --enable-libfontconfig --enable-libfreetype --enable-libfribidi --enable-libgme --enable-libgsm --enable-libmp3lame --enable-libmysofa --enable-libopenjpeg --enable-libopenmpt --enable-libopus --enable-libpulse --enable-librubberband --enable-librsvg --enable-libshine --enable-libsnappy --enable-libsoxr --enable-libspeex --enable-libssh --enable-libtheora --enable-libtwolame --enable-libvorbis --enable-libvpx --enable-libwavpack --enable-libwebp --enable-libx265 --enable-libxml2 --enable-libxvid --enable-libzmq --enable-libzvbi --enable-omx --enable-openal --enable-opengl --enable-sdl2 --enable-libdc1394 --enable-libdrm --enable-libiec61883 --enable-chromaprint --enable-frei0r --enable-libopencv --enable-libx264 --enable-shared
  libavutil      55. 78.100 / 55. 78.100
  libavcodec     57.107.100 / 57.107.100
  libavformat    57. 83.100 / 57. 83.100
  libavdevice    57. 10.100 / 57. 10.100
  libavfilter     6.107.100 /  6.107.100
  libavresample   3.  7.  0 /  3.  7.  0
  libswscale      4.  8.100 /  4.  8.100
  libswresample   2.  9.100 /  2.  9.100
  libpostproc    54.  7.100 / 54.  7.100
Input #0, mov,mp4,m4a,3gp,3g2,mj2, from 'test.mp4':
  Metadata:
    major_brand     : isom
    minor_version   : 1
    compatible_brands: isomavc1
    creation_time   : 2018-07-16T15:13:16.000000Z
  Duration: 00:08:46.07, start: 0.000000, bitrate: 2577 kb/s
  # 该视频文件的时长是 8 分 46 秒 7 毫秒，开始播放时间是 0，整个文件的比特率是 2577 Kbit/s
    Stream #0:0(und): Video: h264 (High) (avc1 / 0x31637661), yuv420p, 1920x1080 [SAR 1:1 DAR 16:9], 2446 kb/s, 23.98 fps, 23.98 tbr, 24k tbn, 47.95 tbc (default)
    # 第一个流是视频流，编码格式是 h264 格式( 封装格式为 AVC1 )，每一帧的数据表示为 yuv420p，分辨率为 1920 × 1080，这路流的比特率为2466 Kbit/s，帧率为每秒钟 24 帧
    Metadata:
      creation_time   : 2018-07-16T15:13:16.000000Z
    Stream #0:1(und): Audio: aac (LC) (mp4a / 0x6134706D), 44100 Hz, stereo, fltp, 127 kb/s (default)
    # 第二个流是音频流，编码方式为 ACC（ 封装格式为 MP4A ），并且采用的 Profile（ 配置文件 ）是 LC 规格，采样率是 44.1 KHz，声道是立体声，这路流的比特率 92 Kbit/s
    Metadata:
      creation_time   : 2018-07-16T14:53:06.000000Z
```

颜色编码：其中YUV420是视频中通常采用的颜色编码方式，Y表示亮度，而U，V则与颜色相关，而420则分别对应着存储相应分量所占用的比特数之比。其实采用这种编码方式就是为了早期彩色电视与黑白电视能更好的相容

tbn is the time base in AVStream that has come from the container, I
think. It is used for all AVStream time stamps.

tbc is the time base in AVCodecContext for the codec used for a
particular stream. It is used for all AVCodecContext and related time
stamps.

tbr is guessed from the video stream and is the value users want to see
when they look for the video frame rate, except sometimes it is twice
what one would expect because of field rate versus frame rate.

fps 自然的是 frame per second，就是帧率了。

所以tbn和tbc应该都是在相应层上的时间单元，比如tbn=2997就相当于在视频流层把1s的时间分成了2997个时间单元，如此精细可以更好的与其他流比如音频流同步，对应着fps=29.97就表示每100个时间单元中有一帧。

时间同步方式：
问题来了：fps=29.97这是一个小数啊，我如果直接利用公式 frame number = time * fps 得到了也不是一个整数啊，而帧号应该是一个整数才对。

首先，29.97f/s这个变态的数是如何得到的？这起源于早期的NTSC电视制式，而现代的数字编码只是为了兼容而沿用了它的标准。其实在标准制定 时，NTSC采用的是30f/s的帧率，只是后来為了消除由彩色信号及伴音信号所產生的圖像干擾，每秒幀幅由30幀稍微下調至29.97幀，同時線頻由 15750Hz稍微下降至15734.26Hz

然后，带小数点的帧率如何实现呢，显然每一秒不可能显示相同个数的帧。实际上存在着叫做SMPTE Non-Drop-Frame和SMPTE Drop-Frame的时间同步标准，也就是说在某些时候，会通过丢掉一些帧的方式来将时间同步上。

比如刚才提到的29.97帧率，我们可以计算：29.97 f/sec = 1798.2 f/min = 107892 f/hour;
对于30f/s的帧率我们可以计算： 30 f/s = 1800 f/s = 108000 f/hour;

这样，如果利用每秒30帧的速度来采集视频，而用29.97f/s的速率来播放视频，每个小时就少播放了108帧，这样播放时间会比真实时间变慢。为了解决这个问题，SMPTE 30 Drop-Frame就采取了丢掉这108帧的方式，具体策略是每1分钟丢两帧，如果是第10分钟则不丢，所以每小时丢掉的帧数是：2×60 – 2×6 = 108 帧。更具体的信息，

25 tbr代表帧率；1200k tbn代表文件层（st）的时间精度，即1S=1200k，和duration相关；50 tbc代表视频层（st->codec）的时间精度，即1S=50，和strem->duration和时间戳相关。

25 tbr代表帧率；
90k tbn代表文件层（st）的时间精度，即1S=1200k，和duration相关；
50   tbc代表视频层（st->codec）的时间精度，即1S=50，和strem->duration和时间戳相关。

https://www.jianshu.com/p/bfec3e6d3ec8

https://www.jianshu.com/p/5b78a91f1091

显示帧信息
``` shell
ffprobe -show_frames test.mp4
```

查看包信息
``` shell
ffprobe -show_packets test.mp4
```

## 参考
[20 篇 ffmpeg 学习](https://www.cnblogs.com/renhui/category/1165051.html)
[ 系统学习 ](https://blog.csdn.net/leixiaohua1020/article/details/15811977)

