class SessionsController < ApplicationController
    def new;end

    def create 
        user = User.find_by(email: params[:email])

        if user.present? && user.authenticate(params[:password])
            session[:user_id] = user.id
        else  
            binding.pry
            flash.now[:alert] = 'Invalid email or password'
            # redirect_to 
        end
    end
end
