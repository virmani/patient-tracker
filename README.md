# README

### How to install on your computer
Install ruby by following instructions on https://www.ruby-lang.org/en/documentation/installation/
Install postgresql by following instructions on http://postgresguide.com/setup/install.html
Also Install the package postgresql-server-dev-all

```
git clone https://github.com/virmani/patient-tracker.git
cd patient-tracker
bundle install
```

Install Yarn to setup the js packages https://yarnpkg.com/en/docs/install

```
yarn install
```

Create the postgres user and database

```
psql postgres
CREATE USER <database_name> WITH CREATEDB PASSWORD '<your_postgres_password>';
CREATE DATABASE <database_user> OWNER patients_dev;
```

Create a file called local_env.yml in config directory and export PG_PASSWORD, USER and PASSWORD ENV variables from it by

```
PG_DATABASE: <database_name>
PG_USER: <database_user>
PG_PASSWORD: <your_postgres_password>
USER: <username for basic http auth>
PASSWORD: <password for basic http auth>
```

Running database migrations
```
bundle exec rails db:migrate
```

Starting the server
```
bundle exec rails s
```

TODO: Setting up Google drive integration
