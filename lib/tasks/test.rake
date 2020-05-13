namespace :test do
  desc "run all tests"
  task all: :environment do
    system "docker-compose run -e 'RAILS_ENV=test' web bundle exec rspec spec"
  end

  desc "run monitor tests"
  task monitor: :environment do
    system "docker-compose run -e 'RAILS_ENV=test' web guard"
  end

  desc "run models test"
  task model: :environment do
    system "docker-compose run -e 'RAILS_ENV=test' web bundle exec rspec spec/models"
  end

  desc "run requests test"
  task request: :environment do
    system "docker-compose run -e 'RAILS_ENV=test' web bundle exec rspec spec/requests"
  end
end
