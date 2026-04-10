# Developer Documentation

## Project goal

This project builds a complete containerized WordPress infrastructure using:

- Docker
- Docker Compose
- Custom Dockerfiles
- Named volumes
- A dedicated Docker network

## Build layout

The compose file defines three services:

- `nginx`
- `wordpress`
- `mariadb`

The services share:

- `netception` as the internal network.
- `wp_data` for WordPress files.
- `mariadb_data` for database persistence.

## Build instructions

### 1. Prepare the environment

Make sure Docker and Docker Compose are installed.

Create a `.env` file with all required variables, for example:

```env
MARIADB_ROOT_PASSWORD=your_root_password
MARIADB_DATABASE=wordpress
MARIADB_USER=wp_user
MARIADB_PASSWORD=wp_password
WP_ADMIN=admin
WP_ADMIN_PASS=admin_password
WP_ADMIN_EMAIL=admin@example.com
USER_LOGIN=user
USER_PASSWORD=user_password
USER_EMAIL=user@example.com
```

### 2. Build and start the stack

From the project root:

```bash
make build
```

This uses:

```bash
docker compose -f srcs/compose.yaml up --build -d
```

### 3. Check the containers

```bash
make ps
```

## Docker Compose configuration

The compose file defines:

- A custom network named `netception`.
- Two volumes:
  - `mariadb_data`
  - `wp_data`
- A MariaDB healthcheck.
- A dependency so WordPress waits for MariaDB to be healthy.
- Nginx port mapping:
  - `443:443`

## Service details

### Nginx
- Built from `srcs/requirements/nginx/Dockerfile`
- Installs `nginx`, `openssl`, and `curl`
- Creates a self-signed certificate
- Uses a custom nginx configuration file
- Runs in the foreground with `daemon off`

### WordPress
- Built from `srcs/requirements/wordpress/Dockerfile`
- Installs PHP 8.2 and required extensions
- Runs PHP-FPM on port `9000`
- Uses an entrypoint script to initialize the application

### MariaDB
- Built from `srcs/requirements/mariadb/Dockerfile`
- Installs MariaDB server and client
- Uses an entrypoint script for initialization

## Makefile targets

- `make up`: start the stack in detached mode.
- `make build`: rebuild and start the stack.
- `make down`: stop and remove the stack.
- `make stop`: stop the stack.
- `make ps`: show container status.
- `make clean`: remove containers and volumes.
- `make restart`: stop and start again.
- `make nuke`: remove the stack and prune Docker system resources.
- `make re`: clean and rebuild from scratch.

## Development workflow

A simple development loop is:

1. Modify a Dockerfile, config, or entrypoint script.
2. Run `make build`.
3. Test the stack in the browser.
4. Use `make down` or `make clean` when needed.

## Resetting the environment

To remove all project data and start over:

```bash
make clean
make build
```

If you also want to prune unused Docker resources:

```bash
make nuke
```

## Notes

- The project is isolated from the host through Docker networking.
- Persistent data is preserved unless volumes are removed.
- The self-signed certificate is generated at image build time for Nginx.
