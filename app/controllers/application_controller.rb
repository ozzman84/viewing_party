class ApplicationController < ActionController::Base
  helper_method :current_user
  protect_from_forgery with: :exception
  add_flash_types :success, :danger


  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end

# before_action :set_current_user
#
# def set_current_user
#   Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
# end
# this is only accessable in views and controllers and is thread local should be private and is a one liner no before action is needed because it only runs when it's called.
