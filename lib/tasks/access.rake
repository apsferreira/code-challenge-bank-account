namespace :access do
  desc "Access Database application"
  task db: :environment do
    system "docker exec -it postgres psql -d " + ENV['DB_NAME'] + "_development"
  end

  desc "Access rails console application"
  task console: :environment do
    system "docker exec -it bank-account rails c"
  end

  desc "Access logs of application"
  task logs: :environment do
    system "docker-compose logs -f"
  end
end
