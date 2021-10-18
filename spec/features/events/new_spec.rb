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
        @user2 = User.create!(password: 'password', username: 'mike', email: 'mike@gmail.com')
        @user3 = User.create!(password: 'doggie', username: 'blop', email: 'smoke@gmail.com')
        @user1_friend = Friend.create!(user_id: @user1.id, friend_id: @user2.id)
        @user1_friend2 = Friend.create!(user_id: @user1.id, friend_id: @user2.id)
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

        it 'creates new event' do
          fill_in 'event[duration]', with: 1234
          select '2021', from: 'event_starttime_1i'
          select 'December', from: 'event_starttime_2i'
          select '13', from: 'event_starttime_3i'
          select '05 AM', from: 'event_starttime_4i'
          select '30', from: 'event_starttime_5i'
          click_on 'Create a Party'

          expect(page).to have_content('Party Created Successfully!')
          expect(current_path).to eq(dashboard_path)
        end

        it 'has checkboxes next to each friend indicating an invitation(if has friends)' do
          fill_in 'event[duration]', with: 1234
          select '2021', from: 'event_starttime_1i'
          select 'December', from: 'event_starttime_2i'
          select '13', from: 'event_starttime_3i'
          select '05 AM', from: 'event_starttime_4i'
          select '30', from: 'event_starttime_5i'
          within("#friend-#{@user2.id}") do
            check("event[attendees_attributes][0][user_id]")
          end
          click_on 'Create a Party'

          expect(current_path).to eq(dashboard_path) #"2021-10-16 22:38:38.791048"
          expect(page).to have_content('Party Created Successfully!')
          expect(Attendee.all.length).to eq(1)
          expect(Event.all.length).to eq(5)#"2021-10-16 22:38:38.791048"
          #"2021-10-16 22:38:38.791048"
        end
      end
    end
  end
end
#DateTime.parse(event_params[:starttime].gsub("/", "-")).strftime("%m-%d-%Y,%I:%M%p")
#DateTime.parse(event_params[:starttime]).strftime('%m-%d-%y- %I:%M %p') saving the info from the work page
