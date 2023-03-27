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
	composer create-project symfony/skeleton app
	cd ./app && \
	composer require webapp --no-interaction && \
	composer require friendsofsymfony/http-cache-bundle symfony/http-client nyholm/psr7 guzzlehttp/promises webpack && \
	composer require nkeneng/httpcachebundle-varnish-config:@dev && \
	php vendor/nkeneng/httpcachebundle-varnish-config/src/setup.php

build:
	docker build --build-arg PROJECT=$(PROJECT) -t $(PROJECT)-webpack -f dockerfiles/webpack_Dockerfile . && \
    docker build --build-arg PROJECT=$(PROJECT) -t $(PROJECT)-php -f dockerfiles/php_Dockerfile . && \
	docker build --build-arg PROJECT=$(PROJECT) -t $(PROJECT)-php-dev -f dockerfiles/php_dev_Dockerfile . && \
	docker build --build-arg PROJECT=$(PROJECT) -t $(PROJECT)-caddy -f dockerfiles/caddy_Dockerfile .

up:
	$(DOCKER_COMPOSE) up -d
