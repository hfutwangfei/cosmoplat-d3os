# 预备

机器上安装helm、make工具

# 步骤

1. 将服务所需配置放到`Makefile`文件的同级目录的`etc`文件夹下.

2. 修改`Makefile`中`todo`指定的部分，包括如下变量.

- 镜像仓库地址`IMAGE_ADDRESS`
- 镜像仓库项目`IMAGE_PROJECT`
- 镜像名`IMAGE_NAME`
- 镜像版本号`IMAGE_VERSION`
- helm chart版本号`CHART_VERSION`
- helm chart名`CHART_NAME`
- helm chart描述信息`CHART_DESC`
- 服务端口`PORT`
- 挂载目录`ADD_VOLUME_VOLUMEMOUNTS_CONFIGMAP`: 镜像里配置文件所在目录

3. 执行`make chart`, 生成的`tgz`文件即helm chart, 可上传至D3OS并部署.
