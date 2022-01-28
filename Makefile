CHART_NAME = tekton-pipeline
CHART_DIR = charts/${CHART_NAME}

build:
	rm -rf ${CHART_DIR}/Chart.lock
	helm lint ${CHART_DIR}

install: build
	helm install ${CHART_NAME} ${CHART_DIR}

upgrade: build
	helm upgrade ${CHART_NAME} ${CHART_DIR}

test:
	kubectl create -f ${CHART_DIR}/tests
	tkn task ls
	tkn task describe echo-hello-world
	kubectl delete -f ${CHART_DIR}/tests



fetch_pipelines:
	rm -rf ./charts/tekton-pipeline/templates/
	mkdir -p ./charts/tekton-pipeline/templates
	wget https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml -O charts/tekton-pipeline/templates/release.yaml
	cd ./charts/tekton-pipeline/templates
	yq e ./charts/tekton-pipeline/templates/release.yaml -s '"./charts/tekton-pipeline/templates/" + .kind + "-" + .metadata.name'
	rm -f ./charts/tekton-pipeline/templates/release.yaml
