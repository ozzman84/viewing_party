class Attendee < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :user, :event, presence: true
end
