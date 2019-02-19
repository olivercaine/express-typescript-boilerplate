FROM node:8.15-alpine

# Create work directory
WORKDIR /project

# Install dependencies
COPY package*.json ./
RUN npm config set unsafe-perm true
RUN npm install
RUN npm i nps -g
RUN npm config set unsafe-perm false

# Lint and test the app
COPY . /usr/src/app
RUN npm run lint
RUN npm start test

# Run the app
CMD npm start serve
