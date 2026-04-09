COMPOSE_FILE=srcs/compose.yaml
NGINX_DIR=srcs/requirements/nginx
MARIADB_DIR=srcs/requirements/mariadb
WORDPRESS_DIR=srcs/requirements/wordpress

COMPOSE=docker compose -f $(COMPOSE_FILE)

.PHONY: up 
up: 
	$(COMPOSE) up -d

.PHONY: down
down:
	$(COMPOSE) down

.PHONY: stop
stop:
	$(COMPOSE) stop

.PHONY: ps
status:
	$(COMPOSE) ps

.PHONY: build
build:
	$(COMPOSE) up --build -d

.PHONY: clean
clean:
	$(COMPOSE) down -v

.PHONY: restart
restart: stop
	$(MAKE) up

.PHONY: nuke
nuke:
	$(COMPOSE) down -t 1
	docker system prune -af

.PHONY: re
re: clean
	$(MAKE) build
