IMAGE_PREFIX = docker.causeex.com/dart
IMAGE_NAME = topic-provisioner
VERSION = latest

ifndef GITHUB_REF_NAME
	APP_VERSION := $(shell cat app.version)
else ifeq ("$(GITHUB_REF_NAME)", "master")
	APP_VERSION := "latest"
else ifeq ("$(GITHUB_REF_TYPE)", "tag")
	APP_VERSION := $(shell cat app.version)
else
	APP_VERSION := $(GITHUB_REF_NAME)
endif

docker-login:
	docker login -u ${DOCKER_HUB_USERNAME} -p ${DOCKER_HUB_PASSWORD}

docker-build:
	docker build -t $(IMG):$(APP_VERSION) .

docker-push: docker-login docker-build
	docker push $(IMG):$(APP_VERSION)
	docker logout

clean:
	docker images | grep $(IMAGE_NAME) | grep -v IMAGE | awk '{print $3}' | docker rmi -f
