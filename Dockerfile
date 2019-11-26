# --------------- STAGE 1: Dependencies ---------------
FROM olliecaine/dev:master as stage-dependencies

# Install Python
RUN apk update && apk add python g++ make && rm -rf /var/cache/apk/*

# Install runtime dependencies
RUN npm config set unsafe-perm true
RUN npm install yarn -g
RUN npm config set unsafe-perm false

# Install app dependencies
COPY package*.json yarn.lock ./
RUN yarn install

# --------------- STAGE 2: Build ---------------
FROM stage-dependencies as stage-build

COPY . ./
RUN npm run lint
# TODO: RUN npm start test
RUN yarn start build
COPY package.json ./dist
COPY .env.dev ./dist/.env

# --------------- STAGE 3: Host ---------------
FROM olliecaine/base:master

WORKDIR /usr/src/app
COPY --from=stage-build /project/dist .

# Needed by `yarn start`
RUN npm i nps -g

# Try directly using Node instead of NPM when starting app in production
CMD ["yarn", "start"]
