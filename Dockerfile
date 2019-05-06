# TODO: this file needs work.
# - Find out why `unsafe-perm` is used
# - Copy dist from stage 1 to stage 2
# - Try directly using Node instead of NPM when starting app in production

# --------------- STAGE 1: Dependencies ---------------
FROM base:latest as stage-dependencies

# Install Python
RUN apk update && apk add python g++ make && rm -rf /var/cache/apk/*

# Create work directory
WORKDIR /project

# Install runtime dependencies
RUN npm install yarn -g

# Install app dependencies
COPY package*.json yarn.lock ./
RUN yarn install

# Copy app source to work directory
COPY . /project

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

# Installing Python
RUN apk update && apk add python g++ make && rm -rf /var/cache/apk/*

# Install dependencies
COPY package*.json ./
RUN npm config set unsafe-perm true
RUN npm i nps -g
RUN npm install --prefer-offline --production
RUN npm config set unsafe-perm false

COPY . /usr/src/app

CMD npm start serve