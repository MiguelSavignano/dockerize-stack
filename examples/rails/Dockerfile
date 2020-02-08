# ****************************
# ******Build base stage******
# ****************************

FROM node:-slim as nodejs

FROM ruby:-slim as builder

# Install common libs
RUN apt-get update -qq && apt-get install -y \
  build-essential vim git

# Install Nodejs
ENV NODE_VERSION=
COPY --from=nodejs /usr/local/bin/ /usr/local/bin/
COPY --from=nodejs /usr/local/lib/ /usr/local/lib/

WORKDIR /app

# Production config
ARG BUNDLE_DEPLOYMENT=true
ARG BUNDLE_WITHOUT="development test staging"
ARG NODE_ENV=production

ENV BUNDLE_DEPLOYMENT=$BUNDLE_DEPLOYMENT BUNDLE_WITHOUT=$BUNDLE_WITHOUT
ENV NODE_ENV=$NODE_ENV

# Gems cache layer
COPY Gemfile Gemfile.lock /app/
RUN bundle install -j 4

# Node modules cache layer
COPY package.json package-lock.json /app/
RUN npm ci

COPY . .
CMD "./entrypoint.sh"

# ****************************
# ******Production stage******
# ****************************

FROM builder as production-builder

# Build production assets
RUN bundle exec rails assets:precompile

RUN rm -r node_modules

# **********************************
# ******Final production Stage******
# **********************************

FROM ruby:-slim

ENV NODE_ENV=production RAILS_ENV=production RAILS_LOG_TO_STDOUT=true

# Install system dependencies

COPY --from=nodejs /usr/local/ /usr/local/

RUN apt-get update -qq && apt-get install -y \
  libpq-dev \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN groupadd -r deploy && useradd -r -g deploy deploy
USER deploy

COPY --from=production-builder --chown=deploy:deploy /usr/local/bundle /usr/local/bundle
COPY --from=production-builder --chown=deploy:deploy /app /app

CMD [ "sh", "-c", "bundle exec rake db:create db:migrate && bundle exec rails server -b 0.0.0.0" ]
