COMPOSE_FILE=srcs/compose.yaml
NGINX_DIR=srcs/requirements/nginx
MARIADB_DIR=srcs/requirements/mariadb
WORDPRESS_DIR=srcs/requirements/wordpress

.PHONY: up 
up: 
	docker compose -f $(COMPOSE_FILE) up -d

.PHONY: down
down:
	docker compose -f $(COMPOSE_FILE) down

.PHONY: ps
status:
	docker compose -f $(COMPOSE_FILE) ps

.PHONY: build
build:
	docker compose build -f $(COMPOSE_FILE)

.PHONY: clean
clean:
	docker system prune -af

.PHONY: re
re: clean
	$(MAKE) build
