class TweetsController < ApplicationController
    get '/tweets' do 
        if logged_in?
            @tweets = Tweet.all 
            erb :'/tweets/index'
        else
            redirect "/login"
        end
    end

    get '/tweets/new' do  
        if logged_in?
            erb :'tweets/new'
        else
            redirect '/login'
        end
    end

    post '/tweets' do
        # authenticate
        if logged_in?
        @tweet = Tweet.new(content: params[:content], user: current_user)
            if @tweet.save
                redirect '/tweets'
            else
                @error = "Cannot Create Tweet. Try Again."
                redirect '/tweets/new'
            end
        end
    end

    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find_by(id: params[:id])
            erb :'/tweets/show'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        @tweet = Tweet.find_by(id: params[:id])
        if logged_in?
            erb :'/tweets/edit'
        else
            redirect '/login'
        end
      end 

    patch '/tweets/:id' do
        @tweet = Tweet.find_by(id: params[:id])
        if @tweet.update(content: params[:content])
          redirect '/tweets'
        else
          redirect "/tweets/#{@tweet.id}/edit"
        end
      end
    
    delete '/tweets/:id/delete' do 
        @tweet = Tweet.find_by(id: params[:id])
        if @tweet.user == current_user
            @tweet.destroy
            redirect '/tweets'
        else
            redirect '/tweets'
        end   
    end
     
end
