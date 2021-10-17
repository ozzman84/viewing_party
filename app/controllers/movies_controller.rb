class MoviesController < ApplicationController
  def index
    if params[:query]
      @movies = MoviesService.movies_by_name(params[:query])
    elsif params[:search] = 'top_40'
      @movies = MoviesService.top_40_movies
    end
  end
end
