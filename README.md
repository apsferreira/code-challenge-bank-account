# Bank account opening - Code Challenge

[![Build Status](https://travis-ci.org/apsferreira/code-challenge-bank-account.svg?branch=master)](https://travis-ci.org/apsferreira/code-challenge-bank-account)

Code challenge related to creating an API that supports requests for creating and editing accounts.

The API documentation can be found [here](https://app.swaggerhub.com/apis-docs/WebSTIC/bank-account-opening/1.0.0#/)

An example of how the API works can be recorded [here](http://api.antoniopedro.com.br/api/v1/alive)

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
- [Travis](https://travis-ci.org/)

## Getting started

After cloning the repository:

```bash
$ git clone git@github.com:apsferreira/code-challenge-bank-account.git
```

```bash
$ cd code-challenge-bank-account
```

## Build and deploy

It is necessary to initially rename the env_example file to .env and set the appropriate settings related to your local environment.

### With Docker and Docker Compose

Assuming that the docker and docker-compose are installed, execute the command below:

```bash
$ rake up:dev
```

This command will configure and create all the necessary containers to start the project development.

After creating all the containers, the bank can be populated by running the command below:

```bash
$ rake db:seed
```

More commands [here](##-more-commands) 

### With local rails configuration

For this case we will assume that the local environment is configured and reflected in the .env file. configured in the previous section, along with potgres and other settings.

```bash
rails db:create db:migrate 
````

then, to start the application run the command below

```bash
rails s -b 0.0.0.0
```


After installations, the API can be checked at:

```bash
 http://localhost:3000/api/v1/alive
```

Or  execute the comannd on your console:

```bash
$ curl http://localhost:3000/api/v1/alive
```

## Features

All the features requested in the challenge were implemented, as an improvement, it would add a greater amount of integration tests.

For the sake of time, I opted for a reasonable approach in the model of the account entity, assuming that encryption should only be performed when saving the record, I could use [Active Record Callbacks](https://guides.rubyonrails.org/active_record_callbacks.html) (before_validate and before_save), but after several unsuccessful attempts, I opted for a simpler approach, and with that, I was not able to strictly follow the concept fat models and skinny Conrtoller.

For monitoring purposes, or newrelic has been integrated into applications, or sidekiq has also been integrated into applications for routine work processes and queues that require more time, leaving in the background, it was considered to be sent for a confirmation or completion email account status (completed status), remained as an idea for future implementations. As another security measure, the rack-atack gem was used, where some solutions were configured, such as: not responding to the same ip after 5 simultaneous requests to the msm endpoint already thinking about a CI/CD stream, the travis was also configured in the application.

## Tests

To start unit tests, execute the command below on the terminal:

```bash
$ rake test:all
```

To start watch unit tests,  execute the command below on the terminal:

```bash
$ rake test:monitor
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
$ rake up:prd   	#build and push the last version of container application for prod 
```

## License

Copyright [Antonio Pedro Ferreira](https://github.com/apsferreira).

Released under an [MIT License](https://opensource.org/licenses/MIT).