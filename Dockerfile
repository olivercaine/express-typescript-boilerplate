# Stage 1: Prepare to dist
FROM node:8.15-alpine as build-server

# Create work directory
WORKDIR /project

# Install app dependencies
COPY package*.json ./
RUN npm config set unsafe-perm true
RUN npm install
RUN npm i nps -g
RUN npm config set unsafe-perm false

# Copy app source to work directory
COPY . /usr/src/app
RUN npm run lint
RUN npm start test

# Build and run the app
CMD npm start serve
