require 'rails_helper'

RSpec.describe 'Movies Index Page', :vcr do
  describe 'display' do
    before :each do
      stub_request(:get, "https://api.themoviedb.org/3/discover/movie?api_key=#{ENV["movie_api_key"]}&sort_by=vote_count.desc").to_return(body: File.read(File.join('spec', 'fixtures', 'tmdb_discover_movies_by_vote_count_page1.json')))
      stub_request(:get, "https://api.themoviedb.org/3/discover/movie?sort_by=vote_count.desc&page=2&api_key=#{ENV["movie_api_key"]}").to_return(body: File.read(File.join('spec', 'fixtures', 'tmdb_discover_movies_by_vote_count_page2.json')))

      stub_request(:get, "https://api.themoviedb.org/3/movie/27205/reviews?api_key=#{ENV["movie_api_key"]}").to_return(body: File.read(File.join('spec', 'fixtures', 'tmdb_inception_reviews.json')))
      stub_request(:get, "https://api.themoviedb.org/3/movie/27205/credits?api_key=#{ENV["movie_api_key"]}").to_return(body: File.read(File.join('spec', 'fixtures', 'tmdb_inception_credits.json')))
      stub_request(:get, "https://api.themoviedb.org/3/movie/27205?api_key=#{ENV["movie_api_key"]}").to_return(body: File.read(File.join('spec', 'fixtures', 'tmdb_inception_details.json')))

      stub_request(:get, "https://api.themoviedb.org/3/movie/281984/reviews?api_key=#{ENV["movie_api_key"]}").to_return(body: File.read(File.join('spec', 'fixtures', 'tmdb_bvs_reviews.json')))
      stub_request(:get, "https://api.themoviedb.org/3/movie/281984/credits?api_key=#{ENV["movie_api_key"]}").to_return(body: File.read(File.join('spec', 'fixtures', 'tmdb_bvs_credits.json')))
      stub_request(:get, "https://api.themoviedb.org/3/movie/281984?api_key=#{ENV["movie_api_key"]}").to_return(body: File.read(File.join('spec', 'fixtures', 'tmdb_bvs_details.json')))

      stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV["movie_api_key"]}&query=batman").to_return(body: File.read(File.join('spec', 'fixtures', 'tmdb_search_batman.json')))

      user1 = User.create!(email: "doggass420@butt.com", password: 'password', username: 'PresidentBush')
      visit(root_path)
      within("#sign-in") do
        fill_in 'email', with: "doggass420@butt.com"
        fill_in 'password', with: 'password'
        click_on "Log In"
      end
      click_on 'Discover New Movies'
    end

    it 'can display a link to Top 40 Movies' do
      expect(current_path).to eq("/movies")
      within("#movies-home") do
        expect(page).to have_link("Top 40 Movies")
        click_on 'Top 40 Movies'

        expect(page).to have_content("Top 40 Movies")
        expect(page).to have_link("Inception")
      end
      within("#top-movie-27205") do

        click_on("Inception")
      end

      expect(current_path).to eq(details_path)
    end

    it 'can display search for movies by keyword' do
      fill_in 'query', with: 'batman'
      click_on("Search")

      expect(page).to have_link("batman v superman ultimate edition")
    end
  end
end
