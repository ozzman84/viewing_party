class User < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :friends

  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
  validates :username, presence: true, uniqueness: true

  def get_friends
    User.where(users: { id: friends.pluck(:friend_id) })
  end

  def invited_events
    Event.joins(:attendees)
         .where(attendees: { user_id: id })
         .order(:starttime)
  end
end
