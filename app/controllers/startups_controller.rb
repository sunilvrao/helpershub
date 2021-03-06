class StartupsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :must_be_activated!
  before_filter :set_verticals
  def index
    @user =  current_user if params[:user_id] == current_user.id.to_s
    if params[:user_id]
      if @user
        @startups= @user.startups.page(params[:page])
      else
        redirect_to requests_path
      end
    else
      @startups = Startup.order_by(:created_at, :desc).all.page(params[:page])
    end
  end
  def new
    @startup = current_user.startups.build
  end
  def create
    @startup = Startup.new(params[:startup])
    @startup.owner=current_user
    if(@startup.save)
      @startup.team = Team.new
      current_user.teams = [@startup.team]
      @startup.team.users = [current_user]
      flash[:notice] = "Startup saved successfully"
      redirect_to @startup
    else
      render :action=>:new
    end
  end
  def show
    @startup = Startup.where(:slug=>params[:id]).first
    @requests = @startup.requests.page(params[:page])
  end
  def follow
    @startup = Startup.where(:slug=>params[:id]).first
    current_user.follow(@startup)
    redirect_to @startup
  end
  def unfollow
    @startup = Startup.where(:slug=>params[:id]).first
    current_user.unfollow(@startup)
    redirect_to @startup
  end

  def edit
    @startup = Startup.where(:slug=>params[:id]).first
  end
  def update
    @startup = Startup.where(:slug=>params[:id]).first
    if(@startup.update_attributes(params[:startup]))
      flash[:notice]="Startup updated successfully"
      redirect_to @startup
    else
      render :action=>:edit
    end
  end
  def destroy
    @startup = Startup.where(:slug=>params[:id]).first
    @startup.soft_delete
    redirect_to startups_path
  end
  def set_verticals
    @verticals = Vertical.all
    @selected_vertical = params[:vertical_id]
  end
end
