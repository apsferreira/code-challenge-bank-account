#!/bin/bash

args="'$*'"

containerRepositoryName='apsferreira/bank-account'

if [[ "$args" =~ "--prod" ]]; then
  docker build -t $containerRepositoryName:latest .
else
  docker build -t $containerRepositoryName:latest --build-arg bundle_options_var='--without staging production' .
fi

docker-compose up