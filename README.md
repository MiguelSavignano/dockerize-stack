# Dockerize Stack for development

This it's a generator for generate Dockerfile and docker-compose for your application for development

## Why?
For build a quick stack for your development enviroment docker is the best tool you can use, but you need to configure the Dockerfile docker-compose, persisted database data, set the entrypoint...

This generator help you to have a basic template for your stack; focusing on develepment enviroment.

## Install
```
gem install dockerize-stack
```
or
```
docker pull devmasx/dockerize-stack
```

## Stacks available

- [x] Rails 5.1 or 5.2 (Ruby)
- [ ] Symfony (PHP)
- [ ] Phoenixframework (Elixir)
- [ ] Django (Python)
- [ ] Express (Node)

## Usage
```sh
dockerize-stack rails
```
or use docker image
```
docker run --user $(id -u) -it -v $(pwd):/usr/src devmasx/dockerize-stack rails
```

This script ask you:
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
/config/database-docker.yml
```

## TODO
- [ ] Add integrations with all database types rails new supported ([mysql/postgresql/sqlite3/oracle/frontbase/ibm_db/sqlserver/jdbcmysql/jdbcsqlite3/jdbcpostgresql/jdbc])
- [x] Integrate Build with private repositorys
