class SchedulesController < ApplicationController
  before_action :ensure_logged_in, only: [:new, :create, :edit, :destroy]
  before_action :load_tour


  def index
    @schedule = Schedule.all
  end

  def new
    ensure_tour_user
    @schedule = Schedule.new
  end

  def create
    ensure_tour_user
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
    ensure_tour_user
    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])
    @schedule.update_attributes(schedule_params)
    ensure_tour_user
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
    @schedule.destroy
    redirect_to profile_path
  end

  private

  def load_tour
    @tour = Tour.find(params[:tour_id])
  end

  def schedule_params
    params.require(:schedule).permit(:tour_start_time, :tour_id, :max_capacity, :current_capacity)
  end

end
