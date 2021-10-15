require 'rails_helper' 

RSpec.describe 'New Registration Page' do
  describe 'display' do
    before :each do
      visit(sign_up_path)
    end

    it 'has area to create new user' do
      within("#new-user-form") do
        expect(page).to have_content("Email")
        fill_in "user[email]", with: "josh@dog.com"
        expect(page).to have_content("Username")
        fill_in "user[username]", with: "joshie"
        expect(page).to have_content("Password")
        fill_in "user[password]", with: "dogman"
        expect(page).to have_content("Password confirmation")
        fill_in "user[password_confirmation]", with: "dogman"

        click_on("Sign Up")
      end
      expect(current_path).to eq(root_path)
    end
  end
end