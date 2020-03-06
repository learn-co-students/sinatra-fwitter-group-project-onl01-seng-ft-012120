require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_secret"
  end

  get '/' do
    erb :index
  end

  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def valid_signup?(params)
      !params[:username].empty? && !params[:email].empty? && !params[:password].empty? 
    end

    def current_user
      @user = User.find_by(id: session[:user_id])
    end
  end
end
