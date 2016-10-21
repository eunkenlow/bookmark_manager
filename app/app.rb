ENV["RACK_ENV"] ||= 'development'

require 'sinatra/base'
require_relative 'data_mapper_setup'
require 'sinatra/flash'
require 'sinatra'

class BookmarkManager < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'

  get '/' do
    erb :index
  end

  get '/links' do
    @links = Link.all
    erb :links
  end

  post "/links" do
    link = Link.create(url: "#{params[:url]}", title: "#{params[:title]}")
    params[:tag].split.each do |tag|
      link.tags << Tag.create(tag_name: tag)
    end
    link.save
    redirect "/links"
  end

  get "/links/new" do
    erb :add_link
  end


  get '/tags/:name' do
    tag = Tag.all(tag_name: params[:name])
    @links = tag ? tag.links : []
    erb :links
  end

  get '/users/new' do
    @user = User.new
    erb :'users/new'
  end

  post '/users' do
    @user = User.create(email: params[:email],
                     password: params[:password],
                     password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect to('/links')
    else
      flash.now[:notice] = "Passwords do not match"
      erb :'users/new'
    end
  end

  helpers do
   def current_user
     @current_user ||= User.get(session[:user_id])
   end
  end

  register Sinatra::Flash
  # start the server if ruby file executed directly
  run! if app_file == $0
end
