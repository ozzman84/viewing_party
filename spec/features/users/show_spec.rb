require 'rails_helper'
require 'timecop'

RSpec.describe 'Dashboard' do
  describe 'User Dashboard' do
    before :each do
      @user1 = User.create!(password: 'test', username: 'johhy', email: 'johhny@gmail.com')
      @user2 = User.create!(password: 'password', username: 'mike', email: 'mike@gmail.com')
      @user3 = User.create!(password: 'doggie', username: 'blop', email: 'smoke@gmail.com')
      @user1_friend = Friend.create!(user_id: @user1.id, friend_id: @user2.id)

      @event1 = @user1.events.create!(duration: 1234, starttime: "2018-05-08 08:08:00", title: "Dogman")
      @attendee1 = @event1.attendees.create!(user_id: @user2.id)

      @event2 = @user2.events.create!(duration: 430, starttime: "2024-09-05 05:07:00", title: "Shap")
      @attendee2 = @event2.attendees.create!(user_id: @user1.id)

      visit root_path
      within '#sign-in' do
        fill_in 'email', with: 'johhny@gmail.com'
        fill_in 'password', with: 'test'
        click_on "Log In"
      end

    end

    it 'returns Welcome links' do
      within '#username' do
        expect(page).to have_content("Welcome #{@user1.username}")
      end
    end

    it 'returns button to discover movies' do
      within '#discover-movies' do
        expect(page).to have_link('Discover New Movies')
        #expect(path).to eq(discover_new_movies_path) Add path once created
      end
    end

    it 'has friends section' do
      within '#friends' do
        expect(page).to have_content('Friends')
        expect(page).to have_content(@user2.username)
      end

      within '#new-friend' do
        fill_in 'friend', with: "smoke@gmail.com"
        click_on "Make Friend"
      end

      within '#friends' do
        expect(page).to have_content(@user3.username)
      end

      within '#flashes' do
        expect(page).to have_content("Added #{@user3.username} as a friend")
      end
    end

    it 'has viewing parties section' do
      within '#viewing-parties' do
        expect(page).to have_content('Hosting')
        expect(page).to have_content("Invited")

      end

      within '#hosted-events' do
        expect(page).to have_content("#{@event1.title}")
        expect(page).to have_content("Start Time: #{@event1.starttime}")
        expect(page).to have_content("Duration: #{@event1.duration}")
      end

      within '#invited_events' do
        expect(page).to have_content("#{@event2.title}")
        expect(page).to have_content("Start Time: #{@event2.starttime}")
        expect(page).to have_content("Duration: #{@event2.duration}")
      end
    end
  end
end
