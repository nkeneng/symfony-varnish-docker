DOCKER_COMPOSE = docker compose
DOCKER_COMPOSE_FILE = docker-compose.yml
ROOT_FOLDER = Portfolio

ifeq ($(shell uname -m),aarch64)
    export ARCH := arm64
else
    export ARCH := amd64
endif

install:
	composer create-project symfony/skeleton app
	cd ./app && \
	composer require webapp && \
	composer require friendsofsymfony/http-cache-bundle symfony/http-client nyholm/psr7 guzzlehttp/promises webpack && \
	composer require nkeneng/httpcachebundle-varnish-config:@dev && \
	php vendor/nkeneng/httpcachebundle-varnish-config/src/setup.php

build:
	docker build -t ${PROJECT}-webpack -f dockerfiles/webpack_Dockerfile . && \
    docker build -t ${PROJECT}-php -f dockerfiles/php_Dockerfile . && \
	docker build -t ${PROJECT}-php-dev -f dockerfiles/php_dev_Dockerfile . && \
	docker build -t ${PROJECT}-caddy -f dockerfiles/caddy_Dockerfile .

up:
	$(DOCKER_COMPOSE) up -d
