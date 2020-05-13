namespace :down do
  desc "stop and remove application on local (developer)"
  task dev: :environment do
    system "docker-compose down"
  end

  desc "stop and remove application on stage"
  task stage: :environment do
    system "docker-compose down"
  end

  desc "stop and remove application on production"
  task prod: :environment do
    system "docker-compose down"
  end
end
