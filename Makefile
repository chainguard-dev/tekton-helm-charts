CHART_NAME ?= tekton-pipeline
CHART_DIR = charts/${CHART_NAME}

# Versions of tekton components
PIPELINE_VERSION ?= v0.32.1
DASHBOARD_VERSION ?= v0.24.1
CHAINS_VERSION ?= v0.7.0

# Testing env var
KIND_CLUSTER_NAME=tekton-dev
KIND_LOG_LEVEL=6

build:
	rm -rf ${CHART_DIR}/Chart.lock
	helm lint ${CHART_DIR}

open_dashboard:
	$(shell kubectl port-forward svc/tekton-dashboard 9097:9097 -n tekton-pipelines &)

dev_cluster:
	 kind create cluster \
        --verbosity=${KIND_LOG_LEVEL} \
        --name ${KIND_CLUSTER_NAME} \
        --config ./kind.yaml \
        --retain && \
	  echo "Kubernetes cluster:" \
      kubectl get nodes -o wide

delete_cluster:
	kind delete cluster --name ${KIND_CLUSTER_NAME}

install: build
	helm install ${CHART_NAME} ${CHART_DIR}

upgrade: build
	helm upgrade -i ${CHART_NAME} ${CHART_DIR}

uninstall:
	helm uninstall ${CHART_NAME}

helm_install:
	ct install --charts ./charts/tekton-pipeline --config ct.yaml

helm_lint:
	ct lint --config ct.yaml

test_task:
	kubectl create -f ./tests/${CHART_DIR}
	tkn task ls
	tkn task describe echo-hello-world
	kubectl delete -f ./tests/${CHART_DIR}

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