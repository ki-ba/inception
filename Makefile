COMPOSE_FILE=srcs/compose.yaml
NGINX_DIR=srcs/requirements/nginx
MARIADB_DIR=srcs/requirements/mariadb
WORDPRESS_DIR=srcs/requirements/wordpress

.PHONY: all
all: 
	docker compose -f $(COMPOSE_FILE) up

.PHONY: stop
stop:
	docker compose -f $(COMPOSE_FILE) down

.PHONY: status
status:
	docker compose -f $(COMPOSE_FILE) ps

.PHONY: build
build:
	docker build -t nginx $(NGINX_DIR)

.PHONY: clean
clean:
	docker system prune -af
