class ToursController < ApplicationController
  before_action :ensure_logged_in, only: [:new, :create, :edit, :destroy]
  # before_action :load_countries_and_cities, only: [:new, :create]

  def index
    @tours = Tour.all
  end

  def new
    @tour = Tour.new
    @tour.schedules.build
  end

  def show
    @tour = Tour.find(params[:id])
  end

  def create
    @tour = Tour.new(tour_params)
    @tour.user_id = current_user.id
    if @tour.save
      redirect_to tours_path
    else
      render :new
    end
  end

  def edit
    @tour = Tour.find(params[:id])
    ensure_tour_user
  end

  def update
    @tour = Tour.find(params[:id])
    @tour.update_attributes(tour_params)
    ensure_tour_user
    if @tour.save
      redirect_to tour_path
    else
      render :edit
    end
  end

  def destroy
    @tour = Tour.find(params[:id])
    @tour.destroy
    redirect_to tours_path
  end

  private

  def tour_params
    params[:tour][:schedules_attributes]["0"][:current_capacity] = 0
    # byebug
    params.require(:tour).permit(:name, :description, :city, :country, :address, :category, :capacity, schedules_attributes: [:tour_start_time, :tour_end_time, :max_capacity, :current_capacity])
  end



end
