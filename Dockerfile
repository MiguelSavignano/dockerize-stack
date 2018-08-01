FROM ruby:2.5.1-alpine

RUN gem install dockerize-stack

RUN mkdir /app
WORKDIR /app

# ENTRYPOINT ["dockerize-stack"]
