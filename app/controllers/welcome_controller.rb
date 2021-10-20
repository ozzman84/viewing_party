class WelcomeController < ApplicationController
  skip_before_action :user_present?
  def show; end
end
