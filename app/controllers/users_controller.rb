class UsersController < ApplicationController
  def new
    @user = User.new
    #  render :layout=>"applicationb"

  end

  def edit
    @user = current_user
  end


  def show
    # layout :applicationb
    @user = current_user
    @bookings = @user.bookings
    @tours_booked = @user.booked_tours
    @tours_created = @user.tours
  end

  def profile
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      UserMailer.welcome_email(@user).deliver
      redirect_to profile_path
    else
      render :new
    end
  end

  def update
    @user = current_user
      if @user.update_attributes(user_params)
        redirect_to tours_url
      else
        render :edit
      end
  end

  def destroy
    @user = current_user
    @user.destroy
    redirect_to tours_url
  end

  private
  def user_params
    params.require(:user).permit(:name, :username, :email, :phone, :password, :password_confirmation, :picture, :avatar)
  end

end
