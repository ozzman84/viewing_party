class MoviesService
  class << self
    def top_40_movies(page = nil)
      uri = "/3/discover/movie?sort_by=vote_count.desc"
      if !page.nil? # Ternary
        page_num = "&page=#{page}"
        uri += page_num
      end
      MovieClient.fetch(uri)
    end

    def movies_by_name(search_string, page = nil)
      if !page.nil?
        search_string = search_string + "&page=" + page.to_s
      end
      MovieClient.fetch("/3/search/movie?query=#{search_string}")
    end

    def movie(movie_id)
      movie_details = MovieClient.fetch("/3/movie/#{movie_id}?")
    end

    def cast(movie_id)
      MovieClient.fetch("/3/movie/#{movie_id}/credits?")
    end

    def reviews(movie_id)
      MovieClient.fetch("/3/movie/#{movie_id}/reviews?")
    end
  end
end
