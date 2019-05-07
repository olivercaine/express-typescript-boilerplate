# TODO: this file needs work.
# - Copy dist from stage 1 to stage 2
# - Try directly using Node instead of NPM when starting app in production

# --------------- STAGE 1: Dependencies ---------------
FROM base:latest as stage-dependencies

# Install Python
RUN apk update && apk add python g++ make && rm -rf /var/cache/apk/*

# Create work directory
WORKDIR /usr/src/app

# Install runtime dependencies
RUN npm install yarn -g

# Install app dependencies
COPY package*.json yarn.lock ./
RUN yarn install

# Copy app source to work directory
COPY . /usr/src/app

# --------------- STAGE 2: Build ---------------
FROM stage-dependencies as stage-build

# Needed to run tests?
# RUN npm i nps -g

COPY . /usr/src/app
RUN npm run lint
# RUN npm start test # TODO
RUN npm start build

# --------------- STAGE 3: Host ---------------
FROM node:8-alpine

# Install Python
RUN apk update && apk add python g++ make && rm -rf /var/cache/apk/*

# Create work directory
WORKDIR /usr/src/app

# Install runtime dependencies
RUN npm install yarn -g

# Install app dependencies
COPY package*.json yarn.lock ./
RUN yarn install

# Copy app source to work directory
COPY . /usr/src/app

# Build and run the app
CMD npm start serve
