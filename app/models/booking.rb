class Booking < ApplicationRecord
  belongs_to :schedule
  belongs_to :user
  validates :booking_size, presence: true
  validate :capacity_check
  # validate :book_again?
 # after_save :update_capacitiy

  def capacity_check
    if booking_size.present?


      if created_at.nil?

        update_size = booking_size
      else

        update_size = @update_size
      end

      if tourtime.max_capacity < (tourtime.current_capacity + update_size)
        errors[:base] << "Not enough capacity"
      end

    end
  end

  # def book_again?
  #   if User.find(user_id).booked_schedules_ids.include? schedule_id
  #       errors[:base] << "Tour already booked!"
  #   end
  #
  # end

  def tourtime
    Schedule.find(schedule_id)
  end

  def booking
    return save && tourtime.update(current_capacity:tourtime.current_capacity + booking_size )
  end

  def edit_booking(params)
    booking_size_diff = params[:booking_size].to_i - booking_size

    @update_size = booking_size_diff
    if update_attributes(params) && tourtime.update(current_capacity: ( tourtime.current_capacity + booking_size_diff ) )
      return true
    else
      return false
    end

  end

  def cancel_booking
    tourtime.update(current_capacity: (tourtime.current_capacity - booking_size))

    destroy
  end

end
