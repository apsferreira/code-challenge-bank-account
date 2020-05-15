# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
# require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CodeChallengeBankAccount
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    # Set timezone
    config.time_zone = 'America/Sao_Paulo'
    config.active_record.default_timezone = :local

    # Send logs to STDOUT
    config.log_level = ENV['LOG_LEVEL']
    logger = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.log_tags = %i[subdomain uuid]
    config.logger = ActiveSupport::TaggedLogging.new(logger)

    # Use redis for cache store
    config.cache_store = :redis_cache_store, { url: "#{ENV['REDIS_URL']}/#{ENV['REDIS_CACHE_PATH']}" }

    # Use for processing background jobs
    config.active_job.queue_adapter = :sidekiq
    config.active_job.queue_name_prefix = "#{ENV['ACTIVE_JOB_QUEUE_PREFIX']}_#{Rails.env}"

    config.middleware.use Rack::Attack
  end
end
