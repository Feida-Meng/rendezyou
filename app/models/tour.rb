class Tour < ApplicationRecord
  belongs_to :user
  has_many :bookings, through: :schedules
  has_many :schedules
  # accepts_nested_attributes_for :schedules
end
