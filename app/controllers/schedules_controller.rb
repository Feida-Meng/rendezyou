class SchedulesController < ApplicationController
  before_action :ensure_logged_in, only: [:new, :create, :edit, :destroy]
  before_action :load_tour


  def index
    @schedule = Schedule.all
  end

  def new
    ensure_owner(@tour)
    @schedule = Schedule.new
  end

  def create
    ensure_owner(@tour)
    @schedule = Schedule.new
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
    @schedule.update_attributes(schedule_params)
    if @schedule.save
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
    load_bookings
    load_tourists
    byebug
    @schedule.destroy
    @bookings.destroy_all
    redirect_to tour_path(@tour)
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
      redirect_to tour_path(@tour)
    end
  end

  def load_bookings
    @bookings = @schedule.bookings
  end

  def load_tourists
    tourist_ids = []

    @bookings.each do |booking|
      tourist_ids << booking.user_id
    end

    @tourists = User.where(id: tourist_ids)
  end

end
