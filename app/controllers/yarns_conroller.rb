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
        #checks that the user is logged in and that the form was completed
        #redirects the user to view the individual yarn they just created
        if logged_in?
            if params[:name] != "" && params[:color] != "" && params[:weight] != "" && params[:fiber] != ""
                @yarn = Yarn.create(name: params[:name], color: params[:color], weight: params[:weight], fiber: params[:fiber], user_id: current_user.id)
                redirect to "/yarns/#{@yarn.id}"
            else
                redirect to '/yarns/new'
            end
        else
            redirect to '/'
        end

        
    end

    get '/yarns/:id' do
        #allows user to view individual yarn
        #maybe a better place for links to edit and delete
        set_yarn
        erb :'/yarns/show'
    end

    get '/yarns/:id/edit' do
        #renders a form to edit an individual yarn
        set_yarn
        if logged_in?
            if @yarn.user == current_user
                erb :'/yarns/edit'
            else
                redirect to "/users/#{current_user.id}"
            end
        else
            redirect '/'
        end
    end

    patch '/yarns/:id' do
        #updates an individual yarn entry based on the user's input in the edit form.
        set_yarn
        if logged_in?
          if @yarn.user == current_user
            @yarn.update(name: params[:name], color: params[:color], weight: params[:weight], fiber: params[:fiber])
            redirect to "/yarns/#{@yarn.id}"
          else
            redirect to "/users/#{current_user.id}"
          end
        else
            redirect to '/'
        end
    end

    get '/yarns/:id/delete' do
        #removes the yarn from the database
    end

    private

    def set_yarn
        @yarn = Yarn.find(params[:id])
    end
end