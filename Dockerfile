FROM olliecaine/base:master

# Create work directory
WORKDIR /usr/src/app

# Install Python
RUN apk update && apk add python g++ make && rm -rf /var/cache/apk/*

# Install runtime dependencies
RUN npm config set unsafe-perm true
RUN npm install yarn -g
RUN npm config set unsafe-perm false

# Copy app source to work directory
COPY . /usr/src/app

# Install app dependencies
RUN yarn install

# Build and run the app
CMD npm start serve