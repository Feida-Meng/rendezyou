class Schedule < ApplicationRecord
  has_many :bookings
  belongs_to :tour

  def tour_session
    "From #{tour_start_time.strftime("%Y %b %d, %H : %M")} to #{tour_end_time.strftime("%Y %b %d, %H : %M")}"
  end

end
