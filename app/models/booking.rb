class Booking < ApplicationRecord
  belongs_to :schedule
  belongs_to :user
  belongs_to :tour

  def booking(current_tour)
    tourtime = current_tour.schedules.find(self.schedule_id)
    if capacity_check(tourtime,booking_size) && self.save #call capacity_check method below
      tourtime.updates(current_capacity: tourtime.current_capacity + booking_size)
    else
      false
    end

  end

  def edit_booking(new_booking,current_tour)
    tourtime = current_tour.schedules.find(schedule_id)
    if new_booking.schedule_id != schedule_ids #check if new booking has the same tour session as the old one
      if new_booking.booking(current_tour) #call booking() method to create new tour session
        cancel_booking(current_tour) #call cancel_booking method
        return true #double check if necessary, just in case.
      end
    elsif new_booking.booking_size != booking_size #check if the new booking size = the old one

      if new_booking.capacity_check( tourtime,(new_booking.booking_size - booking_size) )#check if the new booking would over max capacity
        return tourtime.update(current_capacity: tourtime.current_capacity + new_booking.booking_size - booking_size)
      else
        return false
      end
    else
      return false
    end

  end

  def cancel_booking(current_tour)
    tourtime = current_tour.schedules.find(schedule_id)
    tourtime.update(current_capacity: tourtime.current_capacity - booking_size)
    self.destroy
  end

  def capacity_check(tourtime,booking_size)
    capacity_check = tourtime.max_capacity > tourtime.current_capacity + booking_size
  end



end
