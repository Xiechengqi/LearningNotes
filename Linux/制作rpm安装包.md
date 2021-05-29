# 制作 rpm 安装包



### **`demo`**

``` yaml
Name:           hellorpm           #名字为源码tar.gz 包的名字 
Version:        1.0.0             #版本号，一定要与tar.gz包的一致哦 
Release:        1%{?dist}         #释出号，也就是第几次制作rpm 
Summary:       helloword   #软件包简介，最好不要超过50字符 

License:        GPL                   #许可，GPL还是BSD等  
URL:            #可以写一个网址 
Packager:       abel 
Source0:        %{name}-%{version}.tar.gz   
#定义用到的source，也就是你的源码

BuildRoot:      %_topdir/BUILDROOT         
#这个是软件make install 的测试安装目录.

BuildRequires:  gcc,make                           #制作过程中用到的软件包 
Requires:       python-apscheduler >= 2.1.2-1.el7,python-daemon >= 1.6-1.el7  #软件运行依赖的软件包，也可以指定最低版本如 bash >= 1.1.1 
%description                #描述，随便写                 
%prep                          ＃打包开始                    
%setup -q                      #这个作用静默模式解压并cd                               


%build              #编译制作阶段，主要目的就是编译，如果不用编译就为空 
./configure \                                     
 %{?_smp_mflags}          #make后面的意思是：如果就多处理器的话make时并行编译 

%install                        #安装阶段                        
rm -rf %{buildroot}             #先删除原来的安装的，如果你不是第一次安装的话 
 cp -rp %_topdir/BUILD/%{name}-%{version}/*  $RPM_BUILD_ROOT 
#将需要需要打包的文件从BUILD 文件夹中拷贝到BUILDROOT文件夹下。

#下面的几步pre、post、preun、postun 没必要可以不写 
%pre        #rpm安装前制行的脚本 

%post       #安装后执行的脚本 

%preun      #卸载前执行的脚本 

%postun     #卸载后执行的脚本 

%clean #清理段,删除buildroot 
rm -rf %{buildroot} 


%files  #rpm要包含的文件 
%defattr (-,root,root,-)   #设定默认权限，如果下面没有指定权限，则继承默认 
/etc/hello/word/helloword.c           #将你需要打包的文件或目录写下来

###  7.chagelog section  改变日志段 
%changelog 
```



### **`golang`**

``` yaml
#软件包简要介绍
Summary: build refresh_agent
#软件包的名字
Name: refresh_agent
#软件包的主版本号
Version: 0.0.1
#软件包的次版本号
Release: 1
#源代码包，默认将在上面提到的SOURCES目录中寻找
Source0: %{name}-%{version}.tar.gz
#授权协议
License: GPL
#软件分类
Group: Development/Tools
#软件包的内容介绍
%description
refresh_agent服务
#表示预操作字段，后面的命令将在源码代码BUILD前执行
%prep
#BUILD字段，将通过直接调用源码目录中自动构建工具完成源码编译操作
%build
cd /devops/app/go/src/refresh_agent
go build -o refresh_agent cmd/agent_bin.go
#file
#安装字段
%install
# 二进制执行文件
mkdir -p ${RPM_BUILD_ROOT}/usr/local/bin/
cp -f /devops/app/go/src/refresh_agent/refresh_agent  ${RPM_BUILD_ROOT}/usr/local/bin/refresh_agent

# 日志目录
mkdir -p ${RPM_BUILD_ROOT}/bbd/logs/refresh_agent

# 配置文件
mkdir -p ${RPM_BUILD_ROOT}/etc/refresh_agent
cp -f /devops/app/go/src/refresh_agent/etc/online.config.ini ${RPM_BUILD_ROOT}/etc/refresh_agent/config.ini

#logrotate
mkdir -p ${RPM_BUILD_ROOT}/etc/logrotate.d
cp -f /devops/app/go/src/refresh_agent/etc/refresh_agent_logrotate.conf ${RPM_BUILD_ROOT}/etc/refresh_agent/refresh_agent_logrotate.conf

#日志搜集
mkdir -p ${RPM_BUILD_ROOT}/etc/rsyslog.d
cp -f /devops/app/go/src/refresh_agent/scripts/refresh_agent.conf ${RPM_BUILD_ROOT}/etc/rsyslog.d/refresh_agent.conf

# 控制脚本
mkdir -p ${RPM_BUILD_ROOT}/etc/init.d
cp -f /devops/app/go/src/refresh_agent/scripts/refresh_agent.sh  ${RPM_BUILD_ROOT}/etc/init.d/refresh_agent


%post
# 添加开机自启动
# 更改权限
chmod 775 /etc/init.d/refresh_agent
# 加入自启动
chkconfig --add refresh_agent

echo -e "has added refresh_agent to chkconfig \n"


# 安装启动
/etc/init.d/refresh_agent start
echo -e "start log rewrite to /var/log/messsge \n"


#调用源码中安装执行脚本
#文件说明字段，声明多余或者缺少都将可能出错
%files
%defattr(-,root,root)
/usr/local/bin/refresh_agent
/etc/init.d/refresh_agent
/etc/rsyslog.d/refresh_agent.conf
/etc/refresh_agent/refresh_agent_logrotate.conf

%dir
/etc/refresh_agent
/bbd/logs/refresh_agent
```





