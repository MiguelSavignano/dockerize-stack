# Dockerize Stack

This it's a generator for generate Dockerfile and docker-compose for your application for development and production

## Why?

- Help to configure multiple applications using the same templates.

- For build a quick stack for your development enviroment docker is the best tool you can use, but you need to configure the Dockerfile docker-compose, persisted database data, set the entrypoint...

- For deploy to kubernetes you need first Dockerfile for your application, this templates help to build optimize docker image for productions enviroments.

- Using templates is more easy customize docker build process (Dockerfile, docker-compose).

## Install

```
gem install dockerize-stack
```

or

```
docker pull devmasx/dockerize-stack
```

## Usage

```sh
dockerize-stack rails
```

or use docker image

```
docker run --user $(id -u) -it -v $(pwd):/usr/src devmasx/dockerize-stack rails
```

## Rails Templates

[rails example](./examples/rails)

By default the Dockerfile config is for production enviroment; using docker multistage feature and ARG (Build arguments) at the build time this Dockerfile is the same for development and production.

See all options:

```
dockerize-stack help rails
```

Build a docker image for development enviroment:

```
docker build -t rails-example \
 --build-arg=BUNDLE_DEPLOYMENT="false" \
 --build-arg=BUNDLE_WITHOUT="" \
 --build-arg=NODE_ENV="" \
 .
```

## TODO

- [ ] Add integrations with all database types rails new supported ([mysql/postgresql/sqlite3/oracle/frontbase/ibm_db/sqlserver/jdbcmysql/jdbcsqlite3/jdbcpostgresql/jdbc])
- [x] Integrate Build with private repositories
