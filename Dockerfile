# --------------- STAGE 1: Develop ---------------
FROM olliecaine/dev:master as stage-develop

# Install dev dependencies
RUN apk update \
    && apk add python g++ make \
    && rm -rf /var/cache/apk/* \
    && npm config set unsafe-perm true \
    && npm install yarn -g \
    && npm config set unsafe-perm false

CMD ["npm", "run", "dev"]

# --------------- STAGE 2: Build ---------------
FROM stage-develop as stage-build

# Install dependencies first so cache layer isn't nvalidated by source code change
COPY package*.json yarn.lock ./
RUN yarn install
COPY . ./
RUN npm run lint \
    && yarn start test \
    && yarn start test.integration \
    && yarn start test.e2e \
    && npm run build

# --------------- STAGE 3: Host ---------------
FROM olliecaine/base:master

WORKDIR /usr/src/app

COPY --from=stage-build /project .

USER node
CMD ["npm", "run", "start"]
