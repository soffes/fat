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
  access_token = client.reconnect(ENV['FITBIT_ACCESS_TOKEN'], ENV['FITBIT_TOKEN_SECRET'])

  end_day = Date.today
  start_day = end_day - 14

  # Water
  $redis['water'] = JSON.dump(client.data_by_time_range('/foods/log/water', base_date: start_day.to_s, end_date: end_day.to_s)['foods-log-water'])

  # Weight
  $redis['weight'] = JSON.dump(client.data_by_time_range('/body/weight', base_date: start_day.to_s, end_date: end_day.to_s)['body-weight'])

  # Steps
  $redis['steps'] = JSON.dump(client.data_by_time_range('/activities/log/steps', base_date: start_day.to_s, end_date: end_day.to_s)['activities-log-steps'])

  # Last updated
  now = Time.now.utc
  now -= 4 * 60 * 60
  $redis['last_updated'] = now.strftime('%D %I:%M%p').downcase

  puts "Done. Last updated at #{$redis['last_updated']}"
end
