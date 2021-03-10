class UsersController < ApplicationController

    #routes for logging in
    get '/login' do
        #render the login form
        erb :'/users/login'
    end

    post '/login' do
        #finds the user
        @user = User.find_by(username: params[:username])
        #authenticates the user
        if @user.authenticate(params[:password]) #returns false when the authentication fails, and returns the User instance when it passes
            #create user session
            session[:user_id] = @user.id
            #redirect to the user's landing page
            redirect to "/users/#{@user.id}"
        else
            #user gets an error message and redirects to login page
        end
    end

    #routes for signing up
    get '/signup' do

    end

    #show route - user's landing page
    get '/users/:id' do
        erb :'/users/show'
    end
end