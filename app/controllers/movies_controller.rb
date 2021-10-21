class MoviesController < ApplicationController
  def index
    if params[:query]
      unless params[:query] == ""
        @movies = MovieFacade.movies_query(params[:query])
      else
        flash[:alert] = "One time, she punched me in the face. It was awesome. Invalid Search"
      end
    elsif params[:search] == 'top_40'
      @movies = MovieFacade.top40
    end
  end
end
