class Booking < ApplicationRecord
  belongs_to :schedule
  belongs_to :user
  belongs_to :tour

  def booking(current_tour)

    tourtime = current_tour.schedules.find(schedule_id)

    capacity_check = tourtime.max_capacity > tourtime.current_capacity + booking_size

    if capacity_check && self.save
      tourtime.update(current_capacity: tourtime.current_capacity + booking_size)
    else
      false
    end

  end


end
