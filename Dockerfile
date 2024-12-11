FROM node:22.12-slim
WORKDIR /src

COPY ./package.json ./package.json
COPY ./pnpm-lock.yaml ./pnpm-lock.yaml
RUN npm install -g pnpm@9 && \
    pnpm install

RUN set -xe && \
    apt-get update && \
    apt-get install -y --no-install-recommends openssl && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/*

USER node
ENV NODE_ENV=production
ENTRYPOINT ["pnpm", "prisma:deploy"]
VOLUME ["/src/prisma"]
