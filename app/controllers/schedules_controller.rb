class SchedulesController < ApplicationController
  before_action :load_tour

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new
    @schedule = @tour.schedules.build(schedule_params)
    if @schedule.save
      redirect_to profile_path
    else
      render: new
    end
  end

  def edit
    @schedule = Schedule.find(params[:id])
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
    @schedule.destroy
    redirect_to profile_path
  end

  private

  def load_tour
    @tour = Tour.find(params[:tour_id])
  end

  def schedule_params
    params[:tour][:schedules_attributes]["0"][:current_capacity] = 0
    params.require(:booking).permit(:tour_start_time, :tour_end_time, :tour_id, :max_capacity, :current_capacity)
  end

end
