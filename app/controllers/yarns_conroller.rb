class YarnsController < ApplicationController
    get '/yarns' do
        if logged_in?
            @yarns = Yarn.all.select {|yarn| yarn.user_id == session[:user_id]}
            erb :'/yarns/yarns'
        else
            redirect to '/'
        end
    end

    get '/yarns/new' do 
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
                flash[:message] = "Please enter some info about your yarn to create a new entry."
                redirect to '/yarns/new'
            end
        else
            redirect to '/'
        end

        
    end

    get '/yarns/:id' do
        set_yarn
        erb :'/yarns/show'
    end

    get '/yarns/:id/edit' do
        #renders a form to edit an individual yarn
        set_yarn
        if logged_in?
            if authorized_to_change?(@yarn)
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
          if authorized_to_change?(@yarn)
            @yarn.update(name: params[:name], color: params[:color], weight: params[:weight], fiber: params[:fiber])
            flash[:message] = "Yarn updated successfully."
            redirect to "/yarns/#{@yarn.id}"
          else
            flash[:message] = "You are not authorized to edit that entry."
            redirect to "/users/#{current_user.id}"
          end
        else
            redirect to '/'
        end
    end

    delete '/yarns/:id' do
        #removes the yarn from the database
        set_yarn
        if authorized_to_change?(@yarn)
            @yarn.destroy
            flash[:message] = "Yarn successfully deleted."
            redirect to '/yarns'
        else
            redirect to '/yarns'
        end
    end

    private

    def set_yarn
        @yarn = Yarn.find(params[:id])
    end
end