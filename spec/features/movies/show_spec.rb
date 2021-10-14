require 'rails_helper'

RSpec.describe 'Movies Show Page' do
  describe 'display' do
    before :each do
      stub_request(:get, "https://api.themoviedb.org/3/discover/movie?api_key=da336b32ae4779ba9aa007085c1574ec&sort_by=vote_count.desc").to_return(body: File.read(File.join('spec', 'fixtures', 'tmdb_discover_movies_by_vote_count_page1.json')))
      stub_request(:get, "https://api.themoviedb.org/3/discover/movie?sort_by=vote_count.desc&page=2&api_key=da336b32ae4779ba9aa007085c1574ec").to_return(body: File.read(File.join('spec', 'fixtures', 'tmdb_discover_movies_by_vote_count_page2.json')))

      stub_request(:get, "https://api.themoviedb.org/3/movie/27205/reviews?api_key=da336b32ae4779ba9aa007085c1574ec").to_return(body: File.read(File.join('spec', 'fixtures', 'tmdb_inception_reviews.json')))
      stub_request(:get, "https://api.themoviedb.org/3/movie/27205/credits?api_key=da336b32ae4779ba9aa007085c1574ec").to_return(body: File.read(File.join('spec', 'fixtures', 'tmdb_inception_credits.json')))
      stub_request(:get, "https://api.themoviedb.org/3/movie/27205?api_key=da336b32ae4779ba9aa007085c1574ec").to_return(body: File.read(File.join('spec', 'fixtures', 'tmdb_inception_details.json')))

      stub_request(:get, "https://api.themoviedb.org/3/movie/281984/reviews?api_key=da336b32ae4779ba9aa007085c1574ec").to_return(body: File.read(File.join('spec', 'fixtures', 'tmdb_bvs_reviews.json')))
      stub_request(:get, "https://api.themoviedb.org/3/movie/281984/credits?api_key=da336b32ae4779ba9aa007085c1574ec").to_return(body: File.read(File.join('spec', 'fixtures', 'tmdb_bvs_credits.json')))
      stub_request(:get, "https://api.themoviedb.org/3/movie/281984?api_key=da336b32ae4779ba9aa007085c1574ec").to_return(body: File.read(File.join('spec', 'fixtures', 'tmdb_bvs_details.json')))

      stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=da336b32ae4779ba9aa007085c1574ec&query=batman").to_return(body: File.read(File.join('spec', 'fixtures', 'tmdb_search_batman.json')))

      user1 = User.create!(email: "doggass420@butt.com", password: 'password', username: 'PresidentBush')
      visit(root_path)
      within("#sign-in") do
        fill_in 'email', with: "doggass420@butt.com"
        fill_in 'password', with: 'password'
        click_on "Log In"
      end
      click_on 'Discover New Movies'
      within("#movies-home") do
        click_on 'Top 40 Movies'
      end
      within("#top-movie-27205") do
        click_on("Inception")
      end
    end
    it 'Displays all Information about the movie' do
      within("#cast") do
      expect(page).to have_content("Cast:\nLeonardo DiCaprio As Dom Cobb")
      end

      within("#run-time") do
      expect(page).to have_content("Run Time:\n148")
      end
      within("#reviews") do
        expect(page).to have_content("Reviews:\nohlalipop")
      end
    end
  end
end
