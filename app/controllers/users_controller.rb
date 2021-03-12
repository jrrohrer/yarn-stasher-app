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
            #user gets an error message and redirects back to login page
            redirect to '/users/login'
        end
    end

    #routes for signing up
    get '/signup' do
        #renders the signup form
        erb :'/users/signup'
    end

    post '/signup' do
        #creates new users and persists them to the database, but only if the info in params is valid
        if params[:username] != "" && params[:email] != "" && params[:password] != ""
            @user = User.create(params)

            redirect "/users/#{@user.id}"
        else 
            #user gets an error message and redirects back to signup page
            redirect to '/users/signup'
        end

    end

    #show route - user's landing page
    get '/users/:id' do
        @user = User.find_by(id: params[:id])
        erb :'/users/show'
    end

    #logs the user out and redirects to the home page
    get '/logout' do
        session.clear
        redirect '/'
    end

end