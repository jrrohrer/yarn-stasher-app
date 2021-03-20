require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "sinatra_yarn_stasher_app"
    register Sinatra::Flash
  end

  get "/" do
    if logged_in?
      redirect "/yarns"
    else
      erb :index
    end
  end

  #helper methods

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id] 
    end

    def authorized_to_change?(yarn)
      yarn.user == current_user
    end

    def redirect_if_not_logged_in
      if !logged_in?
        flash[:errors] = "You must be logged in to view that page."
        redirect '/'
      end
    end
  end

end
