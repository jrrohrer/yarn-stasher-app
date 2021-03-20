class UsersController < ApplicationController

    #this controller should handle all of the user actions: logging in, signing up, creating a new user, redirecting to landing page, and logging out

    get '/login' do
        erb :'/users/login'
    end

    post '/login' do

        if params[:username] != "" && User.exists?(username: params[:username])#checks that username is not blank and whether it exists in the db
            
            @user = User.find_by(username: params[:username]) #@user = nil if no info is entered in the signup form AND if a username that does not exist is entered in the login form
            if @user.authenticate(params[:password]) #returns false when the authentication fails, and returns the User instance when it passes
                session[:user_id] = @user.id
                redirect to "/yarns"
            else
                flash[:errors] = "Invalid login. Please try again. If you do not have an account, please sign up."
                redirect to '/login'
            end 
        else
            flash[:errors] = "User not found. Please sign up if you do not already have an account."
            redirect to '/login'
        end

    end

    get '/signup' do
        erb :'/users/signup'
    end

    post '/signup' do
        if User.exists?(username: params[:username])
            flash[:errors] = "User already exists. If you already have an account, please use the log in page. If you do not already have an account, please choose a different username."
            redirect to '/signup'
        else
            if params[:username] != "" && params[:email] != "" && params[:password] != ""
                @user = User.create(params)
                session[:user_id] = @user.id 
                flash[:message] = "Welcome to Yarn Stasher! Account created successfully."
                redirect to '/yarns'
            else 
                flash[:errors] = "Signup failed. Please fill in all requested information and try again."
                redirect to '/signup'
            end
        end
    end

    #logs the user out and redirects to the home page
    get '/logout' do
        session.clear
        flash[:message] = "Logout successful. See you again soon!"
        redirect '/'
    end

end