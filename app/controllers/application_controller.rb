class ApplicationController < ActionController::Base
  helper_method :current_user
  protect_from_forgery with: :exception
  add_flash_types :success, :danger
  before_action :user_present?

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
