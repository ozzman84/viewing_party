class EventsController < ApplicationController
  def new
    @event = Event.new
    @movie = MoviesService.movie_details(params[:movie_id])
    @friends = current_user.get_friends
    @event.attendees.build
  end

  def create
    event = Event.create(event_params.merge({user_id: current_user.id}))
    if event.valid?
      redirect_to dashboard_path, success: 'Party Created Successfully!'
    else
      redirect_to new_event_path, alert: 'Party not Created: Please re-enter information'
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :starttime, :duration, attendees_attributes: :user_id)
  end
end
