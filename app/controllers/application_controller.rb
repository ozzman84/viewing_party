class ApplicationController < ActionController::Base
  helper_method :current_user
  protect_from_forgery with: :exception
  add_flash_types :success, :danger
  before_action :user_present?
  # this is only accessable in views and controllers and is thread local should be private and is a one liner no before action is needed because it only runs when it's called.

  def user_present?
    redirect_to root_path, alert: 'Login to do stuff' if session[:user_id].nil?
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def log_out_user
    session[:user_id] = nil
  end
end
