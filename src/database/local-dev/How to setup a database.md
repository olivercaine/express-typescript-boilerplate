# How to set a database

## Hosting locally

Install Brew

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Install Docker app

```bash
brew cask install docker
```

Install a DB client, e.g. PSequel

```bash
brew cask install psequel
```

Set the DB connection string in the app (index.js):

```javascript
postgres://docker:docker@localhost:5432
```

Run the Docker DB:

```bash
./Run\ db.sh
```

Connect using DB client and settings in same file.

**Troubleshooting**

Ruby out of date error

```bash
brew update-reset
```

## Hosting on Heroku

Based on: https://devcenter.heroku.com/articles/heroku-postgres-plans#hobby-tier

1. Download and install [PSequel](http://www.psequel.com/) (a database GUI client) if you haven't already.

2. Open terminal and cd to the directory of the project.

3. Create the database on the app, e.g:

   `heroku addons:create heroku-postgresql:hobby-dev --app bordellio-landing-page`

4. Get the newly created DB's credentials:

   `heroku pg:credentials:url --app bordellio-landing-page`

5. In PSequel, File -> New Window -> Add Connection and paste the output of step 4.

6. Tick "Use SSL" (no need to fill in fields) and click "Connect" in the bottom right to connect to the DB.
