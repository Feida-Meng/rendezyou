class BookingsController < ApplicationController
  before_action :load_tour,except: %i(load_user booking_params)
  # before_action :load_tour,except: %i(load_tour booking_params)

  def new
    @booking = Booking.new
  end

  def create
    # byebug testing
    @booking = @tour.bookings.build(booking_params)

    if @booking.booking(@tour)
      redirect_to tour_path(@tour)
    else
      render :new
    end

  end

private
 def load_tour
   @tour = Tour.find(params[:tour_id]);
 end

 def load_user
   @user = User.find(params[:user_id]);
 end

  def booking_params
  # params[:booking][:tour_id] = 1 testing
  # params[:booking][:user_id] = 1 testing
  params.require(:booking).permit( :user_id, :schedule_id, :booking_size)
  end


end
