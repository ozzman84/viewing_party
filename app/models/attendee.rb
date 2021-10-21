class Attendee < ApplicationRecord
  belongs_to :event, dependent: :destroy
  belongs_to :user, dependent: :destroy

  validates :user, :event, presence: true
end
