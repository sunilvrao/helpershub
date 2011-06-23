class TeamsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :must_be_activated!

  def show
    @startup = current_user.startups.where(:slug => params[:startup_id]).first
    if @startup.team.blank?
      @startup.team = Team.new
      @startup.team.users = [current_user]
    end
    if @startup.present?
      @users = @startup.team.users.page(params[:page])
    else
      flash[:notice] = 'You do not own this startup'
      redirect_to dashboard_path
    end
  end
end