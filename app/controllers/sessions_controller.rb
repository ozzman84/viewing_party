class SessionsController < ApplicationController
  skip_before_action :user_present?

  def new; end

  def create
    user = User.find_by(email: params[:email])

    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_path,
                  notice: 'The first rule of Viewing Party is: you do not talk about Viewing Party. The second rule of Viewing Party is: you DO NOT talk about Viewing Party!'
    else
      redirect_to root_path, alert: 'This is not ‘Nam. This is bowling. There are rules.'
    end
  end

  def delete
    destroy
  end

  def destroy
    log_out_user
    redirect_to root_path, notice: 'Gentlemen, I wash my hands of this weirdness. - Jack Sparrow'
  end
end
