class AdminController < ApplicationController
  before_filter :authenticate_admin!
  def index
    @users = User.where(:activated=>false)
  end
  def approve
    @user = User.find(params[:id])
    @user.activate!
    redirect_to admin_root_path
  end
end
