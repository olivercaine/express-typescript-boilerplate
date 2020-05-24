# README [extended]

## Running the app

1. Copy `.env.dev` to `.env`
2. Run `docker-compose up server` (requires docker) or `npm run dev`

## Creating users

There are two things preventing new users from being created via the API out of the box;

1. The. POST method in `src/api/controllers/UserController.ts` has an `@Authorized` attribute on it, meaning only authenticated users can create more users.
2. The `password` field in `src/api/models/User.ts` has an `@Exclude ` attribute on it which prevents the password field in the request body from reaching the backend application. This is a problem because a user cannot be created without a password (it fails when bcrypting the password), however the attribute can't be removed because then passwords will be returned in the response. A workaround needs to be designed.

## Creating an entity

1. Create the migration to create the table
   1. Add to /src/database/migrations/
   2. The class name needs to be in the format `<description><timestamp>`. Name the filename using the format `<timestamp>-<description>.ts` so that it appears in the order of execution (earliest at top).
   3. Verify by running the server and checking that the new table is appearing in the database

2. Create the domain model

   1. /src/api/models/

3. Seed the table using the model

   1. Create @Entity class /at src/api/models/

   2. Create seed class at /src/database/seeds/, e.g.

      ```typescript
      public async seed(factory: Factory, connection: Connection): Promise<Animal> {
        const em = connection.createEntityManager();

      	const animal = new Animal();
      	animal.id = uuid.v1();
      	animal.name = 'Rex';
      	return await em.save(animal);
      }
      ```

   3. Verify it's working by opening the table in the db and ensuring the data is in there

## Authentication

APIs which have the `@Authorized` on them require requests to contain an `Authorization` header for them to be accepted.

For example, To make a request to [/api/users](http://localhost:3001/api/users) using username "bruce" and password "1234", then "bruce:1234" needs to be sent as a Base64 encoded string in the header, e.g.

`Authorization: Basic YnJ1Y2U6MTIzNA==`

Strings can be manually Base64 encoded at [base64encode.org](https://www.base64encode.org/).

## Troubleshooting

### Data and salt arguments required

Error: `data and salt arguments required` in API response

Cause: `@Exclude()` parameter is stripping password when User is posted to API

Solution: Generate a password for the user and then send them down the set password flow (similar to the forgotten password one), i.e. send a temporary token to their email address.

### Missing bcrypt module

Error: `Error: Cannot find module 'bcrypt'`

Solution: Run the server using docker-compose, e.g. `docker-compose server`
