# Dockerize Stack

This it's a generator for generate Dockerfile and docker-compose for your application

## Why?

- Help to configure multiple applications using the same templates.

- Using templates is more easy to dockerize diferent type of projects.

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

See all options:

```
Options:
  t, [--template-folder=TEMPLATE_FOLDER]                       # Template folder path
  o, [--output-folder=OUTPUT_FOLDER]                           # Output folder
                                                               # Default: .
      [--ruby-version=RUBY_VERSION]                            # Ruby Version (default 2.5.6):
      [--nodejs-version=NODEJS_VERSION]                        # Nodejs version (default 10.16.3):
      [--javascrit-package-manager=JAVASCRIT_PACKAGE_MANAGER]  # What is your Javascript package manager?
      [--database=DATABASE]                                    # What is your Database?
      [--rails-worker=RAILS_WORKER]                            # You need workers with sidekiq? y/n, (default y)
      [--github-private=GITHUB_PRIVATE]                        # You need github token for private gems? y/n (default no)
      [--kubernetes=KUBERNETES]                                # You want generate docker-stack for kubernetes? y/n (default no)
```

## TODO

- [ ] Add integrations with all database types rails new supported ([mysql/postgresql/sqlite3/oracle/frontbase/ibm_db/sqlserver/jdbcmysql/jdbcsqlite3/jdbcpostgresql/jdbc])
- [x] Integrate Build with private repositories
