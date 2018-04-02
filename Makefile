IMAGE = atc:v1.0.0

SOURCES = $(PWD)

DOCKER = docker run  --rm -P


DOCKER += -v "/home/:/home/"
DOCKER += -it

DOCKER += $(IMAGE)


image:
	docker build -t $(IMAGE) --build-arg USER_UID=$(shell id -u) ./

sh:
	$(DOCKER) /bin/bash



