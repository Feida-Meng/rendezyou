class SchedulesController < ApplicationController
  before_action :ensure_logged_in, only: [:new, :create, :edit, :destroy]
  before_action :load_tour


  def index
    @schedule = Schedule.all
  end

  def new
    @schedule = Schedule.new
    ensure_tour_user
  end

  def create
    @schedule = Schedule.new
    @schedule = @tour.schedules.build(schedule_params)
    ensure_tour_user
    if @schedule.save
      redirect_to tour_path(@tour)
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
    params[:schedule][:current_capacity] = 0
    params.require(:schedule).permit(:tour_start_time, :tour_end_time, :tour_id, :max_capacity, :current_capacity)
  end

end
