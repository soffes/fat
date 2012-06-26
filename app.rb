ENV['REDISTOGO_URL'] = 'redis://localhost:6379' unless ENV['REDISTOGO_URL']
uri = URI.parse(ENV['REDISTOGO_URL'])
$redis = Redis.new(host: uri.host, port: uri.port, password: uri.password)

set :cache, Dalli::Client.new

get '/' do
  @weight = $redis['weight']
  @water = $redis['water']
  @last_updated = Time.parse($redis['last_updated']).strftime('%D %I:%M%p').downcase
  erb :index
end
