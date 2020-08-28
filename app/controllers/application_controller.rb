require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_secret"
  end

  get '/' do
    erb :home
  end

  
  # post "/signup" do
	# 	user = User.new(:username => params[:username], :password => params[:password])
	# 	if user.save
	# 		redirect "/login"
	# 	else
	# 		redirect "/home"
	# 	end
	# end


  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

  end

end
