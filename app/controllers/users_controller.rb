class UsersController < ApplicationController
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
      redirect_to dashboard_path, success: 'Account Created'
    else
      redirect_to new_user_path, alert: 'Account Not Created'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email)
  end
end
