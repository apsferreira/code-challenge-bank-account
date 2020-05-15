# frozen_string_literal: true

namespace :down do
  desc 'stop and remove application on local (developer)'
  task dev: :environment do
    system 'docker-compose down'
  end
end
