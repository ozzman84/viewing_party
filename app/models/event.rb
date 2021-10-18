class Event < ApplicationRecord
  belongs_to :user
  has_many :attendees
  accepts_nested_attributes_for :attendees, reject_if: proc { |att| att[:user_id] == 'not invited' }

  validates_presence_of :starttime, :title, :duration, :user_id
end
