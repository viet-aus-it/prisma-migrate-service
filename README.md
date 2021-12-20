# Prisma Migrate Service

This service is used to run DB migrations/deployments in production
using Node 16 and Prisma 3.0.

## Prerequisites

- Docker 20+, Docker Compose 1.28+
- For macOS and Windows: The easiest way is to install [Docker Desktop](https://www.docker.com/products/docker-desktop "docker desktop").
  This will come with Docker and Docker Compose in a bundle.
- For Linux Users: You would need to:
    - Install [Docker Engine](https://docs.docker.com/engine/install/#server "docker engine")
    - Follow the [Linux post-installation steps](https://docs.docker.com/engine/install/linux-postinstall/ "Linux post-installation steps").
    - Install [Docker Compose](https://docs.docker.com/compose/install/ "docker compose")
- Valid Prisma Migration folder

## Building this service

```shell
docker build -t ghcr.io/viet-aus-it/db-migrate-service .
```

## Running this service with Docker run

```shell
# Passing env on the command line
docker run \
  --rm \
  -e "DATABASE_URL=postgresql://johndoe:randompassword@localhost:5432/mydb?schema=public" \
  --volume /path/to/prisma/migration/folder:/src/prisma \
  ghcr.io/viet-aus-it/db-migrate-service

# Using an env file
cp .env.sample .env # <- Fill this file out with valid credentials
docker run \
  --rm \
  --env-file ./.env \
  --volume /path/to/prisma/migration/folder:/src/prisma \
  ghcr.io/viet-aus-it/db-migrate-service
```

## Running in Docker Compose with a db service to test

```yaml
services:
  db:
    image: postgres:13
    env_file: ".env"

  db-deploy:
    depends_on:
      - db
    env_file: ".env"
```

```bash
docker-compose up -d db
docker-compose up db-deploy
```