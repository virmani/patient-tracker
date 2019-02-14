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

Switch to the postgres user and create a role:

```
sudo -u postgres createuser -P <username>
```
After which grant the user permission to createdb

```
sudo -u postgres psql -c "ALTER USER <username> WITH CREATEDB"
```

Create a file called local_env.yml in config directory and export PG_PASSWORD, USER and PASSWORD ENV variables from it by

```
PG_PASSWORD:<your_postgres_password>
USER:<username for basic http auth>
PASSWORD:<password for basic http auth>
```

Create a database:
```
createdb -O <username> <dbname>
```
