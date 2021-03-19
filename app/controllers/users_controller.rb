class UsersController < ApplicationController

    #this controller should handle all of the user actions: logging in, signing up, creating a new user, redirecting to landing page, and logging out

    #routes for logging in
    get '/login' do
        erb :'/users/login'
    end

    post '/login' do

        if params[:username] != "" && User.exists?(username: params[:username])#checks that username is not blank and whether it exists in the
            
            @user = User.find_by(username: params[:username]) #@user = nil if no info is entered in the signup form AND if a username that does not exist is entered in the login form
            if @user.authenticate(params[:password]) #returns false when the authentication fails, and returns the User instance when it passes
                session[:user_id] = @user.id
                redirect to "/users/#{@user.id}"
            else
                #error message explaining failed login attempt
                redirect to '/login'
            end 
        else
            #error message asking user to create an account if they don't have one already
            redirect to '/login'
        end

    end

    get '/signup' do
        erb :'/users/signup'
    end

    post '/signup' do
        if params[:username] != "" && params[:email] != "" && params[:password] != ""
            @user = User.create(params)
            session[:user_id] = @user.id #signs the user in without redirecting them to the login page
            redirect "/users/#{@user.id}"
        else 
            #user gets an error message and redirects back to signup page
            redirect to '/signup'
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