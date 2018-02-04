FROM ruby:2.4.3

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