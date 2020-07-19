
//查看是否已安装JDK,卸载
yum list installed |grep java  

//卸载CentOS系统Java环境
//         *表时卸载所有openjdk相关文件输入  
yum -y remove java-1.8.0-openjdk*
//         卸载tzdata-java  
yum -y remove tzdata-java.noarch

//列出java环境安装包
yum -y list java*    

// 安装JDK,如果没有java-1.8.0-openjdk-devel就没有javac命令 
yum  install  java-1.8.0-openjdk   java-1.8.0-openjdk-devel

