IMAGE_ADDRESS ?= registry-edge.cosmoplat.com
IMAGE_PROJECT ?= cloud-hall

IMAGE_NAME ?= cloud-hall
IMAGE_VERSION ?= v0.2.1

CHART_NAME ?= ${IMAGE_NAME}
CHART_VERSION ?= 0.1.0

.prepare:
	@rm -rf _output
	@mkdir -p _output/docker
	@mkdir -p _output/docker/hack
	@mkdir -p _output/docker/sql
	@mkdir -p _output/docker/jar

docker-build: .prepare
	echo "copy Dockerfile..."
	@cp deploy/docker/Dockerfile _output/docker/
	echo "copy setup.sh..."
	@cp hack/setup.sh _output/docker/hack
	echo "copy my.cnf and sql files..."
	@cp sql/* _output/docker/sql/
	echo "copy jar and others..."
	@cp jar/* _output/docker/jar/
	docker build --pull -t ${IMAGE_ADDRESS}/${IMAGE_PROJECT}/${IMAGE_NAME}:${IMAGE_VERSION} _output/docker
#	@rm -rf _output

docker-push:
	docker push ${IMAGE_ADDRESS}/${IMAGE_PROJECT}/${IMAGE_NAME}:${IMAGE_VERSION}

create-chart:
	helm create ${CHART_NAME}

SED_REPO ?= "s/repository:\ nginx/repository:\ ${IMAGE_ADDRESS}\/${IMAGE_PROJECT}\/${IMAGE_NAME}/g"
SED_TAG ?= "s/tag: \"\"/tag: \"${IMAGE_VERSION}\"/g"
PORT ?= 3306
SED_PORT ?= "s/port: 80/port: ${PORT}/g"
SED_DESC ?= "s/description: A Helm chart for Kubernetes/description: ${CHART_NAME}/g"
SED_CHART_VERSION ?= "s/version: 0.1.0/version: ${CHART_VERSION}/g"
SED_CHART_APP_VERSION ?= "s/appVersion: \"1.16.0\"/appVersion: \"${IMAGE_VERSION}\"/g"
CONTAINER_PORT ?= {{ .Values.service.port | default 80 }}
SED_CONTAINER_PORT ?= "s/containerPort: 80/containerPort: ${CONTAINER_PORT}/g"
# remove probes in deployment.yaml
SED_DELETE_PROBE :=
LIVENESS_PROBE ?= livenessProbe:
SED_DELETE_PROBE := /${LIVENESS_PROBE}/d
READINESS_PROBE ?= readinessProbe:
SED_DELETE_PROBE := ${SED_DELETE_PROBE};/${READINESS_PROBE}/d
PROBE_HTTP_GET ?= httpGet:
SED_DELETE_PROBE := ${SED_DELETE_PROBE};/${PROBE_HTTP_GET}/d
PROBE_PATH ?= path:\ \/
SED_DELETE_PROBE := ${SED_DELETE_PROBE};/${PROBE_PATH}/d
PROBE_PORT ?= port:\ http
SED_DELETE_PROBE := ${SED_DELETE_PROBE};/${PROBE_PORT}/d

# make sed-chart: modify chart information.
sed-chart:
	sed -i '' ${SED_REPO} ${CHART_NAME}/values.yaml
	sed -i '' ${SED_TAG} ${CHART_NAME}/values.yaml
	sed -i '' ${SED_PORT} ${CHART_NAME}/values.yaml
	sed -i '' ${SED_DESC} ${CHART_NAME}/Chart.yaml
	sed -i '' ${SED_CHART_VERSION} ${CHART_NAME}/Chart.yaml
	sed -i '' ${SED_CHART_APP_VERSION} ${CHART_NAME}/Chart.yaml
	sed -i '' ${SED_CONTAINER_PORT} ${CHART_NAME}/templates/deployment.yaml
	sed -i '' "${SED_DELETE_PROBE}" ${CHART_NAME}/templates/deployment.yaml

# add env
ADD_DEPLOYMENT_ENV_BEFORE ?= imagePullPolicy:\ {{\ .Values.image.pullPolicy\ }}
ADD_DEPLOYMENT_ENV_AFTER := ${ADD_DEPLOYMENT_ENV_BEFORE}
ADD_DEPLOYMENT_WAP ?= \\n
ADD_DEPLOYMENT_SPACE ?= ' '
ADD_DEPLOYMENT_SPACE_10 ?= '          '
ADD_DEPLOYMENT_SPACE_12 ?= '            '
ADD_DEPLOYMENT_SPACE_14 ?= '              '
ADD_DEPLOYMENT_ENV_ENV ?= env:
ADD_DEPLOYMENT_ENV_NAME ?= -\ name:
ADD_DEPLOYMENT_ENV_VALUE ?= value:
# env name:
ENV_TZ_NAME ?= TZ
ENV_TZ_VALUE ?= Asia\\/Shanghai
# env:
ADD_DEPLOYMENT_ENV_AFTER := ${ADD_DEPLOYMENT_ENV_AFTER}${ADD_DEPLOYMENT_WAP}
ADD_DEPLOYMENT_ENV_AFTER := ${ADD_DEPLOYMENT_ENV_AFTER}${ADD_DEPLOYMENT_SPACE_10}
ADD_DEPLOYMENT_ENV_AFTER := ${ADD_DEPLOYMENT_ENV_AFTER}${ADD_DEPLOYMENT_ENV_ENV}
# - name: TZ
#   value: Asia/Shanghai
ADD_DEPLOYMENT_ENV_AFTER := ${ADD_DEPLOYMENT_ENV_AFTER}${ADD_DEPLOYMENT_WAP}
ADD_DEPLOYMENT_ENV_AFTER := ${ADD_DEPLOYMENT_ENV_AFTER}${ADD_DEPLOYMENT_SPACE_12}
ADD_DEPLOYMENT_ENV_AFTER := ${ADD_DEPLOYMENT_ENV_AFTER}${ADD_DEPLOYMENT_ENV_NAME}
ADD_DEPLOYMENT_ENV_AFTER := ${ADD_DEPLOYMENT_ENV_AFTER}${ADD_DEPLOYMENT_SPACE}
ADD_DEPLOYMENT_ENV_AFTER := ${ADD_DEPLOYMENT_ENV_AFTER}${ENV_TZ_NAME}
ADD_DEPLOYMENT_ENV_AFTER := ${ADD_DEPLOYMENT_ENV_AFTER}${ADD_DEPLOYMENT_WAP}
ADD_DEPLOYMENT_ENV_AFTER := ${ADD_DEPLOYMENT_ENV_AFTER}${ADD_DEPLOYMENT_SPACE_14}
ADD_DEPLOYMENT_ENV_AFTER := ${ADD_DEPLOYMENT_ENV_AFTER}${ADD_DEPLOYMENT_ENV_VALUE}
ADD_DEPLOYMENT_ENV_AFTER := ${ADD_DEPLOYMENT_ENV_AFTER}${ADD_DEPLOYMENT_SPACE}
ADD_DEPLOYMENT_ENV_AFTER := ${ADD_DEPLOYMENT_ENV_AFTER}${ENV_TZ_VALUE}

# env in deployment
ADD_DEPLOYMENT_ENV ?= s/${ADD_DEPLOYMENT_ENV_BEFORE}/${ADD_DEPLOYMENT_ENV_AFTER}/g

add-env:
	sed -i '' ${ADD_DEPLOYMENT_ENV} ${CHART_NAME}/templates/deployment.yaml

package-chart:
	helm package ${CHART_NAME}

chart: create-chart sed-chart add-env package-chart

clean:
	rm -rf ${IMAGE_NAME}
	#rm -rf ${IMAGE_NAME}-*.tgz
	rm -rf _output
