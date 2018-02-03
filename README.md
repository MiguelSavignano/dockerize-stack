# Dockerize Rails for development

This it's a generator for generate docker files for rails in developer mode

## Install
```
gem install dockerize-stack
```
## Usage
```sh
dockerize_stack rails
```

This script ask you:
- Mainteiner name
- Ruby version
- Database type

example files generate:
```
/docker
--development
----Dockerfile
----entrypoint.sh
/.dockerignore
/docker-compose.yml
/config/database_docker.yml
```

### Dockerfile
```
FROM ruby:2.4.3
LABEL mainteiner=example@mail.com

# install commond dev libs
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  git-all

# install editors
RUN apt-get install -y \
  nano \
  vim

# http libs for download
RUN apt-get install -y \
  curl \
  ca-certificates \
  openssl \
  apt-transport-https \
  gnupg2

# install postgresql
RUN apt-get install -y postgresql-client

# install node 8.9.1 LTS
RUN curl -sL https://deb.nodesource.com/setup_8.x | bin/bash -
RUN apt-get update && apt-get install -y nodejs

# install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn

RUN mkdir /app
WORKDIR /app
ADD . /app
```

### docker-compose.yml
``` yml
version: '3'
services:
  web:
    build: ./docker/development
    container_name: web
    stdin_open: true
    tty: true
    command: "bash ./docker/development/entrypoint.sh"
    volumes:
      - .:/app
      - ./volumes/bundle:/usr/local/bundle
    ports:
      - "3000:3000"
    depends_on:
      - db
    # env_file:
    #   - web.env
  db:
    image: postgres:9.5.9
    # ports:
    #   - "5432:5432"
    volumes:
      - ./volumes/postgresql:/var/lib/postgresql/data
  redis:
    image: redis
    # ports:
    #   - "6379:6379"
  mailcatcher:
    image: schickling/mailcatcher
    ports:
      - 1025:1025
      - 1080:1080
```

### entrypoint.sh
Entrypoint it's the command execute when your web container start.

```sh
bundle install
yarn install
rake rake db:create db:migrate
rm -f tmp/pids/server.pid
bundle exec rails server -p 3000 -b 0.0.0.0
```

## TODO
- [ ] Solve use rails generator in container
- [ ] Add integrations with all database types rails new supported ([mysql/postgresql/sqlite3/oracle/frontbase/ibm_db/sqlserver/jdbcmysql/jdbcsqlite3/jdbcpostgresql/jdbc])
- [ ] Integrate Build with private repository in the generator
