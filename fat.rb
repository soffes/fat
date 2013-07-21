class Fat < Sinatra::Application
  get '/' do
    @weight = $redis['weight']
    @water = $redis['water']
    @last_updated = $redis['last_updated']
    erb :index
  end
end
