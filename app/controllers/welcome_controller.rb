class WelcomeController < ApplicationController
  skip_before_action :user_present?
  def show
    flash[:notice] = "Chicken isn't vegan?"
  end
end
