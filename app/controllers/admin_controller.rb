class AdminController < ApplicationController
  before_filter :authenticate_admin!
  def index
    @users = User.where(:activated=>false,:banned=>false)
  end
  def approve
    @user = User.find(params[:id])
    @user.activate!
    Stalker.enqueue("#{SPREFIX}.user.approved",:id=>@user.id)
    redirect_to admin_root_path
  end
  def ban
    @user = User.find(params[:id])
    @user.ban!
    Stalker.enqueue("#{SPREFIX}.user.banned", :id=>@user.id)
    redirect_to admin_root_path
  end
end