### **`wireguard`**

``` yaml
# https://gist.github.com/thatsamguy/c195142544840b792de8097638d31f07
	
# Attribution: originally based on debian package
# URL: http://http.debian.net/debian/pool/main/w/wireguard/wireguard_0.0.20160708.1-experimental1.debian.tar.xz

Summary:	fast, modern, secure kernel VPN tunnel
Name:		wireguard
Version:	0.0.20160722
Release:	%mkrel 1
Group:		Networking/Other
License:	GPLv2
URL:		https://www.wireguard.io
Source0:	https://git.zx2c4.com/WireGuard/snapshot/WireGuard-experimental-%version.tar.xz
BuildRequires:	dkms
BuildRequires:	mnl-devel
BuildRequires:	pkgconfig

%description
WireGuard is a novel VPN that runs inside the Linux Kernel and uses
state-of-the-art cryptography (the "Noise" protocol). It aims to be
faster, simpler, leaner, and more useful than IPSec, while avoiding
the massive headache. It intends to be considerably more performant
than OpenVPN. WireGuard is designed as a general purpose VPN for
running on embedded interfaces and super computers alike, fit for
many different circumstances. It runs over UDP.

%package -n	dkms-%{name}
Summary:	WireGuard kernel module
Group:		System/Kernel and hardware
BuildArch:	noarch
Provides:	kmod(wireguard.ko) = %{version}
Requires:	 dkms
Requires(post):	 dkms
Requires(preun): dkms

%description -n dkms-%{name}
Kernel support for WireGuard

%package -n	%{name}-tools
Summary:	WireGuard cli tools
Group:		System/Kernel and hardware
Requires:	dkms-%{name} = %{version}
%description -n %{name}-tools
Command-line tools to interactive with the WireGuard kernel module.
Currently, it provides only a single tool:
wg: set and retrieve configuration of WireGuard interfaces

%prep
%setup -q -n WireGuard-experimental-%{version}

%build
cd src;
%make

%install
install -d -m755 %{buildroot}%{_usrsrc}/%{name}-%{version}-%{release}
install -d -m755 %{buildroot}%{_usrsrc}/%{name}-%{version}-%{release}/crypto
cp -a src/*.c %{buildroot}%{_usrsrc}/%{name}-%{version}-%{release}
cp -a src/*.h %{buildroot}%{_usrsrc}/%{name}-%{version}-%{release}
cp -a src/crypto/*.c %{buildroot}%{_usrsrc}/%{name}-%{version}-%{release}/crypto
cp -a src/crypto/*.h %{buildroot}%{_usrsrc}/%{name}-%{version}-%{release}/crypto
cp -a src/crypto/*.S %{buildroot}%{_usrsrc}/%{name}-%{version}-%{release}/crypto
cp -a src/Makefile %{buildroot}%{_usrsrc}/%{name}-%{version}-%{release}
cp -ar src/tests/ %{buildroot}%{_usrsrc}/%{name}-%{version}-%{release}
cp -a src/Kbuild %{buildroot}%{_usrsrc}/%{name}-%{version}-%{release}
cp -a src/Kconfig %{buildroot}%{_usrsrc}/%{name}-%{version}-%{release}

cat > %{buildroot}%{_usrsrc}/%{name}-%{version}-%{release}/dkms.conf << EOF
PACKAGE_NAME="wireguard"
PACKAGE_VERSION=%{version}-%{release}
BUILT_MODULE_NAME="wireguard"
DEST_MODULE_LOCATION="/kernel/net"
AUTOINSTALL=yes

# requires kernel 4.1 or greater:
BUILD_EXCLUSIVE_KERNEL="^(4\.[^0]|[5-9])"
EOF

install -d %{buildroot}%{_mandir}/man8
install -m0644 src/tools/*.8 %{buildroot}%{_mandir}/man8/

install -d -m755 %{buildroot}%{_bindir}
install -m755 src/tools/wg %{buildroot}%{_bindir}

%post -n dkms-%{name}
/usr/sbin/dkms --rpm_safe_upgrade add -m %{name} -v %{version}-%{release} &&
/usr/sbin/dkms --rpm_safe_upgrade build -m %{name} -v %{version}-%{release} &&
/usr/sbin/dkms --rpm_safe_upgrade install -m %{name} -v %{version}-%{release} --force

%preun -n dkms-%{name}
/usr/sbin/dkms --rpm_safe_upgrade remove -m %{name} -v %{version}-%{release} --all

%files -n dkms-%name
%{_usrsrc}/%{name}-%{version}-%{release}

%files -n %{name}-tools
%doc COPYING README.md
%{_mandir}/man8/*
%{_bindir}/wg
```

