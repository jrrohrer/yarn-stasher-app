class YarnsController < ApplicationController
    get '/yarns' do
        #allows user to view all of their yarns
        #view should contain links to edit or delete yarns?
        if logged_in?
            @yarns = Yarn.all.select {|yarn| yarn.user_id == session[:user_id]}
            erb :'/yarns/yarns'
        else
            redirect to '/'
        end
    end

    get '/yarns/new' do 
        #renders a form to allow the user to create a new yarn
        erb :'/yarns/new'
    end

    post '/yarns' do
        #creates and persists the new yarn to the database
        #redirects the user to view the individual yarn they just created
        #if logged_in?
         #   if params[:name] == "" && params[:color] == "" && params[:weight] == "" && params[:fiber_content] == ""
          #      redirect to '/yarns/new'
           # else
            #    @yarn = Yarn.create(params)
             #   redirect to '/yarns/:id'
            #end
        #else
        #    redirect to '/'
        #end

        raise params.inspect
    end

    get '/yarns/:id' do
        #allows user to view individual yarn
        #maybe a better place for links to edit and delete
    end

    get '/yarns/:id/edit' do
        #renders a form to edit an individual yarn
    end

    patch '/yarns/:id' do
        #updates an individual yarn entry based on the user's input in the edit form.
    end

    get '/yarns/:id/delete' do
        #removes the yarn from the database
    end
end