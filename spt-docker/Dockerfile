ARG NODE_IMAGE_NAME
FROM ${NODE_IMAGE_NAME}

USER node
WORKDIR /home/node/app

COPY ./app/package.json ./app/tsconfig.json ./app/base_tsconfig.json ./app/.parcelrc ./

RUN yarn
