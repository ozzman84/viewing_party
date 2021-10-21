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
    @cast = movie_cast(params[:cast])
    @reviews = movie_reviews(params[:reviews])
  end

  private

  def movie_cast(cast)
    if cast.nil?
      'No Cast Recorded'
    else
      cast.map do |member|
        CastMember.new(member[:name], member[:character])
      end
    end
  end

  def movie_reviews(reviews)
    if reviews.nil?
      'No Reviews Recorded'
    else
      reviews[:results].map do |review|
        Review.new(review[:author], review[:content])
      end
    end
  end
end
