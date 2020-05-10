# frozen_string_literal: true

require 'sidekiq'
require 'sidekiq/web'

Rails.application.routes.draw do
  # Sidekiq web config
  mount Sidekiq::Web => '/sidekiq'

  Sidekiq::Web.use(Rack::Auth::Basic, { use: :authenticity_token, logger: Rails.logger, message: "Didn't work!", except: [:http_origin] }) do |user, password|
    [user, password] == [ENV['SIDEKIQ_USERNAME'], ENV['SIDEKIQ_PASSWORD']]
  end

  Sidekiq::Web.set :session_secret, Rails.application.secrets[:secret_key_base]

  namespace 'api' do
  	namespace 'v1' do
      resources :accounts
      resources :users
      post '/auth/login', to: 'authentications#login'
      get '/*a', to: 'application#not_found'
    end
  end
end
