class FriendsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new; end

  def create
    if friend_user = User.find_by(email: params[:friend])
      friend = Friend.create(user_id: session[:user_id], friend_id: friend_user.id)
      flash[:notice] = "Did we just become best friends? #{friend_user.username} is now a friend!"
    else
      flash[:alert] = "Don’t you put that evil on me, #{current_user.username}! Please try another email address."
    end
    redirect_to dashboard_path
  end
end
