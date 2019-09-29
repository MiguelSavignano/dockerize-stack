# Rails stack for development

## Dockerfile

[docker-compose.yml](examples/rails/docker-compose.yml)
[Dockerfile](examples/rails/Dockerfile)

## Common problems

This problems base on Dockerfile and docker-compose.yml files that are suggested in the docker docs [examples](https://docs.docker.com/compose/rails/#define-the-project)

### Add new gem

if the command bundle install is in the Dokerfile you need to rebuild de image when add a new gem, this it's slow because the container download all gems everytime the image is build

Solution: It's better save gems in a volume

### Debugger

The problem if the docker-compose.yml initialize the rails server with CMD, you can't
use bybug or pry debugger.

Solution:
docker-compose don't have a interactive terminal and you need to attach the container with

```sh
docker attach web
```

warning | in attach mode if you exit with Ctrl+c the container will be stop and you need to use docker-compose up again
To detach the tty without exiting the shell,
use the escape sequence Ctrl-p + Ctrl-q

### Persist Database data

You need to run migrations every time you start the container

Solution: use local volumens to save database data

### Rails generators

When Using docker-compose run web rails g model ...
The files create in the container the owner it's root user;
if you use this files outside the container you can't modify them

Solution:

```
docker-compose run --user $(id -u) web bash
```

### Pids

The rails server not remove the pid when you close docker-compose wrong with CRT+C;
the next time you start the server wil trow a error

Solution: delete tmp/pids/server.pid every time the container start

### Build with private repository

Some times in you Gemfile you use private repository using git

You need to add github user and token for download private gems from github repository.
Important: gems can only be downloaded over https not ssh
example:

```Dockerfile
...
ARG GITHUB_TOKEN
ARG GITHUB_USERNAME
RUN bundle config github.com ${GITHUB_USERNAME}:${GITHUB_TOKEN}
....
```
