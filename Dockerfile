FROM node:8.15-alpine

# Create work directory
WORKDIR /usr/src/app

# Install app dependencies
COPY package*.json ./
RUN npm install
RUN npm i nps -g

# Copy app source to work directory
COPY . /usr/src/app
RUN npm run lint
RUN npm start test

# Build and run the app
CMD npm start serve
