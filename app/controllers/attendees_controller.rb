class AttendeesController < ApplicationController
  def create
    Attendee.create(event_id: params[:event_id], user_id: params[:friend_id])
  end
end
