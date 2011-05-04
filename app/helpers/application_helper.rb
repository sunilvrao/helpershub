module ApplicationHelper
  def current_user
    @current_user ||= User.find(session[:current_user_id]) if session[:current_user_id]
    @current_user
  end
end
