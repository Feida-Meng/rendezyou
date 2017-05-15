class Booking < ApplicationRecord
  belongs_to :schedule
  belongs_to :user
  validate :capacity_check
 # after_save :update_capacitiy

 def capacity_check
   unless tourtime.max_capacity >= (tourtime.current_capacity + booking_size)
     errors[:base] << "Not enough capacity"
   end

 end

  def tourtime
    Schedule.find(schedule_id)
  end

  def booking

    return save && tourtime.update(current_capacity:tourtime.current_capacity + booking_size )
  end

  def edit_booking(new_booking)

    # if new_booking.schedule_id != schedule_id #check if new booking has the same tour session as the old one
    #   byebug
    #   tourtime.update(current_capacity: tourtime.current_capacity - booking_size)
    #   update(schedule_id:new_booking.schedule_id,booking_size:new_booking.booking_size)
    #   return tourtime.update(current_capacity:tourtime.current_capacity + booking_size)
    # else

      if  tourtime.update(current_capacity: ( tourtime.current_capacity + new_booking.booking_size - booking_size) )
        # byebug
        return update(booking_size: new_booking.booking_size )
      else
        return false
      end

    # end

  end

  def cancel_booking
    tourtime.update(current_capacity: (tourtime.current_capacity - booking_size))
    destroy
  end

end
