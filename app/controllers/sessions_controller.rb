class SessionsController < ApplicationController
  def new
  end

  def show
  end

  def create
    user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect_to profile_path(anchor: "see-all-user-show"), flash.now[:notice] =>"You are now logged in."
      else
        flash.now[:alert] = "Invalid username or password"
        render "new"
      end
  end

  def destroy
    session[:user_id] = nil
    redirect_to tours_url, notice: "You are now logged out."
  end
end
