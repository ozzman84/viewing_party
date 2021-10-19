class DetailsController < ApplicationController
  def show
    @movie = MovieFacade.movie_details(params[:id])
  end
end
