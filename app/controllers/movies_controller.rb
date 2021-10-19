class MoviesController < ApplicationController
  def index
    if params[:query]
      @movies = MovieFacade.movies_query(params[:query])
    elsif params[:search] == 'top_40'
      @movies = MovieFacade.top40
    end
  end
end
