class TweetsController < ApplicationController

get '/tweets/new' do 
  if Helpers.is_logged_in?(session)
    erb :'/tweets/new'
  else
    redirect 'login'
  end
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
  @user = Helpers.current_user(session)
  if Helpers.is_logged_in?(session)
    @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/show'
  else
    redirect '/login'
  end
   
end 

get '/tweets/:id/edit' do
  @tweet = Tweet.find_by_id(params[:id])
  if !Helpers.is_logged_in?(session)
    redirect '/login'
  else
    if Helpers.current_user(session).id == @tweet.user_id
      erb :'tweets/edit'
    else
      redirect "/tweets/#{@tweet.id}"
    end
  end
end

  patch '/tweets/:id' do
    tweet = Tweet.find_by_id(params[:id])
    if !Helpers.params_empty?(params)
      tweet.update(content: params[:content])
      redirect "tweets/#{tweet.id}"
    else
      redirect "/tweets/#{tweet.id}/edit"
    end
  end

get '/tweets' do 
  if Helpers.is_logged_in?(session)
    erb :'/tweets/index'
  else
    redirect '/login'
  end
end 



end
