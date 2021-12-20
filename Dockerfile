FROM node:16.13-bullseye-slim
WORKDIR /src

COPY ./package.json ./package.json
COPY ./package-lock.json ./package-lock.json
RUN npm install

USER node
ENV NODE_ENV=production
ENTRYPOINT ["npm", "run", "prisma:deploy"]
VOLUME ["/src/prisma"]