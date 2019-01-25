FROM node:10.13.0-slim as nodejs

# ******Multi stage ********
FROM ruby:2.5.1-slim-slim as builder

ENV RAILS_ENV=production NODE_ENV=production

# install common dev libs
RUN apt-get update -qq && apt-get install -y \
    build-essential git

# install postgresql
RUN apt-get update -qq && apt-get install -y libpq-dev postgresql-client

# install Nodejs 10.13.0 and Yarn 1.10.1
ENV NODE_VERSION=10.13.0 YARN_VERSION=1.10.1
COPY --from=nodejs /usr/local/bin/ /usr/local/bin/
COPY --from=nodejs /usr/local/lib/ /usr/local/lib/
COPY --from=nodejs /opt/yarn-v1.10.1/ /opt/yarn-v1.10.1/

WORKDIR /app

# gems cache layer
COPY Gemfile Gemfile.lock /app/
RUN bundle install -j 4 --without development test staging --deployment

# node_modules cache layer
COPY package.json yarn.lock /app/
RUN yarn install --pure-lockfile

COPY . .

RUN rails assets:precompile

# remove unnecessary files
RUN rm -r node_modules

# *******************************************
# ************* Multi Stage *****************
# *******************************************
FROM ruby:2.5.1-slim

ENV RAILS_ENV=production NODE_ENV=production


# install postgresql
RUN apt-get update -qq && apt-get install -y postgresql-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# install Nodejs 10.13.0 and Yarn 1.10.1
ENV NODE_VERSION=10.13.0 YARN_VERSION=1.10.1
COPY --from=nodejs /usr/local/bin/ /usr/local/bin/
COPY --from=nodejs /usr/local/lib/ /usr/local/lib/
COPY --from=nodejs /opt/yarn-v1.10.1/ /opt/yarn-v1.10.1/

WORKDIR /app

COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --from=builder /app/ /app/

CMD [ "sh", "-c", "bundle exec rake db:create db:migrate && bundle exec rails server -b 0.0.0.0" ]
