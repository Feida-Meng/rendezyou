class Booking < ApplicationRecord
  belongs_to :schedule
  belongs_to :user
  belongs_to :tour



end
