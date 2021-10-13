class Movie
  attr_reader :id,
              :name,
              :vote_average,
              :run_time,
              :genres,
              :summary,
              :cast,
              :reviews

  def initialize(params)
    @id = params[:id]
    @name = params[:original_title]
    @vote_average = params[:vote_average]
    @run_time = params[:runtime]
    @genres = params[:genres]
    @summary = params[:overview]
    @cast = params[:cast]
    @reviews = params[:reviews]
  end
end
