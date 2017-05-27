class TourpointsController < ApplicationController
  before_action :load_tour, except: %i(tourpoint_params)
  skip_before_action :verify_authenticity_token, :only => [:update]
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

  def show
    @tourpoint = Tourpoint.find(params[:id])

    if request.xhr?
      respond_to do |format|
        format.html do
          render @tourpoint
        end
        format.json do

          render :json => @tourpoint

        end
      end
    end

  end

  def groupedit
    @tourpoint = Tourpoint.new
  end

  def update
    @tourpoint = Tourpoint.find(params[:id])

    if @tourpoint.update_attributes(tourpoint_params)
      redirect_to tour_path(@tour)
    else
      render :groupedit
    end

  end

  def destroy

  end

  private
  def load_tour
    @tour = Tour.find(params[:tour_id])
  end

  def tourpoint_params
  params.require(:tourpoint).permit(:tour_point_name, :tour_point_laglng, :tour_point_img, :tour_point_description, :tour_id,:avatar)
  end

end
