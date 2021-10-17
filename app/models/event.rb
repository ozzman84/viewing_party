class Event < ApplicationRecord
  belongs_to :user

  validates_presence_of :starttime, :title, :duration, :user_id
end
