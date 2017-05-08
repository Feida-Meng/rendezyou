class Booking < ApplicationRecord
  belongs_to :schedule
  belongs_to :user
  belongs_to :tour

  def tourtime
    Schedule.find(schedule_id)
  end
  def booking
    # tourtime = current_tour.schedules.find(schedule_id)
    # byebug
    if capacity_check(booking_size) && self.save #call capacity_check method below
      tourtime.update(current_capacity: tourtime.current_capacity + booking_size)
    else
      false
    end

  end

  def edit_booking(new_booking)

    if new_booking.schedule_id != schedule_id #check if new booking has the same tour session as the old one
      # byebug
      if new_booking.booking #call booking() method to create new tour session
        cancel_booking #call cancel_booking method
        return true #double check if necessary, just in case.
      else
        return false
      end
    elsif new_booking.booking_size != booking_size #check if the new booking size = the old one
      if new_booking.capacity_check(new_booking.booking_size - booking_size)#check if the new booking would over max capacity
        tourtime.update(current_capacity: ( tourtime.current_capacity + new_booking.booking_size - booking_size) )
        return update(booking_size: new_booking.booking_size )
      else
        return false
      end
    else
      return false
    end

  end

  def cancel_booking
    tourtime.update(current_capacity: tourtime.current_capacity - booking_size)
    self.destroy
  end

  def capacity_check(booking_size_check)
    capacity_check = tourtime.max_capacity > (tourtime.current_capacity + booking_size_check)
  end



end
