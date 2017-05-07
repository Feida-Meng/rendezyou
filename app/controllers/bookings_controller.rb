class BookingsController < ApplicationController
  before_action :load_tour,except: %i(load_user booking_params)
  before_action :load_user,except: %i(load_tour booking_params)

  def new
    @booking = Booking.new
    #try render "booking" form directly other than default view later
  end

  def create
    # byebug testing
    @booking = @tour.bookings.build(booking_params)

    if @booking.booking(@tour)
      redirect_to user_path(@user)
    else
      render :new #try render "booking" directly later
    end

  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @oldbooking = Booking.find(params[:id])
    @booking=Booking.new(booking_params)
    if @oldbooking.edit_booking(@booking,@tour)
      redirect_to user_path(@user)
    else
      render :edit
    end

  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.cancel_booking(@tour)
    redirect_to user_path(@user)
  end



private
 def load_tour
   @tour = Tour.find(params[:tour_id]);
 end

 def load_user
   @user = current_user;
 end

  def booking_params
  # params[:booking][:tour_id] = 1 testing
  # params[:booking][:user_id] = 1 testing
  params.require(:booking).permit( :tour_id,:user_id, :schedule_id, :booking_size)
  end


end
