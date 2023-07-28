# Prisma Migrate Service

This service is used to run DB migrations/deployments in production
using Node 18 and Prisma 4.0.

## Prerequisites

- Docker 20+, Docker Compose 1.28+
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
    image: postgres:15
    env_file: ".env"

  db-deploy:
    image: ghcr.io/viet-aus-it/prisma-migrate-service
    depends_on:
      - db
    env_file: ".env"
    volumes:
      - ./prisma:/src/prisma
```

```bash
docker-compose up -d db
docker-compose up db-deploy
```