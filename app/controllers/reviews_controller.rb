class ReviewsController < ApplicationController

  before_action :load_tour,except: %i(load_schedule review_params)
  before_action :ensure_logged_in

  def new
    @review = Review.new
  end

  def create
    @review = Review.new
    @review = @tour.reviews.build(review_params)
    @review.author_id = current_user.id
    if @review.save
      redirect_to tour_path(@tour)
    else
      render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
    ensure_owner(@review)
  end

  def update
    @review = Review.find(params[:id])
    @review.update_attributes(review_params)
    if @review.save
      redirect_to tour_path(@tour)
    else
      render :edit
    end
  end

  def destroy
  end

  private
   def load_tour
     @tour = Tour.find(params[:tour_id])
   end

  def review_params
    params.require(:review).permit(:rating, :comment, :tour_id, :created_at)
  end





end
