FROM node:16.15-bullseye-slim
WORKDIR /src

COPY ./package.json ./package.json
COPY ./pnpm-lock.yaml ./pnpm-lock.yaml
RUN npm install -g pnpm@7 && \
    pnpm install

USER node
ENV NODE_ENV=production
ENTRYPOINT ["pnpm", "prisma:deploy"]
VOLUME ["/src/prisma"]
