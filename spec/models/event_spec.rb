require 'rails_helper'

RSpec.describe Event, type: :model do
  describe "relationships" do
    it { should belong_to(:user) }
    it { should have_many(:attendees) }
    it { should accept_nested_attributes_for(:attendees) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:starttime) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:duration) }
    it { should validate_presence_of(:user_id) }
  end
end
