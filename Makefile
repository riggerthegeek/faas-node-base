build:
	docker build --file=./${DIR}/Dockerfile --tag ${DOCKER_USER}/faas-${DIR}-template ./${DIR}
.PHONY: build

build-all:
	DIR=node make build
.PHONY: build-all
