class SessionsController < ApplicationController
    def new; end

    def create
      user = User.find_by(email: params[:email])

      if user.present? && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to dashboard_index_path, notice: 'Logged In'
      else
        redirect_to root_path
        flash[:alert] = 'Invalid email or password'
      end
    end

    def destroy
      session[:user_id] = nil
      redirect_to root_path, notice: 'Logged Out Bitch'
    end
end
