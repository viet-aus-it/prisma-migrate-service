FROM node:16.13-bullseye-slim
WORKDIR /src

COPY ./package.json ./package.json
COPY ./pnpm-lock.yaml ./pnpm-lock.yaml
RUN npm install -g pnpm@6 && \
    pnpm install

USER node
ENV NODE_ENV=production
ENTRYPOINT ["npm", "run", "prisma:deploy"]
VOLUME ["/src/prisma"]