require 'rails_helper'
require 'timecop'

RSpec.describe 'Dashboard' do
  before do
    Timecop.freeze(Time.local(2021, 10, 12))
  end

  after do
    Timecop.return
  end
  describe 'User Dashboard' do
    before :each do
      @user = User.create!(password: 'test', username: 'johhy', email: 'johhny@gmail.com')
      # binding.pry
      # get(:show, session: {'user_id' => @user.id})
      visit root_path
      within '#sign-in' do
        fill_in 'email', with: 'johhny@gmail.com'
        fill_in 'password', with: 'test'
        click_on "Log In"
      end

    end

    it 'returns Welcome links' do
      within '#username' do
        expect(page).to have_content("Welcome #{@user.username}")
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
      end
    end

    it 'has viewing parties section' do
      within '#viewing-party' do
        expect(page).to have_content('Viewing Parties')
      end
    end
  end
end
