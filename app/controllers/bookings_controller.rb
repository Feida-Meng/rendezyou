class BookingsController < ApplicationController
  before_action :load_tour,except: %i(load_schedule booking_params)
  before_action :load_schedule,except: %i(load_tour booking_params)
  before_action :ensure_logged_in, only: [:new, :create, :edit, :destroy, :update]
  before_action :load_tour_guide, only: [:create, :edit, :update, :destroy]

  def new
    @booking = Booking.new
    #try render "booking" form directly other than default view later
  end

  def create

    @booking = @schedule.bookings.build(booking_params)
    @booking.schedule_id = @schedule.id
    @booking.user_id = current_user.id

    if @booking.booking
      @user = current_user
      UserMailer.booking_confirmation_email(@user,
                                            @tour,
                                            @schedule,
                                            @tour_guide,
                                            @booking).deliver
      UserMailer.guide_booking_confirmation_email(@tour_guide,
                                                  @booking,
                                                  @tour,
                                                  @schedule).deliver
      redirect_to user_path(current_user)
    else
      render :new
    end

  end

  def edit
    @booking = Booking.find(params[:id])
    ensure_owner(@booking)
  end

  def update
    @booking = Booking.find(params[:id])
    ensure_owner(@booking)
    if @booking.edit_booking(booking_params)
      @user = current_user
      UserMailer.booking_edit_email(@user,
                                    @tour,
                                    @schedule,
                                    @tour_guide,
                                    @booking).deliver
      UserMailer.guide_booking_edit_email(@tour_guide,
                                          @booking,
                                          @tour,
                                          @schedule).deliver
      redirect_to user_path(current_user)
    else
      render :edit
    end

  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.cancel_booking
    UserMailer.guide_cancel_booking_email(@tour_guide,
                                          @booking,
                                          @tour,
                                          @schedule).deliver
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

  def load_tour_guide
    @tour_guide = User.find(@tour.user_id)
  end

end
