# TODO: this file needs work. 
# - Find out why `unsafe-perm` is used
# - Copy dist from stage 1 to stage 2
# - Try directly using Node instead of NPM when starting app in production

# --------------- STAGE 1: Dependencies ---------------
FROM base:latest as stage-dependencies

COPY package*.json ./
RUN npm config set unsafe-perm true
RUN npm i nps -g
# Run --production first so it's cache for next STAGE 2 (TODO: sort this)
# RUN npm install --prefer-offline --production
RUN npm install --prefer-offline
RUN npm config set unsafe-perm false

# --------------- STAGE 2: Build ---------------
FROM stage-dependencies as stage-build

COPY . /usr/src/app
RUN npm run lint
RUN npm start test
RUN npm start build

# --------------- STAGE 3: Host ---------------
FROM node:8.15-alpine

# Create work directory
WORKDIR /project

# Install dependencies
COPY package*.json ./
RUN npm config set unsafe-perm true
RUN npm i nps -g
RUN npm install --prefer-offline --production
RUN npm config set unsafe-perm false

COPY . /usr/src/app

CMD npm start serve