class TweetsController < ApplicationController

get '/tweets/new' do 
    erb :'/tweets/new'
end 

post '/tweets' do 
    
    if !Helpers.params_empty?(params)
        new_tweet = Helpers.current_user(session).tweets.build(content: params[:content])
        new_tweet.save
        redirect "/tweets/#{new_tweet.id}"
    else
        @error = "Error: content was empty"
        redirect '/tweets/new'
    end 

end 

get '/tweets/:id' do 
    @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/show'
end 

get '/tweets' do 
  if Helpers.is_logged_in?(session)
    erb :'/tweets/index'
  else
    redirect '/login'
  end
end 



end
