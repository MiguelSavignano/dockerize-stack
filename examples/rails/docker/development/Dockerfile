FROM node:8.11.3-slim as node

# ******Multi stage ********
FROM ruby:2.5.1-slim

# Install common dev libs
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  vim \
  git

# Install Postgresql
RUN apt-get install -y postgresql-client

# install Nodejs 8.11.3 and Yarn 1.6.0
ENV NODE_VERSION 8.11.3
ENV YARN_VERSION 1.6.0
COPY --from=node /usr/local/bin/ /usr/local/bin/
COPY --from=node /usr/local/lib/ /usr/local/lib/
COPY --from=node /opt/yarn-v1.6.0/ /opt/yarn-v1.6.0/

WORKDIR /app

# Invalidate gems cache if change Gemfile or Gemfile.lock
COPY Gemfile Gemfile.lock /app/
RUN bundle install -j 4

# Invalidate node_modules cache if yarn.lock change
COPY package.json yarn.lock /app/
RUN yarn install --pure-lockfile

COPY . /app
