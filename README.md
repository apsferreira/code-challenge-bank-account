# Bank account opening - Code Challenge

[![Build Status](https://travis-ci.org/apsferreira/code-challenge-bank-account.svg?branch=master)](https://travis-ci.org/apsferreira/code-challenge-bank-account)

code challenge related to creating an API that supports requests for creating and editing accounts.

The API documentation and testing can be done [here](http://api.antoniopedro.com.br/api/v1/)

## Stack

This project was built using the technologies and some gems below:

- [Ruby 2.7.1](https://www.ruby-lang.org/en/news/2020/03/31/ruby-2-7-1-released/)
- [Rails 6.0.2.2](https://edgeguides.rubyonrails.org/6_0_release_notes.html)
- [AMS](https://github.com/rails-api/active_model_serializers)
- [Postgresql](https://www.postgresql.org/docs/9.6/index.html)
- [Redis](https://redis.io/)
- [Sidekiq](https://sidekiq.org/)
- [Docker](https://www.docker.com/)
- [Docker-compose](https://docs.docker.com/compose/)
- [Newrelic](https://newrelic.com/)
- [JWT](https://jwt.io/)
- [rack-attack](https://github.com/kickstarter/rack-attack)

## Getting started

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

The application can be checked at:

```bash
 http://localhost:3000/api/v1/alive
```

Or  execute the comannd:

```bash
$ curl http://localhost:3000/api/v1/alive
```

## More commands

```bash
$ rake access:console   #access to rails console 
$ rake access:db        #access to psql 
$ rake access:logs      #access to logs of all containers
$ rake db:seed          #populate database
$ rake db:migrate       #run all migrations
$ rake db:reload        #run rails db:drop db:create db:migrate on database
$ rake down:dev     	#stop and remove all containers 
$ rake test:all     	#run all unit tests 
$ rake test:monitor     #run guard gem for watch all unit tests 
$ rake test:model   	#run unit tests of models
$ rake test:request     #run unit tests of requests 
$ rake up:dev 		#init and start all containers of dev
$ rake up:dev_monitor   #init and start all containers of dev with logs
$ rake up:reload    	#stop and start all containers
$ rake up:prd   	#init and start all containers of prd 
$ rake up:prd_monitor   #init and start all containers of prd with logs
```
