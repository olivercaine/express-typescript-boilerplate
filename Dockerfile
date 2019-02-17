FROM node:8.15-alpine

# Create work directory
WORKDIR /usr/src/app

# Install app dependencies
COPY package*.json ./
RUN npm install

# Copy app source to work directory
COPY . /usr/src/app

# Build and run the app
CMD npm start serve
