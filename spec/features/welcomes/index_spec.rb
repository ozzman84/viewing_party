require 'rails_helper'

RSpec.describe 'Welcome Show Page' do
  describe 'displays' do
    before :each do
      user1 = User.create!(email: "doggass420@butt.com", password: 'password', username: 'PresidentBush')
      visit(root_path)
    end

    it 'Welcomes user to website with form to sign in' do
      expect(page).to have_link("Sign Up")
      expect(page).to have_content("Email")
      expect(page).to have_content("Password")
    end
  end

  describe 'sessions' do
    before :each do
      user1 = User.create!(email: "doggass420@butt.com", password: 'password', username: 'PresidentBush')
      visit(root_path)
    end

    scenario 'creates a new session for that user when correctly signed in' do
      fill_in 'email', with: "doggass420@butt.com"
      fill_in 'password', with: 'password'
      click_on "Log In"
      expect(current_path).to eq(dashboard_path)
    end

    scenario 'creates a new session for that user when incorrectly signed in' do
      fill_in 'email', with: "420@butt.com"
      fill_in 'password', with: 'pasword'
      click_on "Log In"
      expect(current_path).to eq(root_path)
    end
  end
end
