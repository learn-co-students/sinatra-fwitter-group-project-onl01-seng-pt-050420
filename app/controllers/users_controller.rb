class UsersController < ApplicationController

    get '/signup' do
       if logged_in?
        redirect '/tweets'
       else
        erb :'users/signup'
       end
      
    end

    post '/signup' do
        if params[:email].empty? || params[:username].empty? || params[:password].empty?
            
            redirect '/signup'
        else
        @user = User.create(email: params[:email], password: params[:password], username: params[:username])
        session[:id] = @user.id
        redirect '/tweets'
    end
end
    get '/login' do
       if logged_in?
       redirect to '/tweets'
       else
        erb :'users/login'
    end
end

    post '/login' do
        @user = User.find_by(username: params[:username])
        if @user  && @user.authenticate(params[:password])
            session[:id]= @user.id 
            redirect '/tweets'
        else
            
            redirect '/login'
        end
        
    end
    get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
  
    erb :'users/show'
    end

    get '/logout' do
    if logged_in?
        session.clear
        redirect to '/login'
    else
        redirect to '/'
    end
end


end
