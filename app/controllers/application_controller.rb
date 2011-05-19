class ApplicationController < ActionController::Base
  protect_from_forgery
  
  layout :layout_by_resource
  private

  def layout_by_resource
    if devise_controller? && resource_name == :admin
      "admin"
    else
      "application"
    end
  end
  
  def authenticate_user!
    unless current_user
      session[:previous_path] = request.path
      redirect_to "/signin?origin=#{request.path}"
    end
  end
  
  def current_user
    @current_user ||= User.find(session[:current_user_id]) if session[:current_user_id]
    @current_user
  end
end
