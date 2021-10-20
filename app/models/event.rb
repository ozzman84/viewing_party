class Event < ApplicationRecord
  belongs_to :user
  has_many :attendees
  accepts_nested_attributes_for :attendees, reject_if: proc { |att| att[:user_id] == 'not invited' }

  validates :title, :duration, :user_id, presence: true
  validate :past_date?

  def past_date?
    unless starttime.present? && starttime > DateTime.now
      errors.add(:starttime, "It must be some kind of hot tub time machine... Date must be in the future!")
    end
  end
end
