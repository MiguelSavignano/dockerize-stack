FROM ruby:2.5.1-slim

# Install common dev libs
RUN apt-get update -qq && apt-get install -y \
  build-essential vim git


# Install Postgresql
RUN apt-get install -y postgresql-client libpq-dev


# Install Nodejs 10.x
RUN curl -sL https://deb.nodesource.com/setup_10.x | bin/bash -\
  && apt-get install -y nodejs

WORKDIR /app



# Invalidate gems cache if change Gemfile or Gemfile.lock
COPY Gemfile Gemfile.lock /app/
RUN bundle install -j 4

# Invalidate node_modules cache if package.json or package-lock.json
COPY package.json package-lock.json /app/
RUN npm ci

COPY . .
