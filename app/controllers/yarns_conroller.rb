class YarnsController < ApplicationController
    get '/yarns' do
        redirect_if_not_logged_in
        @user = User.find_by(id: params[:id])
        user_yarns = Yarn.all.select {|yarn| yarn.user_id == session[:user_id]}

        case params[:sort]
        when "color"
            @yarns = user_yarns.sort_by &:color
        when "weight"
            @yarns = user_yarns.sort_by &:weight
        when "fiber"
            @yarns = user_yarns.sort_by &:fiber
        when "num_of_skeins"
            @yarns = user_yarns.sort_by &:num_of_skeins
        when "yardage"
            @yarns = user_yarns.sort_by &:yardage
        else
            @yarns = user_yarns.sort_by &:name
        end
        
        erb :'/yarns/stash'
    end

    get '/yarns/new' do 
        erb :'/yarns/new'
    end

    post '/yarns' do
        redirect_if_not_logged_in
        if params[:name] != "" && params[:color] != "" && params[:weight] != "" && params[:fiber] != ""
            @yarn = Yarn.create(name: params[:name], color: params[:color], weight: params[:weight], fiber: params[:fiber], num_of_skeins: params[:num_of_skeins], yardage: params[:yardage] ,user_id: current_user.id)
            flash[:message] = "Yarn created successfully."
            redirect to "/yarns/#{@yarn.id}"
        else                
            flash[:errors] = "Please enter some info about your yarn to create a new entry."
            redirect to '/yarns/new'
        end
    end

    get '/yarns/:id' do
        set_yarn
        erb :'/yarns/show'
    end

    get '/yarns/:id/edit' do
        set_yarn
        redirect_if_not_logged_in
        if authorized_to_change?(@yarn)
            erb :'/yarns/edit'
        else
            redirect to "/yarns"
        end
    end

    patch '/yarns/:id' do
        set_yarn
        redirect_if_not_logged_in
        if authorized_to_change?(@yarn)
            @yarn.update(name: params[:name], color: params[:color], weight: params[:weight], fiber: params[:fiber], num_of_skeins: params[:num_of_skeins], yardage: params[:yardage])
            flash[:message] = "Yarn updated successfully."
            redirect to "/yarns/#{@yarn.id}"
        else
            flash[:errors] = "You are not authorized to edit this entry."
            redirect to "/yarns"
        end
    end

    delete '/yarns/:id' do
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