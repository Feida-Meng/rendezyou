class BookingsController < ApplicationController
  before_action :load_tour,except: %i(load_schedule booking_params)
  before_action :load_schedule,except: %i(load_tour booking_params)

  def new
    @booking = Booking.new
    #try render "booking" form directly other than default view later
  end

  def create
    # byebug
    @booking = @schedule.bookings.build(booking_params)
    @booking.user_id = current_user.id
    if @booking.booking
      redirect_to user_path(current_user)
    else
      render :new #try render "booking" directly later
    end

  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @oldbooking = Booking.find(params[:id])
    # byebug
    @newbooking = Booking.new(booking_params)
    if @oldbooking.edit_booking(@newbooking)
      redirect_to user_path(current_user)
    else
      render :edit
    end

  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.cancel_booking
    redirect_to user_path(current_user)
  end



private
 def load_tour
   @tour = Tour.find(params[:tour_id])
 end

 def load_schedule
   @schedule = Schedule.find(params[:schedule_id])
 end

  def booking_params
  params.require(:booking).permit(:schedule_id, :booking_size)
  end


end
