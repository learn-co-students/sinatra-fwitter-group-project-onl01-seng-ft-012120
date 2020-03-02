class UsersController < ApplicationController

  get '/signup' do
    if Helpers.is_logged_in?(session) # To use the same validation thought the app
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
    if !Helpers.is_logged_in?(session)
    
        if !Helpers.params_empty?(params)
            user = User.find_by(username: params[:username])
        if user  && user.authenticate(params[:password])
                session[:id] = user.id
                redirect "/tweets"
        end 
        else
            redirect '/signup'
        end
    else 
        redirect '/logout'
    end 
  end 
  
  get '/logout' do
    # if Helpers.is_logged_in?(session)
    #   erb :'users/logout'
    # else
    #   redirect '/login'
    # end
    session.clear
    redirect '/login'
  end

#   post '/logout' do
#     session.clear
#     redirect '/login'
#   end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end


  
end
