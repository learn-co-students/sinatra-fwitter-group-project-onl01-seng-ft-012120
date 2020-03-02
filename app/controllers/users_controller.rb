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

  get '/logout' do
    if Helpers.is_logged_in?
      erb :'users/logout'
    else
      redirect '/login'
    end
  end

  post '/logout' do
    session.clear
    redirect '/login'
  end


  
end
