class TourpointsController < ApplicationController
  before_action :load_tour, except: %i(tourpoint_params)

  def new
    @tourpoint = Tourpoint.new
  end

  def create
    @tourpoint = @tour.tourpoints.build(tourpoint_params)

    if @tourpoint.save
      redirect_to tour_path(@tour)
    else
      render :new
    end
  end

  def edit

  end

  def groupedit

  end

  def update
    # @tourpoint = Tourpoint.find(params[])

    # if @tourpoint.update_attributes(tou_params)
    #   redirect_to tour_path(@tour)
    # else
    #   render :edit
    # end

  end

  def destroy

  end

  private
  def load_tour
    @tour = Tour.find(params[:tour_id])
  end

  def tourpoint_params
  params.require(:tourpoint).permit(:tour_point_name, :tour_point_laglng, :tour_point_img, :tour_point_description, :tour_id)
  end

end
