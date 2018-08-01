FROM ruby:2.5.1-alpine

RUN gem install dockerize-stack
WORKDIR /usr/src

ENTRYPOINT ["dockerize-stack"]
