# 预备

机器上安装helm、make工具

# 步骤

## 1. 将服务所需配置放到`Makefile`文件的同级目录的`etc`文件夹下.

> 注意: 配置文件中不能包含非文本文件. 否则k8s无法成功生成configmap.

## 2. 修改`Makefile`中`todo`指定的部分，包括如下变量.

### 2.1 必填参数

- 镜像仓库地址`IMAGE_ADDRESS`
- 镜像仓库项目`IMAGE_PROJECT`
- 镜像名`IMAGE_NAME`
- 镜像版本号`IMAGE_VERSION`
- helm chart版本号`CHART_VERSION`
- helm chart名`CHART_NAME`
- helm chart描述信息`CHART_DESC`
- 服务端口`PORT`

### 2.2 另外, 还可以添加环境变量、挂载配置文件等(如果你的服务需要的话)

- 环境变量: 在`yamls/values.yaml`的`env`部分可以添加环境
- 挂载目录: 镜像里配置文件所在目录, 在`yamls/values.yaml`中38行`mountPath`设置配置的挂载路径, 根据你的服务中配置路径填写该值.

## 3. 执行`make chart`, 生成的`tgz`文件即helm chart, 可上传至D3OS并部署.
