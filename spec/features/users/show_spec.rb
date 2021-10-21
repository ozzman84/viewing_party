require 'rails_helper'
require 'timecop'

RSpec.describe 'User Show Dashboard' do
  describe 'as an athenticated User' do
    before :each do
      @user1 = User.create!(password: 'test', username: 'johhy', email: 'johhny@gmail.com')
      @user2 = User.create!(password: 'password', username: 'mike', email: 'mike@gmail.com')
      @user3 = User.create!(password: 'doggie', username: 'blop', email: 'smoke@gmail.com')
      @user1_friend = Friend.create!(user_id: @user1.id, friend_id: @user2.id)

      @event1 = @user1.events.create!(duration: 1234, starttime: DateTime.now + 5.days, title: "Dogman")
      @attendee1 = @event1.attendees.create!(user_id: @user2.id)

      @event2 = @user2.events.create!(duration: 430, starttime: DateTime.now + 5.days, title: "Shap")
      @attendee2 = @event2.attendees.create!(user_id: @user1.id)

      visit root_path

      fill_in 'email', with: 'johhny@gmail.com'
      fill_in 'password', with: 'test'
      click_on "Log In"
    end

    describe 'User view' do
      it 'Has Welcome links' do
        expect(page).to have_content("Welcome #{@user1.username}")
        expect(current_path).to eq(dashboard_path)
      end

      it 'Has button to discover movies' do
        expect(page).to have_link('Discover New Movies')
      end

      it 'Shows friends in friends section' do
        expect(page).to have_content('Friends')
        expect(page).to have_content(@user2.username)
      end

      it 'has a button to logout' do
        expect(page).to have_link('Log Out')
        click_on('Log Out')
        expect(current_path).to eq(root_path)
      end
    end

    describe 'adding friends' do
      context 'successfull' do
        it 'adds to friends section & show success message' do
          fill_in 'friend', with: "smoke@gmail.com"
          click_on "Make Friend"

          expect(page).to have_content(@user3.username)
          expect(page).to have_content("Did we just become best friends? #{@user3.username} is now a friend!")
        end
      end

      context 'unsuccessful' do
        it 'doesn\'t add to friends section & shows unsuccessful message' do
          fill_in 'friend', with: 'smokegmail.com'
          click_on 'Make Friend'

          expect(page).to have_no_content(@user3.username)
          expect(page).to have_content("Don’t you put that evil on me, #{@user1.username}! Please try another email address.")
        end
      end
    end

    describe 'User Show Viewing Parties' do
      context 'Hosing section' do
        it 'has title hosting' do
          expect(page).to have_content('Hosted Events')
        end

        it 'has hosted events with attributes' do
          expect(page).to have_content("#{@event1.title}")
          expect(page).to have_content("Start Time: #{@event1.starttime}")
          expect(page).to have_content("Duration: #{@event1.duration}")
        end
      end

      context 'Invited section' do
        it 'has title invited' do
          expect(page).to have_content("Invited")
        end

        it 'has invited events with attributes' do
          expect(page).to have_content("#{@event2.title}")
          expect(page).to have_content("Start Time: #{@event2.starttime}")
          expect(page).to have_content("Duration: #{@event2.duration}")
        end
      end
    end
  end
end
