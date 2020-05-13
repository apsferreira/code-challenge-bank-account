namespace :up do
  desc "initialize and deploy application on local"
  task dev: :environment do
    system "docker build -t apsferreira/bank-account:latest --build-arg bundle_options_var='--without staging production' ."
    system "docker-compose up -d"
  end

  desc "initialize and deploy application on local"
  task dev_monitor: :environment do
    system "docker build -t apsferreira/bank-account:latest --build-arg bundle_options_var='--without staging production' ."
    system "docker-compose up"
  end

  desc "initialize and deploy application on stage"
  task stage: :environment do
    # TODO
  end

  desc "initialize and deploy application on production"
  task prod: :environment do
    system "docker build -t $containerRepositoryName:latest ."
    system "docker-compose up -d"
  end
  
  desc "initialize and deploy application on production"
  task prod_monitor: :environment do
    system "docker build -t $containerRepositoryName:latest ."
    system "docker-compose up"
  end
end
