class DetailsController < ApplicationController
  def show
    @movie = MoviesService.movie_details(params[:id])
  end
end
