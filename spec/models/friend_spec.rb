require 'rails_helper'

RSpec.describe Friend, type: :model do
  describe "Relationships" do
    it { should belong_to(:user) }
  end

  describe 'Validations' do
    it { is_expected.not_to be_valid(:user) }
  end
end
