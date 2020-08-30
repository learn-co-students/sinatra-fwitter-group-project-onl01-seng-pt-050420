class TweetsController < ApplicationController
  get "/tweets" do
    if logged_in?
      @user = User.find(session[:user_id])
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end

  get "/tweets/new" do
    redirect "/login" if !logged_in?
    @user = User.find(session[:user_id])
    erb :'tweets/new'
  end

  post "/tweets" do
    redirect "/tweets/new" if params[:content].empty?
    @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
    redirect "/tweets"
  end

  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end

  get "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit'
    else
      redirect '/login'
    end
  end

  patch "/tweets/:id" do
    @tweet = Tweet.find(params[:id])
    if !params[:content].empty?
      @tweet.content = params[:content]
      @tweet.save
      redirect '/tweets'
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete "/tweets/:id" do
    @tweet = Tweet.find(params[:id])
    redirect "/tweets/#{params[:id]}" if current_user != @tweet.user
    @tweet.delete
  end


end
