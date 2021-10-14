class MoviesService < ApiService
  def self.top_40_movies
    page1 = receive_data('https://api.themoviedb.org/3/discover/movie?sort_by=vote_count.desc&api_key=da336b32ae4779ba9aa007085c1574ec')
    page2 = receive_data('https://api.themoviedb.org/3/discover/movie?sort_by=vote_count.desc&api_key=da336b32ae4779ba9aa007085c1574ec&page=2')
    movie_list_maker(page1) + movie_list_maker(page2)
  end

  def self.movies_by_name(search_string)
    page1 = receive_data("https://api.themoviedb.org/3/search/movie?api_key=da336b32ae4779ba9aa007085c1574ec&query=#{search_string}")
    if page1[:total_pages] > 1
      page2 = receive_data("https://api.themoviedb.org/3/search/movie?api_key=da336b32ae4779ba9aa007085c1574ec&query=#{search_string}&page=2")
      movies = movie_list_maker(page1) + movie_list_maker(page2)
    else
      movie_list_maker(page1)
    end
  end

  def self.movie_details(movie_id)
    Movie.new(movie_maker(movie_id))
  end

  private

  def self.movie_list_maker(param)
    param[:results].map do |movie|
      name = movie[:title].nil? ? movie[:name] : movie[:title]
      MovieListItem.new(movie[:id], name, movie[:vote_count])
    end
  end

  def self.movie_maker(movie_id)
    movie_details = receive_data("https://api.themoviedb.org/3/movie/#{movie_id}?api_key=da336b32ae4779ba9aa007085c1574ec")
    cast = receive_data("https://api.themoviedb.org/3/movie/#{movie_id}/credits?api_key=da336b32ae4779ba9aa007085c1574ec")
    reviews = receive_data("https://api.themoviedb.org/3/movie/#{movie_id}/reviews?api_key=da336b32ae4779ba9aa007085c1574ec")
    movie = {id: movie_details[:id], original_title: movie_details[:original_title], vote_average: movie_details[:vote_average], runtime: movie_details[:runtime], genres: movie_details[:genres], overview: movie_details[:overview], cast: cast[:cast], reviews: reviews[:results], vote_count: movie_details[:vote_count]}
  end


end
