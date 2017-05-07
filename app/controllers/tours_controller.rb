class ToursController < ApplicationController
  def index
    @tours = Tour.all
  end

  def new
    @tour = Tour.new
  end

  def create
    @tour = Tour.new(tour_params)
    @tour.owner_id = current_user.id
    if Tour.save
      redirect_to tours_path
    else
      render :new
    end
  end

  def edit
    @tour = Tour.find(params[:id])
  end

  def update
    @tour = Tour.find(params[:id])
    @tour.update_attributes(tour_params)
    if @tour.save
      redirect_to tours_path
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
    params.require(:tour).permit(:name, :description, :city, :country, :address, :category, :capacity)
  end

end
