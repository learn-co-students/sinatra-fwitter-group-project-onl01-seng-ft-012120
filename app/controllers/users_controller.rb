class UsersController < ApplicationController

  get '/signup' do
    if session[:id]
      redirect "/tweets"
    else
      erb :'users/signup'
    end
    
  end

  post '/signup' do
    if !params_empty?(params)
      user = User.create(params)
      session[:id] = user.id
      redirect "/tweets"
    else
      redirect '/signup'
    end
    
  end

  helpers do

    def params_empty?(params)
      params.any? do |k,v|
        v.empty?
      end
    end

  end
    
end
