build:
	docker build --file=./Dockerfile --tag ${DOCKER_USER}/faas-node .
.PHONY: build

build-armhf:
	docker build --file=./Dockerfile.armhf --tag ${DOCKER_USER}/faas-node:latest-armhf .
.PHONY: build-armhf

publish:
	docker push ${TAG_NAME}:latest
.PHONY: publish

publish-armhf:
	docker push ${TAG_NAME}:latest-armhf
.PHONY: publish-armhf
