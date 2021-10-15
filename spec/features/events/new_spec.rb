require 'rails_helper'

RSpec.describe 'New Event Form', :vcr do
  describe 'athenticated user' do
    describe 'visiting new Viewing Party Form' do
      before :each do
        user1 = User.create!(email: "doggass420@butt.com", password: 'password', username: 'PresidentBush')
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

        visit movies_path

        click_on 'Top 40 Movies'
        click_on "Inception"
        click_on 'Create New Viewing Party'
        visit new_event_path(id: 281984)
      end

      it 'has Movie title above form' do
        expect(page).to have_content('Inception')
      end
    end
  end
end
