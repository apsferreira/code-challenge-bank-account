#!/bin/bash

args="'$*'"

docker-compose run -e "RAILS_ENV=test" web bundle exec rspec spec