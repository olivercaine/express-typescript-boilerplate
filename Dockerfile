# --------------- STAGE 1: Develop ---------------
FROM olliecaine/dev:master as stage-develop

# Install dev dependencies
RUN apk update && apk add python g++ make && rm -rf /var/cache/apk/*
RUN npm config set unsafe-perm true
RUN npm install yarn -g
RUN npm config set unsafe-perm false

CMD ["npm", "run", "dev"]

# --------------- STAGE 2: Build ---------------
FROM stage-develop as stage-build

# Install dependencies separately so image step cache isn't invalidated by source code change
COPY package*.json yarn.lock ./
RUN yarn install

COPY . ./
RUN npm run lint
RUN yarn start test
RUN yarn start test.integration
RUN yarn start test.e2e
RUN npm run build

# --------------- STAGE 3: Host ---------------
FROM olliecaine/base:master

WORKDIR /usr/src/app

COPY --from=stage-build /project .

USER node
CMD ["npm", "run", "start"]
