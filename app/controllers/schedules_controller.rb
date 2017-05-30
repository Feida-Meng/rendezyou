class SchedulesController < ApplicationController
  before_action :ensure_logged_in, only: [:new, :create, :edit, :destroy]
  before_action :load_tour
  before_action :load_tourists, only: [:destroy]


  def index
    @schedule = Schedule.all
  end

  def new
    ensure_owner(@tour)
    @schedule = Schedule.new
  end

  def create
    ensure_owner(@tour)

    @schedule = @tour.schedules.build(schedule_params)

    @schedule.max_capacity = @tour.capacity
    if @schedule.save
      if params[:save_one]
        redirect_to tour_path(@tour)
      elsif params[:add_more]
        redirect_to new_tour_schedule_path(@tour)
      end
    else
      render :new
    end
  end

  def edit
    ensure_owner(@tour)
    @schedule = Schedule.find(params[:id])
    no_bookings
  end

  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update_attributes(schedule_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  def show
    @schedule = Schedule.find(params[:id])
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    unless @schedule.bookings.empty?
      load_tourists
      UserMailer.cancel_schedule_email(@tourists, @schedule, @tour).deliver
      # byebug
      @schedule.destroy
      @bookings.destroy_all
      redirect_to tour_path(@tour)
    else
      @schedule.destroy
      @bookings.destroy_all
      redirect_to tour_path(@tour)
    end
  end

  private

  def load_tour
    @tour = Tour.find(params[:tour_id])
  end

  def schedule_params
    params.require(:schedule).permit(:tour_start_time, :tour_id, :max_capacity, :current_capacity)
  end

  def no_bookings
    unless @schedule.bookings.empty?
      flash[:alert] = "You cannot edit a schedule if people have booked it"
      redirect_to tour_path(@tour) and return
    end
  end


  def load_tourists
    @schedule = Schedule.find(params[:id])
    @bookings = @schedule.bookings
    tourist_ids = []
    @bookings.each do |booking|
      tourist_ids << booking.user_id
    end
    @tourists = User.where(id: tourist_ids)
  end

end
