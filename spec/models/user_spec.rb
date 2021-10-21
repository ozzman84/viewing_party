require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Relationships' do
    it { should have_many(:events).dependent :destroy }
    it { should have_many(:friends) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:username) }
  end

  describe 'instance methods' do
    describe 'events_by_time' do
      before :each do
        @user1 = User.create!(password: 'test', username: 'johhy', email: 'johhny@gmail.com')
        @user2 = User.create!(password: 'password', username: 'mike', email: 'mike@gmail.com')
        @user3 = User.create!(password: 'doggie', username: 'blop', email: 'smoke@gmail.com')
        @user1_friend = Friend.create!(user_id: @user1.id, friend_id: @user2.id)

        @event1 = @user1.events.create!(duration: 1234, starttime: DateTime.now + 5.days, title: "Dogman")
        @attendee1 = @event1.attendees.create!(user_id: @user2.id)

        @event2 = @user2.events.create!(duration: 430, starttime: DateTime.now + 4.days, title: "Shap")
        @attendee2 = @event2.attendees.create!(user_id: @user1.id)

        @event3 = @user2.events.create!(duration: 430, starttime: DateTime.now + 2.days, title: "Shap")
        @attendee2 = @event3.attendees.create!(user_id: @user1.id)
      end

      it 'can return events that the user is invited to' do
        expect(@user1.invited_events.first.title).to eq("Shap")
        expect(@user2.invited_events.first.title).to eq("Dogman")
      end

      it 'can return events that the user is hosting' do
        expect(@user1.hosted_events.first.title).to eq("Dogman")
        expect(@user2.hosted_events.first.title).to eq("Shap")
      end

      it 'returns Users Friends' do
        expect(@user1.friend_users).to eq([@user2])
      end
    end
  end
end
