# User Documentation

## What this project does

This project starts a WordPress website with:

- HTTPS access through Nginx.
- A MariaDB database.
- Persistent storage for the website and database.

## Requirements

Before running the project, make sure you have:

- Docker installed.
- Docker Compose installed.
- The project files available locally.
- A valid `.env` file with the required environment variables.

## Environment variables

The project expects the following variables:

- `MARIADB_ROOT_PASSWORD`
- `MARIADB_DATABASE`
- `MARIADB_USER`
- `MARIADB_PASSWORD`
- `WP_ADMIN`
- `WP_ADMIN_PASS`
- `WP_ADMIN_EMAIL`
- `USER_LOGIN`
- `USER_PASSWORD`
- `USER_EMAIL`

## Start the project

From the project root, run:

```bash
make build
```

This command builds the images and starts all services in detached mode.

## Other useful commands

### Start containers without rebuilding

```bash
make up
```

### Stop the project

```bash
make down
```

### Stop and remove volumes

```bash
make clean
```

### Restart the stack

```bash
make restart
```

### Show running containers

```bash
make ps
```

### Rebuild everything from scratch

```bash
make re
```

## Access the website

Once the containers are running, open your browser and go to:

```text
https://kbarru.42.fr
```

If your local DNS is not configured, you may need to map the domain to `127.0.0.1` in your hosts file.

## What happens at runtime

- Nginx serves the site over HTTPS.
- WordPress connects to MariaDB.
- WordPress is installed automatically using the configured environment variables.
- Persistent data is stored in Docker volumes.

## Stopping and cleaning

To stop the services:

```bash
make down
```

To stop services and delete volumes:

```bash
make clean
```

Use `make clean` carefully, because it removes database and WordPress data.
