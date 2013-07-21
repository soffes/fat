class Fat < Sinatra::Application
  get '/' do
    @weight = JSON($redis['weight']).last['value']
    @water = JSON($redis['water']).last['value']
    @steps = JSON($redis['steps']).last['value']
    @last_updated = $redis['last_updated']
    erb :index
  end
end
