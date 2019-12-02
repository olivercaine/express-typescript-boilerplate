# README [extended]

## Getting Started

Yarn install doesn't work! Have to use `npm run setup && npm start serve`.

## Authentication

APIs which have the `@Authorized` on them require requests to contain an `Authorization` header for them to be accepted.

For exmaple, To make a request to [/api/users](http://localhost:3001/api/users) using username "bruce" and password "1234", then "bruce:1234" needs to be sent as a Base64 encoded string in the header, e.g.

`Authorization: Basic YnJ1Y2U6MTIzNA==`

Strings can be manually Base64 encoded at [base64encode.org](https://www.base64encode.org/).

## Troubleshooting

### Missing bcrypt module

Error: `Error: Cannot find module 'bcrypt'`

Solution: run using docker-compose, i.e. `docker-compose server`

