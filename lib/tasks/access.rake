namespace :access do
  desc "initialize and deploy application on local"
  task db: :environment do
    system "docker exec -it postgres psql -d " + ENV['DB_NAME'] + "_development"
  end

  desc "initialize and deploy application on local"
  task console: :environment do
    system "docker exec -it bank-account rails c"
  end
end
