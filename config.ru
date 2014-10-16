require 'rubygems'
require 'bundler'
Bundler.require

use Rack::CanonicalHost, ENV['CANONICAL_HOST'] if ENV['CANONICAL_HOST']

# Redis
ENV['REDIS_URL'] = 'redis://localhost:6379' unless ENV['REDIS_URL']
uri = URI.parse(ENV['REDIS_URL'])
$redis = Redis.new(host: uri.host, port: uri.port, password: uri.password)

# Assets
map '/assets' do
  sprockets = Sprockets::Environment.new
  sprockets.append_path 'assets/javascripts'
  sprockets.append_path 'assets/stylesheets'
  run sprockets
end

# App
require './fat'
run Fat
