# --------------- STAGE 1: Develop ---------------
FROM olliecaine/dev:node10alpine as stage-develop

# Install dev dependencies
RUN apk update \
    && apk add python g++ make \
    && rm -rf /var/cache/apk/*

CMD ["npm", "run", "dev"]

# --------------- STAGE 2: Build ---------------
FROM stage-develop as stage-build

# Install dependencies first so that cache layer isn't invalidated by source code change
COPY package*.json ./
RUN npm install

COPY . ./
RUN npm run lint \
    && npm start test \
    && npm start test.integration \
    && npm start test.e2e \
    && npm run build

# --------------- STAGE 3: Host ---------------
FROM olliecaine/base:node10alpine

WORKDIR /usr/src/app

COPY --from=stage-build /project .

USER node
CMD ["npm", "run", "start"]
