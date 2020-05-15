# frozen_string_literal: true

namespace :up do
  desc 'initialize and deploy application on local without logs'
  task dev: :environment do
    system "docker build -t apsferreira/bank-account:latest --build-arg bundle_options_var='--without staging production' ."
    system 'docker-compose up -d'
  end

  desc 'initialize and deploy application on local with logs'
  task dev_monitor: :environment do
    system "docker build -t apsferreira/bank-account:latest --build-arg bundle_options_var='--without staging production' ."
    system 'docker-compose up'
  end

  task reload: :environment do
    system 'docker-compose down'
    system "docker build -t apsferreira/bank-account:latest --build-arg bundle_options_var='--without staging production' ."
    system 'docker-compose up'
  end

  desc 'initialize and push container application for production'
  task prd: :environment do
    system 'docker build -t apsferreira/bank-account:latest .'
    system 'docker-push apsferreira/bank-account:latest'
  end
end
