class UsersController < ApplicationController
  before_filter :authenticate_user!
  def update
    @user = current_user
    @user.profile_set = true
    if @user.update_attributes(params[:user])
      flash[:notice] = "Thanks for filling up your profile."
      redirect_to root_path
    else
      render :action=>"welcome#profile"
    end
  end
end
