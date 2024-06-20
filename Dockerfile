# --------------- STAGE 1: Develop ---------------
FROM olliecaine/dev:node14alpineserver as stage-develop

CMD ["npm", "run", "dev"]

# --------------- STAGE 2: Build ---------------
FROM stage-develop as stage-build

# Install dependencies first so cache layer isn't invalidated by source code changes.
# TODO: Switch to sharing volume with running container.
COPY package*.json ./
RUN npm ci

COPY . ./
RUN npm run health-check

# --------------- STAGE 3: Host ---------------
FROM olliecaine/base:node10alpine

WORKDIR /usr/src/app

COPY --from=stage-build /project .

USER node
CMD ["npm", "run", "start"]
