require 'rails_helper'

RSpec.describe 'New Event Form', :vcr do
  describe 'as an athenticated user' do
    describe 'visiting new Viewing Party Form' do
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

        visit movies_path

        click_on "Inception"
        click_on 'Create A Viewing Party'
      end

      describe 'can create new event' do
        it 'has Movie title above form' do
          expect(page).to have_content('Inception')
          expect(current_path).to eq(new_event_path)
        end

        xit 'creates new event' do
          fill_in 'event[duration]', with: 1234
          save_and_open_page
          # fill_in 'event[starttime]', with: '2021-10-17T09:36'
          select '2021', from: 'starttime[when(1i)]'
          select 'December', from: 'date[when(2i)]'
          select '13', from: 'date[when(3i)]'
          select '05', from: 'date[when(4i)]'
          select '23', from: 'date[when(5i)]'
          click_on 'Create a Party'

          expect(page).to have_content('Party Created Successfully!')
          expect(current_path).to eq(dashboard_path)
        end

        xit 'has checkboxes next to each friend indicating an invitation(if has friends)' do
          fill_in 'Party duration', with: 1234
          fill_in 'Start time', with: '2021-10-17T09:36'
          click_on 'Create a Party'

          expect(page).to have_content('Date') #"2021-10-16 22:38:38.791048"
          expect(page).to have_content('Party Created Successfully!') #"2021-10-16 22:38:38.791048"
        end

        describe 'sad path' do
          xit 'party not created if duration is shorter than run time' do
            fill_in 'Party duration', with: 1
            fill_in 'Date', with: '12/24'
            fill_in 'Start time', with: '01:12 32'
            click_on 'Create a Party'

            expect(page).to have_content('Party not Created: Please re-enter information')
          end
        end
      end
    end
  end
end
#DateTime.parse(event_params[:starttime].gsub("/", "-")).strftime("%m-%d-%Y,%I:%M%p")
#DateTime.parse(event_params[:starttime]).strftime('%m-%d-%y- %I:%M %p') saving the info from the work page
