class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @tours = Tour.all
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
    params.require(:user).permit(:name, :username, :email, :phone, :picture) #:password, :password_confirmation,
  end

end
