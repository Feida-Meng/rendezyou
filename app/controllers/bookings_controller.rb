class BookingsController < ApplicationController
  before_action :load_tour,except: %i(load_schedule booking_params)
  before_action :load_schedule,except: %i(load_tour booking_params)
  before_action :ensure_logged_in, only: [:new, :create, :edit, :destroy]

  def new
    @booking = Booking.new
    #try render "booking" form directly other than default view later
  end

  def create

    @booking = @schedule.bookings.build(booking_params)
    @booking.schedule_id = @schedule.id
    @booking.user_id = current_user.id

    if @booking.booking
      # byebug
      redirect_to user_path(current_user)
    else
      render :new
    end

  end

  def edit
    @booking = Booking.find(params[:id])
    ensure_booking_user(@booking)
  end

  def update
    @oldbooking = Booking.find(params[:id])
    @booking = Booking.new(booking_params)
    ensure_booking_user (@oldbooking)
    if @oldbooking.edit_booking(@booking)
      redirect_to user_path(current_user)
    else
      render :edit
    end

  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.cancel_booking
    byebug
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
