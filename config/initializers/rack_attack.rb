# frozen_string_literal: true

class Rack::Attack
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  Rack::Attack.safelist('allow from localhost') do |req|
    req.ip == '127.0.0.1' || req.ip == '::1'
  end

  Rack::Attack.throttle('req/ip', limit: 5, period: 1.second, &:ip)

  Rack::Attack.throttled_response = lambda do |_env|
    # Using 503 because it may make attacker think that they have successfully
    # DOSed the site. Rack::Attack returns 429 for throttling by default
    [503, {}, ['Server Errorn']]
  end
  end
