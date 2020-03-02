class TweetsController < ApplicationController

get '/tweets' do 
  if Helpers.is_logged_in?(session)
    erb :'/tweets/index'
  else
    redirect '/login'
  end
end 

end
