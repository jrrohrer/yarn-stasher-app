class UsersController < ApplicationController

    #routes for logging in
    get '/login' do
        #render the login form
        erb :'/users/login'

    end


    #routes for signing up
    get '/signup' do

    end
end