# README [extended]

## Creating users

There are two things preventing new users from being created via the API out of the box;

1. The. POST method in `src/api/controllers/UserController.ts` has an `@Authorized` attribute on it, meaning only authenticated users can create more users.
2. The `password` field in `src/api/models/User.ts` has an `@Exclude ` attribute on it which prevents the password field in the request body from reaching the backend application. This is a problem because a user cannot be created without a password (it fails when bcrypting the password), however the attribute can't be removed because then passwords will be returned in the response. A workaround needs to be designed.

## Authentication

APIs which have the `@Authorized` on them require requests to contain an `Authorization` header for them to be accepted.

For exmaple, To make a request to [/api/users](http://localhost:3001/api/users) using username "bruce" and password "1234", then "bruce:1234" needs to be sent as a Base64 encoded string in the header, e.g.

`Authorization: Basic YnJ1Y2U6MTIzNA==`

Strings can be manually Base64 encoded at [base64encode.org](https://www.base64encode.org/).

## Troubleshooting

### Missing bcrypt module

Error: `Error: Cannot find module 'bcrypt'`

Solution: Run the server using docker-compose, e.g. `docker-compose server`

