DOCKER_COMPOSE_FILE ?= docker-compose.yml
PROJECT ?= stack
SCALE ?= front=1

COMPOSE_ARGS = -f $(DOCKER_COMPOSE_FILE) -p $(PROJECT)

all:
	@echo make DOCKER_COMPOSE_FILE=$(DOCKER_COMPOSE_FILE) up
	@echo make DOCKER_COMPOSE_FILE=$(DOCKER_COMPOSE_FILE) scale SCALE="front=2"
	@echo make DOCKER_COMPOSE_FILE=$(DOCKER_COMPOSE_FILE) rm
config:
	docker-compose $(COMPOSE_ARGS) config
up: config
	export DEBUG="1" ; \
	export PROJECT="$(PROJECT)" ; \
	docker-compose $(COMPOSE_ARGS) up -d
stop:
	docker-compose $(COMPOSE_ARGS) stop
down:
	docker-compose $(COMPOSE_ARGS) down
build:
	docker-compose $(COMPOSE_ARGS) build

rm: stop down
	docker-compose $(COMPOSE_ARGS) rm -f -v
logs:
	docker-compose $(COMPOSE_ARGS) logs
scale:
	export DEBUG="1" ; \
	export PROJECT="$(PROJECT)" ; \
	docker-compose $(COMPOSE_ARGS) scale $(SCALE)
show:
	@docker inspect -f '{{.Name | printf "[%s]\n" }}{{ .Name }} ansible_ssh_host={{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}} ansible_ssh_user=docker'  $$(docker ps -q -f name=$(PROJECT))|sed -e 's|/||g'
