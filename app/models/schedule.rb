class Schedule < ApplicationRecord
  has_many :bookings
  belongs_to :tour
  
end
