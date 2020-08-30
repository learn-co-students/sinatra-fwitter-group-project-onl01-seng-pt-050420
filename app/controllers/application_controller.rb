require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "alalalala"
  end

  get "/" do
    erb :index
  end

  get "/signup" do
    if logged_in?
      redirect 'tweets'
    else
      erb :signup
    end
  end

  post "/signup" do
    if params.values.any? { |x| x == "" }
      redirect '/signup'
    else
      user = User.create(params)
      session[:user_id] = user.id
      redirect '/tweets'
    end 
  end

  get "/login" do
    if logged_in?
      redirect '/tweets'
    else
      erb :login
    end
  end

  post "/login" do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    end
  end

  get "/logout" do
    session.clear
    redirect '/login'
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :'users/index'
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end
