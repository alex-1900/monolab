.PHONY: build up down push pull

# variables
flow ?= all

runner = docker-compose
filenames = nginx php-fpm php-cli
suffix = yml

ifeq ($(flow),all)
	filenames = nginx php-fpm php-cli
else ifeq ($(flow), php/fpm)
	filenames = nginx php-fpm
else ifeq ($(flow), php/cli)
	filenames = php-cli
else ifeq ($(flow), nginx)
	filenames = nginx
endif

files_field = $(foreach _name, $(filenames),-f src/$(_name).$(suffix))

# 运行镜像
build:
	$(runner) $(files_field) build $(option)

up:
	$(runner) $(files_field) up $(option)

down:
	$(runner) $(files_field) down $(option)

push:
	$(runner) $(files_field) push $(option)

pull:
	$(runner) $(files_field) pull $(option)
