class Tour < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :schedules
  accepts_nested_attributes_for :schedules
end
