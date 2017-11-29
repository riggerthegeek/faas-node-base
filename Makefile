build:
	docker build --file=./Dockerfile --tag ${DOCKER_USER}/faas-node .
	docker build --file=./Dockerfile.armhf --tag ${DOCKER_USER}/faas-node:latest-armhf .
.PHONY: build

publish:
.PHONY: publish
