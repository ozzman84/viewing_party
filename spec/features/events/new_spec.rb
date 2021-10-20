require 'rails_helper'

RSpec.describe 'New Event Form', :vcr do
  describe 'As an athenticated user' do
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
      allow_any_instance_of(ApplicationController).to receive(:user_present?).and_return(@user1)

      @date = DateTime.now + 6.days
      visit movies_path
      within("#movies-home") do
        click_on "Top 40 Movies"
      end
      click_on "Inception"
      click_on 'Create A Viewing Party'

    end

    describe 'New viewing party view' do
      it 'Has Movie title above form' do
        expect(page).to have_content('Inception')
        expect(current_path).to eq(new_event_path)

      end

      describe 'Select Create New Event' do
        before :each do
          fill_in 'event[duration]', with: 1234
          select @date.strftime('%Y'), from: 'event_starttime_1i'
          select @date.strftime('%B'), from: 'event_starttime_2i'
          select @date.strftime('%d'), from: 'event_starttime_3i'
          select @date.strftime('%I %p'), from: 'event_starttime_4i'
          select @date.strftime('%M'), from: 'event_starttime_5i'
        end

        context 'Without Friends' do
          it 'Successfully creates new party' do
            click_on 'Create a Party'

            expect(page).to have_content('It\'s the f*#@in Catalina Wine Mixer! It\'s party time!')
            expect(current_path).to eq(dashboard_path)
          end
        end

        context 'With Friends' do
          it 'Successfully creates new party' do
            within("#friend-#{@user2.id}") do
              check("event[attendees_attributes][0][user_id]")
            end

            click_on 'Create a Party'

            expect(current_path).to eq(dashboard_path)
            expect(page).to have_content('It\'s the f*#@in Catalina Wine Mixer! It\'s party time!')
          end
        end

        context 'Unsuccessful Creation' do
          it 'Doesn\'t create viewing party w/unsuccessful message' do
            # stub_request(:get, "https://api.themoviedb.org/3/movie/?api_key=da336b32ae4779ba9aa007085c1574ec")
            select '2017', from: 'event_starttime_1i'
            click_on 'Create a Party'
            within("#flashes") do
              expect(page).to have_content("It must be some kind of hot tub time machine... Date must be in the future!")
            end
          end
        end
      end
    end
  end
end
