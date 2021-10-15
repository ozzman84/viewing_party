class MoviesService < ApiService
  class << self
    def top_40_movies
      uri = '/3/discover/movie?sort_by=vote_count.desc'
      page1 = MovieClient.fetch(uri)
      page2 = MovieClient.fetch("#{uri}&page=2")
      movie_list_maker(page1) + movie_list_maker(page2)
    end

    def movies_by_name(search_string)
      page1 = MovieClient.fetch("/3/search/movie?query=#{search_string}")
      if page1[:total_pages] > 1
        page2 = MovieClient.fetch("/3/search/movie?query=#{search_string}&page=2")
        movie_list_maker(page1) + movie_list_maker(page2)
      else
        movie_list_maker(page1)
      end
    end

    def movie_details(movie_id)
      Movie.new(movie_maker(movie_id))
    end

    private

    def movie_list_maker(param)
      param[:results].map do |movie|
        name = movie[:title].nil? ? movie[:name] : movie[:title]
        MovieListItem.new(movie[:id], name, movie[:vote_count])
      end
    end

    def movie_maker(movie_id)
      movie_details = MovieClient.fetch("/3/movie/#{movie_id}?")
      movie_details.merge(cast_and_reviews(movie_id))
    end

    def cast_and_reviews(movie_id)
      cast = MovieClient.fetch("/3/movie/#{movie_id}/credits?")
      reviews = MovieClient.fetch("/3/movie/#{movie_id}/reviews?")
      {
        cast: cast[:cast],
        reviews: reviews[:results]
      }
    end
  end
end
