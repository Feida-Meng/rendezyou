class Schedule < ApplicationRecord
  has_many :bookings
  belongs_to :tour

  # validates :max_capacity, presence: true
  validate :date_in_past
  validate :no_duplicates

  def tour_session
    "#{tour_start_time.strftime("%b %d, %Y at %I:%M%P")}"
  end

  def date_in_past
   if tour_start_time < Time.now
     errors.add(:tour_start_time, "cannot be in the past")
   end
  end

  def no_duplicates
    if current_capacity == 0 && Schedule.where(tour_id: tour_id, tour_start_time: tour_start_time).exists?
      errors.add(:tour_start_time, "already exists")
    end
  end


  #
  # def validate_dates
  #   if date_in_past(tour_start_time)
  #     errors.add(:tour_start_time, "cannot be in the past")
  #   end
  # end


end
