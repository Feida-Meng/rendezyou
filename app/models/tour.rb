class Tour < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :schedules, through: :bookings
end
