class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

    private

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    helper_method :current_user

  def ensure_logged_in
    unless current_user
      flash[:alert] = "Please log in"
      redirect_to new_session_url
    end
  end

  def ensure_tour_user
    unless current_user.id == @tour.user_id
      flash[:alert] = "You are not authorized to do this"
      redirect_to root_path
    end
  end

end
