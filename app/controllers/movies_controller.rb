class MoviesController < ApplicationController
  def index
    if params[:query]
      if params[:query] == ''
        flash[:alert] = 'One time, she punched me in the face. It was awesome. Invalid Search'
      else
        @movies = MovieFacade.movies_query(params[:query])
      end
    elsif params[:search] == 'top_40'
      @movies = MovieFacade.top40
    end
  end
end
