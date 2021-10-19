require 'rails_helper'

RSpec.describe Attendee, type: :model do
  describe 'Relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:event) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:event) }
  end
end
