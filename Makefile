CONTAINER_NAME	?=	$(shell basename -s .git `git config --get remote.origin.url`)
IMAGE_NAME		?=	$(shell basename -s .git `git config --get remote.origin.url`)

.PHONY: help
help:
	@echo "Docker image Makefile for ${CONTAINER_NAME}"
	@echo "Available Makefile Options:"
	@echo "    clean: cleans up any previously built containers."
	@echo "    dist: builds the docker."
	@echo "    kill: stop the container if an instance is already running."
	@echo "    run: runs the docker container \`initctl_faker\` daemon."
	@echo "    shell: enter into the container with bash."
	@echo "    test: verifies that ansible is installed on the newly"
	@echo "          built container."
	@echo "    all: clean env, build dist, run container as daemon, test."

info:
	@echo "Container: ${CONTAINER_NAME}"
	@echo "Image: ${IMAGE_NAME}"

.PHONY: all
all: clean dist run test

.PHONY: kill
kill: 
	@docker stop ${CONTAINER_NAME} || echo no container to remove && true

.PHONY: rm
rm:
	@docker rm ${CONTAINER_NAME} || echo no container to remove && true

.PHONY: clean
clean: rm kill
	@docker image rm ${CONTAINER_NAME} || echo no image to remove && true

.PHONY: dist
dist: clean
	docker build -t ${IMAGE_NAME} .

.PHONY: run
run: info
	docker run -d --name ${CONTAINER_NAME} --privileged \
	  -v /sys/fs/cgroup:/sys/fs/cgroup:ro ${IMAGE_NAME}

.PHONY: shell
shell:
	docker exec -it ${CONTAINER_NAME} /bin/bash

.PHONY: test
test:
	docker exec -it ${CONTAINER_NAME} env TERM=xterm ansible --version
