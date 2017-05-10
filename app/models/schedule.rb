class Schedule < ApplicationRecord
  has_many :bookings
  belongs_to :tour

  validates :max_capacity, presence: true
  validate :validate_dates
  validate :no_duplicates

  def tour_session
    "#{tour_start_time.strftime("%b %d, %Y at %H:%M")} to #{tour_end_time.strftime("%H:%M")}"
  end

  def date_in_past(time)
   if time < Time.now
     return true
   end
  end

  def no_duplicates
    if Schedule.where(tour_id: tour_id, tour_start_time: tour_start_time).exists?
      errors.add(:tour_start_time, "already exists")
    end
  end

  def validate_dates
    if date_in_past(tour_start_time)
      errors.add(:tour_start_time, "cannot be in the past")
    elsif date_in_past(tour_end_time)
      errors.add(:tour_end_time, "cannot be in the past")
    elsif tour_end_time <= tour_start_time
      errors.add(:tour_end_time, "cannot be before the tour starts")
    end
  end


end
