

//下载
wget -i -c http://dev.mysql.com/get/mysql57-community-release-el7-10.noarch.rpm

//安装
yum -y install mysql57-community-release-el7-10.noarch.rpm

yum -y install mysql-community-server

//启动
systemctl start  mysqld.service

//查看root初始密码
grep "password" /var/log/mysqld.log

//使用root登录mysql
mysql -uroot -p

//设置安全级别
set global validate_password_policy=0

//默认密码长度为8，可以设置为其它值，最小4位
set global validate_password_length=4

//修改root密码
ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';

//可视化工具的登录授权：(如果授权不成功，请查看防火墙)
grant all on *.* to root@'%' identified by 'root';
