# Stage 1: Prepare to dist
FROM node:8.15-alpine as build-server

# Create work directory
WORKDIR /project

# ?
RUN npm config set unsafe-perm true

# Install app dependencies
COPY package*.json ./
RUN npm install
RUN npm i nps -g

# Copy app source to work directory
COPY . /usr/src/app
RUN npm run lint
RUN npm start test

RUN npm config set unsafe-perm false

# Stage 2: Create the production image
FROM node:8.15-alpine

# Create work directory
WORKDIR /project

# Copy app source to work directory
COPY --from=build-server /project .

# Build and run the app
CMD npm start serve
