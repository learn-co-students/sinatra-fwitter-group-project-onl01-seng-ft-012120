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

  get '/login' do 
    if Helpers.is_logged_in?(session)
        redirect '/tweets'
    else
        erb :'users/login'
    end 
  end 

  post '/login' do 
    if !Helpers.params_empty?(params)
        user = User.find_by(username: params[:username])
       if user  && user.authenticate(params[:password])
            session[:id] = user.id
            redirect "/tweets"
       end 
    else
        redirect '/signup'
    end
    
  end 
  
  get '/logout' do
    if Helpers.is_logged_in?(session)
      erb :'users/logout'
    else
      redirect '/'
    end
  end

  post '/logout' do
    session.clear
    redirect '/'
  end


  
end
