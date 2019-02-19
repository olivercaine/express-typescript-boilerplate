# --------------- STAGE 1 ---------------
FROM node:8.15-alpine

# Create work directory
WORKDIR /project

# Install dependencies
COPY package*.json ./
RUN npm config set unsafe-perm true
RUN npm i nps -g
# Run --production first so it's cache for next STAGE 2
RUN npm install --production
RUN npm install
RUN npm config set unsafe-perm false

# Lint and test the app
COPY . /usr/src/app
RUN npm run lint
RUN npm start test

# --------------- STAGE 2 ---------------
FROM node:8.15-alpine

# Create work directory
WORKDIR /project

# Install dependencies
COPY package*.json ./
RUN npm config set unsafe-perm true
RUN npm i nps -g
RUN npm install --production
RUN npm config set unsafe-perm false

# Lint and test the app
COPY . /usr/src/app

# Run the app
CMD npm start serve