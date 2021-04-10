require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    # register Sinatra::Flash
    enable :sessions
    set :session_secret, "secrets"
  end

  get '/' do
    erb :index
  end

  helpers do

    def logged_in?
      !!current_user
    end
  
    def current_user
      @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end
  end

  def authorize(tweet)
    authenticate
    if tweet.user != current_user
      redirect '/tweets'
    end
  end

end
