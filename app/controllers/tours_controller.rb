class ToursController < ApplicationController
  before_action :ensure_logged_in, only: [:new, :create, :edit, :destroy]
  before_action :load_countries, only: [:new, :edit]

  def index
    @tours = Tour.all
    if params[:search]
      @tours = Tour.search(params[:search]).order("created_at DESC")
    else
      @tours = Tour.all.order("created_at DESC")
    end
  end

  def new
    @tour = Tour.new
    # @tour.schedules.build
  end

  def show
    @tour = Tour.find(params[:id])
    @tourpoints = @tour.tourpoints

    if request.xhr?
      respond_to do |format|
        format.html do
          render @tour
        end
        format.json do
          render :json => @tour.to_json(:include => [:tourpoints])
        end
      end
    end

  end

  def create

    @tour = Tour.new(tour_params)
    @tour.user_id = current_user.id
    if @tour.save
      if params[:add_schedule]
        redirect_to new_tour_schedule_path(@tour)
      elsif params[:no_schedule]
        redirect_to tour_path(@tour)
      end
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
        redirect_to tour_path(@tour)
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
  def load_countries
    @countries = Country.all.order(:name)
  end


  def tour_params

    # params[:tour][:schedules_attributes]["0"][:current_capacity] = 0
    # byebug

    params.require(:tour).permit(:name, :description, :country_id, :rendezvous_point, :category, :capacity, :duration_in_ms, :tourpic)

  end



end
