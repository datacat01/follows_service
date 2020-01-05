.PHONY: help clean build image run release image docker stop

APP_NAME ?= `grep 'app:' mix.exs | sed -e 's/\[//g' -e 's/ //g' -e 's/app://' -e 's/[:,]//g'`
APP_VSN ?= `grep 'version:' mix.exs | cut -d '"' -f2`
BUILD ?= `git rev-parse --short HEAD`

help:
	@echo "$(APP_NAME):$(APP_VSN)-$(BUILD)"
	@perl -nle'print $& if m{^[a-zA-Z_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

clean: ## Clean build artifacts
	mix clean

run: ## Run the app from Docker
	# docker run $(APP_NAME):latest
	docker-compose up

stop:
	docker-compose down

image: ## Build a Docker image
	docker build --build-arg APP_NAME=$(APP_NAME) \
		--build-arg APP_VSN=$(APP_VSN) \
		-t $(APP_NAME):$(APP_VSN)-$(BUILD) \
		-t $(APP_NAME):latest .