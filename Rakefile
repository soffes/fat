# Setup bundler
require 'rubygems'
require 'bundler'
Bundler.require

# Setup redis
ENV['REDISTOGO_URL'] = 'redis://localhost:6379' unless ENV['REDISTOGO_URL']
uri = URI.parse(ENV['REDISTOGO_URL'])
$redis = Redis.new(host: uri.host, port: uri.port, password: uri.password)

desc 'Get stats from Fitbit'
task :fetch do
  # Setup the client
  client = Fitgem::Client.new({
    consumer_key: ENV['FITBIT_CONSUMER_KEY'],
    consumer_secret: ENV['FITBIT_CONSUMER_SECRET'],
    token: ENV['FITBIT_ACCESS_TOKEN'],
    secret: ENV['FITBIT_TOKEN_SECRET']
  })
  
  # Today in my timezone
  require 'active_support/time'
  now = Time.now.in_time_zone("Pacific Time (US & Canada)")
  
  # Auth
  access_token = client.reconnect(ENV['FITBIT_ACCESS_TOKEN'], ENV['FITBIT_TOKEN_SECRET'])
  
  # Water
  $redis['water'] = client.water_on_date(now)['summary']['water']
  puts "Water: #{$redis['water']}"
  
  # Weight
  $redis['weight'] = client.body_measurements_on_date(now)['body']['weight']
  puts "Weight: #{$redis['weight']}"
  
  puts 'Done.'
end
