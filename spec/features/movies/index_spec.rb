require 'rails_helper'

RSpec.describe 'Movies Index' do
  describe 'As an authenticated user' do
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

      @user1 = User.create!(email: "doggass420@butt.com", password: 'password', username: 'PresidentBush')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
      allow_any_instance_of(ApplicationController).to receive(:user_present?).and_return(@user1)

      visit movies_path
    end

    describe 'Discover new movies view' do
      describe 'Top 40 Movies' do
        it 'has current path new movies' do
          expect(current_path).to eq(movies_path)
        end

        it 'has a link to Top 40 Movies' do
          expect(page).to have_link("Top 40 Movies")
          click_on 'Top 40 Movies'
          expect(current_path).to eq(movies_path)
        end

        it 'Movie link is to movie detail path' do
          click_on 'Top 40 Movies'
          click_on "Inception"
          expect(current_path).to eq(details_path)
        end
      end

      describe 'Search Movie names by keyword' do
        context 'With valid parameters' do
          it 'Returns search results with movie detail link' do
            expect(current_path).to eq(movies_path)

            fill_in 'query', with: 'batman'
            click_on "Search"

            expect(page).to have_link("batman v superman ultimate edition")
          end
        end

        context 'with invalid parameters' do
          it 'Returns no results message' do
            fill_in 'query', with: ''
            click_on("Search")
            within("#flashes") do
              expect(page).to have_content('One time, she punched me in the face. It was awesome. Invalid Search')
            end
          end
        end
      end
    end
  end
end
