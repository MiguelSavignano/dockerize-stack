FROM ruby:2.5.1-alpine

RUN gem install dockerize-stack

ENTRYPOINT ["dockerize-stack"]
WORKDIR /usr/src
