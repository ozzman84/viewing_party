require 'rails_helper'

RSpec.describe 'Event New Form', :vcr do
  describe 'as athenticated user' do
    describe 'visiting the new viewing party' do
      before :each do
        user1 = User.create!(email: "doggass420@butt.com", password: 'password', username: 'PresidentBush')
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

        visit movies_path #change dashboard to resource show & will not require ID.

        click_on 'Top 40 Movies'
        click_on "Inception"

        visit new_event_path(id: 281984)
      end

      xit 'has Movie title above form' do
        expect(page).to have_content('Inception')
      end
    end
  end
end
