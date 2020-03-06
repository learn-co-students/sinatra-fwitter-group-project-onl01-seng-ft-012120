class TweetsController < ApplicationController

    get '/tweets' do
        # binding.pry
        if logged_in?
            @tweets = Tweet.all
            erb :'tweets/tweet_index' 
        else
            redirect to '/login'
        end
    end

    get '/tweets/new' do
        # binding.pry
        if logged_in?
            erb :'tweets/new'
        else
            redirect to '/login'
        end
    end

    post '/tweets' do
        if params[:content].empty?
            redirect to 'tweets/new'
        else
            Tweet.create(content: params[:content], user_id: current_user.id)
            redirect to '/tweets'
        end
    end

    get '/tweets/:id' do 
        # binding.pry
        if !logged_in?
            redirect to '/login'
        else
            @tweet = Tweet.find_by(id: params[:id])
            erb :'tweets/show'
        end
    end

    get '/tweets/:id/edit' do
        # binding.pry
        if !logged_in?
            redirect to '/login'
        else
            if current_user.id == params[:id].to_i
                @tweet = Tweet.find(params[:id])
                erb :'tweets/edit'
            else
                redirect to '/tweets'
            end
        end 
    end

    patch '/tweets/:id' do
        # binding.pry
        @tweet = Tweet.find(params[:id])
        if params[:content].empty?
            redirect "/tweets/#{@tweet.id}/edit"
        else
            @tweet.content = params[:content]
            @tweet.save
            redirect "/tweets/#{@tweet.id}"
        end
    end

    delete '/tweets/:id/delete' do
        @tweet = Tweet.find(params[:id])
        if logged_in?
            if current_user.id == @tweet.user_id
                Tweet.find(params[:id]).destroy
                redirect to '/tweets'
            else
                redirect to '/tweets'
            end
        end
    end
    
end

