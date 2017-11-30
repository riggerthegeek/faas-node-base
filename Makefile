build:
	docker build --file=./Dockerfile --tag ${DOCKER_USER}/faas-node .
.PHONY: build

build-armhf:
	docker build --file=./Dockerfile.armhf --tag ${DOCKER_USER}/faas-node:latest-armhf .
.PHONY: build-armhf

publish:
	docker push ${DOCKER_USER}/faas-node:latest
.PHONY: publish

publish-armhf:
	docker push ${DOCKER_USER}/faas-node:latest-armhf
.PHONY: publish-armhf
