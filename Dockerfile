FROM ruby:2.5.1-alpine

RUN gem install dockerize-stack
USER nobody

ENTRYPOINT ["dockerize-stack"]
WORKDIR /usr/src
