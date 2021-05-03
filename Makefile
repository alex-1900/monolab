.PHONY: build up down push pull

# variables
flow ?= all

#"registry-mirrors": [
#    "https://docker.mirrors.ustc.edu.cn"
#  ]

runner = docker-compose
filenames = nginx php-fpm php-cli redis
suffix = yml

ifeq ($(flow),all)
	filenames = nginx php-fpm php-cli redis
else ifeq ($(flow), php/fpm)
	filenames = nginx php-fpm
else ifeq ($(flow), php/cli)
	filenames = php-cli
else ifeq ($(flow), nginx)
	filenames = nginx
else ifeq ($(flow), redis)
	filenames = redis
else ifeq ($(flow), php/fpm_redis)
	filenames = nginx php-fpm redis
endif

files_field = $(foreach _name, $(filenames),-f src/$(_name).$(suffix))

# 运行镜像
prepare:
	mkdir -p ./src/runtime/data ./src/runtime/logs
	mkdir -p ./src/runtime/data/redis_node1 ./src/runtime/data/redis_node2 ./src/runtime/data/redis_node3
	mkdir -p ./src/runtime/logs/redis_node1 ./src/runtime/logs/redis_node2 ./src/runtime/logs/redis_node3

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
