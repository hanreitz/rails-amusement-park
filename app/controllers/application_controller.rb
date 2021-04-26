class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def restricted_area
    redirect_to '/' unless current_user
  end

  def current_user
    User.find_by(id: session[:user_id])
  end
end
