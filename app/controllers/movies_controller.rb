class MoviesController < ApplicationController
  def index
    if params[:query]
      unless params[:query] == ""
        @movies = MovieFacade.movies_query(params[:query])
      end
    elsif params[:search] == 'top_40'
      @movies = MovieFacade.top40
    end
  end
end
