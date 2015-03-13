class Fat < Sinatra::Application
  get '/' do
    @last_weight = $redis['last_weight'].to_f
    @weight = $redis['weight']
    # @water = JSON($redis['water']).last['value']
    # @steps = JSON($redis['steps']).last['value']
    @last_updated = $redis['last_updated']
    erb :index
  end
end
