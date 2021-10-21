class EventsController < ApplicationController
  before_action :set_current_movie

  def new
    @event = Event.new
    @movie = MovieFacade.movie_details(session[:movie_id])
    @friends = current_user.friend_users
    @event.attendees.build
  end

  def create
    @event = Event.new(event_params.merge({ user_id: current_user.id }))
    @movie = MovieFacade.movie_details(session[:movie_id])
    @friends = current_user.friend_users

    if @event.save
      session[:movie_id] = nil
      redirect_to dashboard_path, success: 'It\'s the f*#@in Catalina Wine Mixer! It\'s party time!'
    else
      flash[:notice] = @event.errors.messages[:starttime]
      @event.attendees.destroy_all
      @event.attendees.build
      render(partial: 'shared/new_event_form', layout: 'layouts/application', locals: { event: @event, movie: @movie, friends: @friends })
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :starttime, :duration, attendees_attributes: :user_id)
  end

  def movie_params
    params.permit(:movie_id)
  end

  def set_current_movie
    session[:movie_id] ||= params[:movie_id]
  end
end
