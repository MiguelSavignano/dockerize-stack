#!/bin/bash
set -ex

# migrate database before run server
bundle exec rake db:create db:migrate
# run rails
bundle exec rails server -p 3000 -b 0.0.0.0
