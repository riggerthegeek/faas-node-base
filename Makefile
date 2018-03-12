DOCKER_IMG ?= faas-node
DOCKER_USER ?=

VERSION = "0.7.0"
VERSION_MAJOR = "0"
VERSION_MINOR = "0.7"
VERSION_TYPE = "latest"

TAG_NAME = ${DOCKER_IMG}
ifneq ($(DOCKER_USER), "")
TAG_NAME = ${DOCKER_USER}/${DOCKER_IMG}
endif

build:
	@echo "Building latest Docker images"
	docker build --file=./Dockerfile --tag ${TAG_NAME}:${VERSION_TYPE} .
	docker build --file=./Dockerfile.armhf --tag ${TAG_NAME}:${VERSION_TYPE}-arm .
.PHONY: build

publish:
	@echo "Tagging Docker images as v${VERSION}"
	docker tag ${TAG_NAME}:${VERSION_TYPE} ${TAG_NAME}:${VERSION}
	docker tag ${TAG_NAME}:${VERSION_TYPE} ${TAG_NAME}:${VERSION_MAJOR}
	docker tag ${TAG_NAME}:${VERSION_TYPE} ${TAG_NAME}:${VERSION_MINOR}

	docker tag ${TAG_NAME}:${VERSION_TYPE}-arm ${TAG_NAME}:${VERSION}-arm
	docker tag ${TAG_NAME}:${VERSION_TYPE}-arm ${TAG_NAME}:${VERSION_MAJOR}-arm
	docker tag ${TAG_NAME}:${VERSION_TYPE}-arm ${TAG_NAME}:${VERSION_MINOR}-arm

	@echo "Pushing images to Docker"
	docker push ${TAG_NAME}:${VERSION}
	docker push ${TAG_NAME}:${VERSION_TYPE}
	docker push ${TAG_NAME}:${VERSION_MAJOR}
	docker push ${TAG_NAME}:${VERSION_MINOR}

	docker push ${TAG_NAME}:${VERSION}-arm
	docker push ${TAG_NAME}:${VERSION_TYPE}-arm
	docker push ${TAG_NAME}:${VERSION_MAJOR}-arm
	docker push ${TAG_NAME}:${VERSION_MINOR}-arm
.PHONY: publish
