require 'rails_helper'
require 'timecop'

RSpec.describe MoviesService, type: :service do
  before do
    Timecop.freeze(Time.local(2021, 10, 12))
  end

  after do
    Timecop.return
  end

  describe 'Top 40 Movies' do
    it 'returns top 40 movies' do
      stub_request(:get, "https://api.themoviedb.org/3/discover/movie?sort_by=vote_count.desc&api_key=#{ENV["movie_api_key"]}").to_return(body: File.read(File.join('spec', 'fixtures', 'tmdb_discover_movies_by_vote_count_page1.json')))
      stub_request(:get, "https://api.themoviedb.org/3/discover/movie?sort_by=vote_count.desc&page=2&api_key=#{ENV["movie_api_key"]}").to_return(body: File.read(File.join('spec', 'fixtures', 'tmdb_discover_movies_by_vote_count_page2.json')))

      expect(MoviesService.top_40_movies[:results][0][:title]).to eq('Inception')
      expect(MoviesService.top_40_movies[:results].length).to eq(20)
      expect(MoviesService.top_40_movies(2)[:results].length).to eq(20)
    end
  end

  describe 'search by movie name' do
    it 'returns up to 40 movies by keyword' do
      stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV["movie_api_key"]}&query=fight").to_return(body: File.read(File.join('spec', 'fixtures', 'tmdb_search_fight_page1.json')))
      stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV["movie_api_key"]}&query=fight&page=2").to_return(body: File.read(File.join('spec', 'fixtures', 'tmdb_search_fight_page2.json')))

      expect(MoviesService.movies_by_name('fight')[:results][0][:name]).to eq('fight')
      expect(MoviesService.movies_by_name('fight')[:results].length).to eq(20)
      expect(MoviesService.movies_by_name('fight', 2)[:results].length).to eq(20)
    end

    it 'returns up to 40 movies by keyword' do
      stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV["movie_api_key"]}&query=batman").to_return(body: File.read(File.join('spec', 'fixtures', 'tmdb_search_batman.json')))

      expect(MoviesService.movies_by_name('batman')[:results][0][:name]).to eq('batman v superman ultimate edition')
      expect(MoviesService.movies_by_name('batman')[:results].length).to eq(3)
    end
  end

  describe 'movie details' do
    it 'returns the movie details' do
      stub_request(:get, "https://api.themoviedb.org/3/movie/137113?api_key=#{ENV["movie_api_key"]}").to_return(body: File.read(File.join('spec', 'fixtures', 'tmdb_movie_details.json')))
      stub_request(:get, "https://api.themoviedb.org/3/movie/137113/credits?api_key=#{ENV["movie_api_key"]}").to_return(body: File.read(File.join('spec', 'fixtures', 'tmdb_movie_credits.json')))
      stub_request(:get, "https://api.themoviedb.org/3/movie/137113/reviews?api_key=#{ENV["movie_api_key"]}").to_return(body: File.read(File.join('spec', 'fixtures', 'tmdb_movie_reviews.json')))

      expect(MoviesService.movie(137113)[:title]).to eq('Edge of Tomorrow')
      expect(MoviesService.cast(137113)[:cast].length).to eq(37)
      expect(MoviesService.reviews(137113).length).to eq(5)
    end
  end
end
