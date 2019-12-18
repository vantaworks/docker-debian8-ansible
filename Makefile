CONTAINER_NAME	?=	docker-debian8-ansible
IMAGE_NAME		?=	docker-debian8-ansible

.phony: help
help:
	@echo "Available Options:"
	@echo "    dist: builds the docker."
	@echo "    run: runs the docker container \`initctl_faker\` daemon."
	@echo "    test: verifies that ansible is installed on the newly"
	@echo "          built container."
	@echo "    clean: cleans up any previously built containers."

.phony: clean
clean:
	docker stop ${CONTAINER_NAME} || echo no container to remove && true
	docker rm ${CONTAINER_NAME} || echo no container to remove && true
	docker image rm ${CONTAINER_NAME} || echo no image to remove && true

.phony: dist
dist: clean
	docker build -t ${IMAGE_NAME} .

.phony: run
run:
	docker run -d \
	  --name ${CONTAINER_NAME} \
	  --privileged \
	  -v /sys/fs/cgroup:/sys/fs/cgroup:ro ${IMAGE_NAME}

.phony: test
test: dist run
	docker exec --tty ${CONTAINER_NAME} \
	  env TERM=xterm ansible --version
