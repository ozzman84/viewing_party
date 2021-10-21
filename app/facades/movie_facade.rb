require './app/services/movies_service'

class MovieFacade
  class << self
    def top40(_page_num = nil)
      data1 = MoviesService.top_40_movies
      data2 = MoviesService.top_40_movies(2)

      movie_list(data1) + movie_list(data2)
    end

    def movies_query(search_string)
      data1 = MoviesService.movies_by_name(search_string)
      if data1[:total_pages] > 1
        data2 = MoviesService.movies_by_name(search_string, 2)
        movie_list(data1) + movie_list(data2)
      else
        movie_list(data1)
      end
    end

    def movie_details(movie_id)
      movie = MoviesService.movie(movie_id)
      cast = MoviesService.cast(movie_id)
      reviews = MoviesService.reviews(movie_id)

      collection = []
      10.times do |x|
        collection << cast[:cast][x]
      end

      details = movie.merge({ cast: collection })

      details[:reviews] = (reviews if reviews[:total_results].positive?)

      Movie.new(details)
    end

    private

    def movie_list(param)
      param[:results].map do |movie|
        name = movie[:title].nil? ? movie[:name] : movie[:original_title]
        MovieListItem.new(movie[:id], name, movie[:vote_count])
      end
    end
  end
end
