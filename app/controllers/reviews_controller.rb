class ReviewsController < ApplicationController

  before_action :load_tour,except: %i(load_schedule review_params)
  before_action :load_schedule,except: %i(load_tour review_params)
  before_action :ensure_logged_in
  before_action :load_tour_guide, only: [:create, :edit, :update, :destroy]

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
   def load_tour
     @tour = Tour.find(params[:tour_id])
   end

   def load_schedule
     @schedule = Schedule.find(params[:schedule_id])
   end

    def booking_params
    params.require(:booking).permit(:schedule_id, :booking_size)
    end

    def load_tour_guide
      @tour_guide = User.find(@tour.user_id)
    end

  end

end
