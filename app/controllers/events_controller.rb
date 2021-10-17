class EventsController < ApplicationController
  def new
    @event = Event.new
    @movie = MoviesService.movie_details(params[:movie_id])
  end

  def create
    event = Event.new(event_params)
    if event.save
      redirect_to dashboard_path, success: 'Party Created Successfully!'
    else
      redirect_to new_event_path, alert: 'Party not Created: Please re-enter information'
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :starttime, :duration).merge(user_id: current_user.id)
  end
end
