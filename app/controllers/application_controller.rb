class ApplicationController < ActionController::Base
  protect_from_forgery

  
  private
  
  def authenticate_user!
    unless current_user
      redirect_to signin_path
    end
  end
  
  def current_user
    @current_user ||= User.find(session[:current_user_id]) if session[:current_user_id]
    @current_user
  end
end
