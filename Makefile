build:
	docker build --file=./${DIR}/Dockerfile --tag ${DOCKER_USER}/faas-${DIR}-template ./${DIR}
	docker build --file=./${DIR}/Dockerfile.armhf --tag ${DOCKER_USER}/faas-${DIR}-template:latest-armhf ./${DIR}
.PHONY: build

build-all:
	DIR=node make build
.PHONY: build-all
