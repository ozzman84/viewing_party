class FriendsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new; end

  def create
    if friend_user = User.find_by(email: params[:friend])
      friend = Friend.create(user_id: session[:user_id], friend_id: friend_user.id)
      flash[:notice] = "Added #{friend_user.username} as a friend"
    else
      flash[:alert] = 'Not a valid email'
    end
    redirect_to dashboard_path
  end

  private

  def user_params
    params.permit(:friend)
  end
end
