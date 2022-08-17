# --------------- STAGE 1: Develop ---------------
FROM olliecaine/dev:node10alpinesecure as stage-develop

CMD ["npm", "run", "dev"]

# --------------- STAGE 2: Build ---------------
FROM stage-develop as stage-build

# Install dependencies first so that cache layer isn't invalidated by source code change
COPY package.json package-lock.json ./
RUN npm ci

COPY . ./
RUN npm run health-check    

# --------------- STAGE 3: Host ---------------
FROM olliecaine/base:node10alpine

WORKDIR /usr/src/app

COPY --from=stage-build /project .

USER node
CMD ["npm", "run", "start"]
