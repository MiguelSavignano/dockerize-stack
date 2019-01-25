FROM ruby:2.5.1-alpine
ARG TAG
WORKDIR /usr/src
COPY Gemfile Gemfile.lock /app/
COPY . .
RUN gem build dockerize_stack.gemspec
RUN gem install dockerize-stack-${TAG}.gem

ENTRYPOINT ["dockerize-stack"]
# docker run --user $(id -u) -it -v $(pwd):/usr/src devmasx/dockerize-stack rails
