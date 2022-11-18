# data-space 部署

---

## configmap：配置

> keystore.jks: configmap 无法解析

#### database-realm.properties

```yaml
databaseRealmProperties: |-
  jdbcdriver=com.mysql.jdbc.Driver
  url=jdbc:mysql://10.206.68.1:30234/datathread
  username=root
  password=FviqAJDYbu
  usertable=users
  usertablekey=id
  usertableuserfield=username
  usertablepasswordfield=password
  roletable=roles
  roletablekey=id
  roletablerolefield=rolename
  userroletable=user_role
  userroletableuserkey=user_id
  userroletablerolekey=role_id
  remoteurl=http://dt-co-server-test.hdt.cosmoplat.com
  loginflag=remote
```

1、数据库连接、用户、密码

字段：`url`, `username`, `password`

2、用户中心访问配置和标识（remoteurl表示远程访问用户中心认证，其他表示使用datathread中form-realm.properties用户配置）

字段：`remoteurl`

#### form-realm.properties

配置本地用户登录

#### jdbc.properties

```yaml
jdbcProperties: |-
  jdbc.driver=com.mysql.cj.jdbc.Driver
  jdbc.url=jdbc:mysql://10.206.68.1:30234/datathread?useSSL=false&autoReconnect=true&serverTimezone=GMT%2B8&rewriteBatchedStatements=true
  jdbc.username=root
  jdbc.password=FviqAJDYbu
  data.separate.base.on.jdbc=separate
```

1、数据库连接、用户、密码

字段：`jdbc.url`, `jdbc.username`, `jdbc.password`

#### sdc.properties

```yaml
sdc.properties: |-
...
  # pipeline store module
  # dataStore module store in local, objectStore module store in minio
  web.pipeline.store.module=objectStore
  web.pipeline.minio.store.endpoint=http://10.206.68.1:30290
  web.pipeline.minio.store.accessKey=YOURACCESSKEY
  web.pipeline.minio.store.secretKey=YOURSECRETKEY
  web.pipeline.minio.store.bucket.name=data-thread
```

1、配置minio（dataStore表示使用本地存储卷，挂在data目录；objectStore表示使用minio存储，挂在存储桶）

字段：minio连接地址、桶名称

#### remote-realm.properties

```yaml
remoteRealmProperties: |-
  remote.url=http://dt-co-server-test.hdt.cosmoplat.com
  login.flag=remote
  remote.user.create.interface=/center/sys-user/register
  remote.user.get.info.interface=/center/sys-user/getUserInfo
  remote.user.login.interface=/center/login
  remote.user.reset.password.interface=/center/sys-user/passwordReset
  remote.user.change.password.interface=/center/sys-user/operatePassword
  remote.user.update.interface=/center/sys-user/operateUser
  remote.user.list.query.interface=/center/sys-user/getUserList
  remote.user.group.list.query.interface=/center/sys-company/checkCompany
```

1、配置了对接用户中心的相关接口

字段：`remote.url`
