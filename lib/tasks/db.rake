# frozen_string_literal: true

namespace :db do
  desc 'drop database application'

  desc 'initialize db with examples'
  task seed: :environment do
    system "docker-compose run -e 'RAILS_ENV=" + ENV['RAILS_ENV'] + "' web rails db:seed"
  end

  desc 'execute migrations of application'
  task migrate: :environment do
    system 'docker-compose run web rails db:migrate RAILS_ENV=' + ENV['RAILS_ENV'] + ' --trace'
  end

  desc 'execute reload of database on application'
  task reload: :environment do
    system "docker-compose run -e 'RAILS_ENV=" + ENV['RAILS_ENV'] + "' web rails db:drop db:create db:migrate db:seed --trace"
  end
end
