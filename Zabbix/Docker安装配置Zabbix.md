

# Docker 安装配置 Zabbix

> * [官方安装介绍](https://www.zabbix.com/documentation/4.0/zh/manual/installation/containers)

## 直接安装整合好组件的 zabbix docker 镜像

```shell
docker run --name zabbix-appliance -t \
      -p 10051:10051 \
      -p 80:80 \
      -d zabbix/zabbix-appliance:latest
```



## zabbix 不同组件分别安装对应的 docker 镜像

一、运行 MySQL 数据库支持、基于 Nginx Web 服务器的 Zabbix Web 界面和 Zabbix Java gateway

1. 启动空的 MySQL 服务器实例

```shell
docker run --name mysql-server -t \
      -e MYSQL_DATABASE="zabbix" \
      -e MYSQL_USER="zabbix" \
      -e MYSQL_PASSWORD="zabbix_pwd" \
      -e MYSQL_ROOT_PASSWORD="root_pwd" \
      -d mysql:5.7 \
      --character-set-server=utf8 --collation-server=utf8_bin
```

2. 启动 Zabbix Java gateway 实例

``` shell
docker run --name zabbix-java-gateway -t \
      -d zabbix/zabbix-java-gateway:latest
```

3. 启动 Zabbix server 实例，并将其关联到已创建的 MySQL server 实例

```shell
docker run --name zabbix-server-mysql -t \
      -e DB_SERVER_HOST="mysql-server" \
      -e MYSQL_DATABASE="zabbix" \
      -e MYSQL_USER="zabbix" \
      -e MYSQL_PASSWORD="zabbix_pwd" \
      -e MYSQL_ROOT_PASSWORD="root_pwd" \
      -e ZBX_JAVAGATEWAY="zabbix-java-gateway" \
      --link mysql-server:mysql \
      --link zabbix-java-gateway:zabbix-java-gateway \
      -p 10051:10051 \
      -d zabbix/zabbix-server-mysql:latest
```

4. 启动 Zabbix Web 界面，并将其关联到已创建的 MySQL server 和 Zabbix server 实例

```shell
docker run --name zabbix-web-nginx-mysql -t \
      -e DB_SERVER_HOST="mysql-server" \
      -e MYSQL_DATABASE="zabbix" \
      -e MYSQL_USER="zabbix" \
      -e MYSQL_PASSWORD="zabbix_pwd" \
      -e MYSQL_ROOT_PASSWORD="root_pwd" \
      --link mysql-server:mysql \
      --link zabbix-server-mysql:zabbix-server \
      -p 80:80 \
      -d zabbix/zabbix-web-nginx-mysql:latest
```



二、运行 PostgreSQL 数据库支持的 Zabbix server、基于 Nginx Web 服务器的 Zabbix Web 界面和 SNMP trap 功能

1. 启动空的 PostgreSQL server 实例

```shell
docker run --name postgres-server -t \
      -e POSTGRES_USER="zabbix" \
      -e POSTGRES_PASSWORD="zabbix" \
      -e POSTGRES_DB="zabbix_pwd" \
      -d postgres:latest
```

2. 启动 Zabbix snmptraps 实例

```shell
docker run --name zabbix-snmptraps -t \
      -v /zbx_instance/snmptraps:/var/lib/zabbix/snmptraps:rw \
      -v /var/lib/zabbix/mibs:/usr/share/snmp/mibs:ro \
      -p 162:162/udp \
      -d zabbix/zabbix-snmptraps:latest
```

3. 启动 Zabbix server 实例，并将其关联到已创建的 PostgreSQL server 实例

```shell
docker run --name zabbix-server-pgsql -t \
      -e DB_SERVER_HOST="postgres-server" \
      -e POSTGRES_USER="zabbix" \
      -e POSTGRES_PASSWORD="zabbix" \
      -e POSTGRES_DB="zabbix_pwd" \
      -e ZBX_ENABLE_SNMP_TRAPS="true" \
      --link postgres-server:postgres \
      -p 10051:10051 \
      --volumes-from zabbix-snmptraps \
      -d zabbix/zabbix-server-pgsql:latest
```

4. 启动 Zabbix Web 界面，并将其关联到已创建的 PostgreSQL server 和 Zabbix server 实例

```shell
docker run --name zabbix-web-nginx-pgsql -t \
      -e DB_SERVER_HOST="postgres-server" \
      -e POSTGRES_USER="zabbix" \
      -e POSTGRES_PASSWORD="zabbix" \
      -e POSTGRES_DB="zabbix_pwd" \
      --link postgres-server:postgres \
      --link zabbix-server-pgsql:zabbix-server \
      -p 443:443 \
      -v /etc/ssl/nginx:/etc/ssl/nginx:ro \
      -d zabbix/zabbix-web-nginx-pgsql:latest
```