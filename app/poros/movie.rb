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
    @vote_count = params[:vote_count]
    @run_time = params[:runtime]
    @genres = params[:genres]
    @summary = params[:overview]
    @cast = params[:cast] # create_cast
    @reviews = params[:reviews] # create_reviews
  end

  # remove create
  def create_cast
    @cast.map do |member|
      CastMember.new(member[:name], member[:character])
    end
  end

  # remove create
  def create_reviews
    @reviews.map do |review|
      Review.new(review[:author], review[:content])
    end
  end
end
