class Schedule < ApplicationRecord
  has_many :bookings
  belongs_to :tour

  validates :max_capacity, presence: true

  def tour_session
    "From #{tour_start_time.strftime("%Y %b %d, %H : %M")} to #{tour_end_time.strftime("%Y %b %d, %H : %M")}"
  end

end
