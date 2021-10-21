class UsersController < ApplicationController
  skip_before_action :user_present?, except: :show

  def show
    @user = User.find(current_user.id)
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path, success: "Welcome to the Thunder Dome #{current_user.username}! Account created."
    else
      redirect_to sign_up_path, alert: 'They\'ve done studies ya know, 60% of the time it works everytime. Account not created.'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email)
  end
end
