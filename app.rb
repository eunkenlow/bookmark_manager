require 'sinatra/base'

class Bookmark < Sinatra::Base
  get '/' do
    'Hello Bookmark!'
  end

  get '/links' do

  end
  
  # start the server if ruby file executed directly
  run! if app_file == $0
end
