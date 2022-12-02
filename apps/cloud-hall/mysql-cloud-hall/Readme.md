# cloud-hall

该镜像基于mysql-cloud-hall，安装redis、拷贝jdk、应用jar包后，运行镜像、启动redis、修改mysql权限后，再启动jar包

## web地址

http://10.206.68.2:8096

账号密码：
```
haier
Cloudhall123
```

## 镜像地址

```shell
registry-edge.cosmoplat.com/cloud-hall/cloud-hall:v0.2
```

> 版本`registry-edge.cosmoplat.com/cloud-hall/cloud-hall:v0.2.1`
> > 对于该版本, 只需启动镜像并进入容器，更新源、安装`redis`、启动`redis-server`、启动`cloud-hall`即可
> >
> > helm部署时，需开启`8096`端口

以下步骤基于版本`registry-edge.cosmoplat.com/cloud-hall/cloud-hall:v0.2`

## 运行镜像，进入容器

```shell
docker run --name -p 8096:8096 cloud-hall -d 3a1ca885e154
docker exec -it 101a5abc0fe2 /bin/bash
```

## 更新源

将./jar/sources.list替换容器内的/etc/apt/sources.list

```shell
cp /opt/sources.list /etc/apt/
```

## 容器中启动redis-server

```shell
apt-get update -y
apt-get install redis-server
```

```shell
redis-server
```

## 容器中 mysql

```shell
mysql> use mysql
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> GRANT REFERENCES,create,SELECT,INSERT,UPDATE,lock tables  ON cloud_hall.* TO 'root'@'%' IDENTIFIED BY '123456' WITH GRANT OPTION;
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql> GRANT REFERENCES,create,SELECT,INSERT,UPDATE,lock tables  ON cloud_hall.* TO 'root'@'127.0.0.1' IDENTIFIED BY '123456' WITH GRANT OPTION;
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql> flush privileges;
Query OK, 0 rows affected (0.00 sec)

mysql>
```

## 容器中启动cloud-hall服务

```shell
root@101a5abc0fe2:/# nohup /opt/jdk1.8.0_221/bin/java -jar /opt/cloud-hall4.jar > cloud-hall.log 2>&1 &
```
