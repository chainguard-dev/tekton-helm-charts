CHART_NAME = tekton-pipeline
CHART_DIR = charts/${CHART_NAME}

PIPELINE_VERSION=v0.32.1
DASHBOARD_VERSION=v0.24.1
CHAINS_VERSION=v0.7.0

KIND_CLUSTER_NAME=tekton-dev

KIND_LOG_LEVEL=6

build:
	rm -rf ${CHART_DIR}/Chart.lock
	helm lint ${CHART_DIR}

dev_cluster:
	 kind create cluster \
        --verbosity=${KIND_LOG_LEVEL} \
        --name ${KIND_CLUSTER_NAME} \
        --config ./kind.yaml \
        --retain && \
	  echo "Kubernetes cluster:" \
      kubectl get nodes -o wide

install: build
	helm install ${CHART_NAME} ${CHART_DIR}

uninstall: build
	helm uninstall ${CHART_NAME}

upgrade: build
	helm upgrade -i ${CHART_NAME} ${CHART_DIR}

test_task:
	kubectl create -f ${CHART_DIR}/templates/tests
	tkn task ls
	tkn task describe echo-hello-world
	kubectl delete -f ${CHART_DIR}/templates/tests

fetch_pipelines:
	rm -rf ./charts/tekton-pipeline/templates/
	mkdir -p ./charts/tekton-pipeline/templates
	wget https://github.com/tektoncd/pipeline/releases/download/${PIPELINE_VERSION}/release.yaml -O charts/tekton-pipeline/templates/release.yaml
	cd ./charts/tekton-pipeline/templates
	yq e ./charts/tekton-pipeline/templates/release.yaml -s '"./charts/tekton-pipeline/templates/" + .kind + "-" + .metadata.name'
	rm -f ./charts/tekton-pipeline/templates/release.yaml

fetch_dashboard:
	rm -rf ./charts/tekton-${CHART_NAME}/templates/
	mkdir -p ./charts/tekton-${CHART_NAME}/templates
	wget https://github.com/tektoncd/dashboard/releases/download/${DASHBOARD_VERSION}/tekton-dashboard-release.yaml -O charts/tekton-${CHART_NAME}/templates/release.yaml
	cd ./charts/tekton-${CHART_NAME}/templates
	yq e ./charts/tekton-${CHART_NAME}/templates/release.yaml -s '"./charts/tekton-${CHART_NAME}/templates/" + .kind + "-" + .metadata.name'
	rm -f ./charts/tekton-${CHART_NAME}/templates/release.yaml

fetch_chains:
	rm -rf ./charts/${CHART_NAME}/templates/
	mkdir -p ./charts/${CHART_NAME}/templates
	wget https://github.com/tektoncd/chains/releases/download/${CHAINS_VERSION}/release.yaml -O charts/${CHART_NAME}/templates/release.yaml
	cd ./charts/${CHART_NAME}/templates
	yq e ./charts/${CHART_NAME}/templates/release.yaml -s '"./charts/${CHART_NAME}/templates/" + .kind + "-" + .metadata.name'
	rm -f ./charts/${CHART_NAME}/templates/release.yaml