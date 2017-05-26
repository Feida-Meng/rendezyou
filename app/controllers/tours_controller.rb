class ToursController < ApplicationController

  before_action :ensure_logged_in, only: [:new, :create, :edit, :destroy]
  before_action :load_countries, only: [:new, :edit, :update,:create]

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
    @booking = Booking.new
    @tourpoints = @tour.tourpoints
    @average_rating = average_rating
    @recent_schedules = recent_schedules
    load_tour_guide
    set_vary_header

    if request.xhr?
      respond_to do |format|
        format.json do
          render :json => @tour.to_json({:include => {:tourpoints => {:methods => :tour_point_img_url} }, :methods => :country_name})
        end
        format.html do
          set_vary_header
          render :show
        end
      end
    end

  end

  def create
    @tour = Tour.new(tour_params)
    @tour.user_id = current_user.id
    @tour.duration_in_ms = (params[:duration_in_hr].to_i) * 3600000
    # byebug
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
    ensure_owner(@tour) || tour_booked
    # @tour = current_user.tours.find(params[:id])
  end

  def update
    @tour = Tour.find(params[:id])
    @tour.duration_in_ms = (params[:duration_in_hr].to_i) * 3600000
    @tour.update_attributes(tour_params)
    if @tour.save
      if params[:add_schedule]
        redirect_to new_tour_schedule_path(@tour)
      elsif params[:no_schedule]
        redirect_to tour_path(@tour)
      end
    else

      render :edit
    end
  end

  def destroy
    @tour = Tour.find(params[:id])
    if @tour.schedules.empty?
      @tour.schedules.destroy_all
      @tour.reviews.destroy_all
      @tour.tourpoints.destroy_all
      @tour.destroy
      redirect_to tours_path
    else
      tour_booked
      @tour.schedules.destroy_all
      @tour.reviews.destroy_all
      @tour.destroy
    end
  end

  private
  def load_countries
    @countries = Country.all.order(:name)
  end


  def tour_params

    # params[:tour][:schedules_attributes]["0"][:current_capacity] = 0
    # byebug

    params.require(:tour).permit(:name, :description, :country_id, :rendezvous_point, :category, :capacity, :duration_in_hr, :tourpic)

  end

  def tour_booked
    @tour.schedules.each do |schedule|
      if schedule.current_capacity != 0
      flash[:alert] = "You cannot edit a tour if people have booked it "
      redirect_to tour_path(@tour) and return
    end
  end
  end

  def average_rating
    unless @tour.reviews.empty?
    ratings = @tour.reviews.map do |t_r|
      t_r.rating
    end
    return (ratings.sum)/ratings.length
  end
end

def recent_schedules
  @tour.schedules.order("tour_start_time ASC").limit(3)
end

def load_tour_guide
  @tour_guide = User.find(@tour.user_id)
end


end
