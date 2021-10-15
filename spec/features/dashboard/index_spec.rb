require 'rails_helper'
require 'timecop'

RSpec.describe 'Dashboard' do
  describe 'User Dashboard' do
    before :each do
      @user1 = User.create!(password: 'test', username: 'johhy', email: 'johhny@gmail.com')
      @user2 = User.create!(password: 'password', username: 'mike', email: 'mike@gmail.com')
      @user3 = User.create!(password: 'doggie', username: 'blop', email: 'smoke@gmail.com')
      @user1_friend = Friend.create!(user_id: @user1.id, friend_id: @user2.id)

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
      within '#viewing-party' do
        expect(page).to have_content('Viewing Parties')
      end
    end
  end
end
