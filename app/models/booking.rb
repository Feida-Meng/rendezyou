class Booking < ApplicationRecord
  belongs_to :schedule
  belongs_to :user
  belongs_to :tour

  def booking(current_tour)
    tourtime = current_tour.schedules.find(schedule_id)
    if capacity_check(tourtime,booking_size) && self.save #call capacity_check method below
      tourtime.update(current_capacity: tourtime.current_capacity + booking_size)
    else
      false
    end

  end

  def edit_booking(new_booking,current_tour)
    if new_booking.schedule_id != shedule_id #check if new booking has the same tour session as the old one
      new_booking.booking(current_tour)
    elsif new_booking.booking_size != booking_size #check if the new booking size = the old one
      tourtime = current_tour.schedules.find(schedule_id)
      if new_booking.capacity_check( tourtime,(new_booking.booking_size - booking_size) )#check if the new booking would over max capacity
        tourtime.update(current_capacity: tourtime.current_capacity + new_booking.booking_size - booking_size)
      else
        return false
      end
    else
      return false
    end

  end

  def capacity_check(tourtime,booking_size)
    capacity_check = tourtime.max_capacity > tourtime.current_capacity + booking_size
  end

end
