# Bank account opening - Code Challenge

[![Build Status](https://travis-ci.org/apsferreira/code-challenge-bank-account.svg?branch=master)](https://travis-ci.org/apsferreira/code-challenge-bank-account)

code challenge related to creating an API that supports requests for creating and editing accounts.

The API documentation and testing can be done [here](http://docs.docker.com/compose/compose-file/#build)

## Stack

this project was built using the technologies below:

- Ruby 2.7.1
- Rails 6.0.22
- Newrelic
- Postgresql
- Redis
- Sidekiq
- Docker
- Docker-compose

##  Getting started

After cloning the repository:

```bash
$ git clone git@github.com:apsferreira/code-challenge-bank-account.git
```

```bash
$ cd code-challenge-bank-account
```

 It is necessary to initially rename the env_example file to .env and set the appropriate settings related to your local environment.

Assuming that the docker and docker-compose are installed, execute the command below:

```bash
$ rake up:dev
```

This command will configure and create all the necessary containers to start the project development.

After creating all the containers, the bank can be populated by running the command below:

```bash
$ rake db:seed
```


More commands [here](#-more-commands) 







## More commands
```bash
$ rake access:console #access to rails console 
$ rake access:db #access to psql 
$ rake access:logs #access to logs of all containers
$ rake db:seed 
$ rake db:migrate
$ rake db:reload
$ rake down:dev
$ rake down:stg
$ rake down:prd
$ rake test:all
$ rake test:monitor
$ rake test:model
$ rake test:request
$ rake up:dev
$ rake up:dev_monitor
$ rake up:reload
$ rake up:prd
$ rake up:prd_monito
```
