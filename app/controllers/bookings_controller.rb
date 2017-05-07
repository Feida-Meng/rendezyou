class BookingsController < ApplicationController
  def new
    @booking = Booking.new
  end

end
