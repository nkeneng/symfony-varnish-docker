include .env

DOCKER_COMPOSE = docker compose
DOCKER_COMPOSE_FILE = docker-compose.yml
ROOT_FOLDER = Portfolio

ifeq ($(shell uname -m),aarch64)
    export ARCH := arm64v8
else
    export ARCH := amd64
endif

install:
	composer create-project --no-interaction nkeneng/symfony-skeleton app
	cd ./app && \
	npm install --save-dev purgecss-webpack-plugin@4.1.3 sass sass-loader postcss-loader path glob-all file-loader  && \
	php vendor/nkeneng/httpcachebundle-varnish-config/src/setup.php

build:
	docker build --build-arg PROJECT=$(PROJECT) -t $(PROJECT)-webpack -f dockerfiles/webpack_Dockerfile . && \
    docker build --build-arg PROJECT=$(PROJECT) -t $(PROJECT)-php -f dockerfiles/php_Dockerfile . && \
	docker build --build-arg PROJECT=$(PROJECT) -t $(PROJECT)-php-dev -f dockerfiles/php_dev_Dockerfile . && \
	docker build --build-arg PROJECT=$(PROJECT) -t $(PROJECT)-caddy -f dockerfiles/caddy_Dockerfile .

up:
	$(DOCKER_COMPOSE) up -d
