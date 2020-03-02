class UsersController < ApplicationController

  get '/signup' do
    if session[:id]
      redirect "/tweets"
    else
      erb :'users/signup'
    end
    
  end

  post '/signup' do
    if !Helpers.params_empty?(params)
      user = User.create(params)
      session[:id] = user.id
      redirect "/tweets"
    else
      redirect '/signup'
    end
  end

  
  
end
