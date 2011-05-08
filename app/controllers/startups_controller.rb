class StartupsController < ApplicationController
  before_filter :authenticate_user!, :except=>[:index,:show]
  def index
  end
  def new
    @startup = current_user.startups.build
  end
  def create
    @startup = Startup.new(params[:startup])
    if(@startup.save)
      flash[:notice] = "Startup saved successfully"
      redirect_to @startup
    else
      render :action=>:new
    end
  end
  def show
    @startup = Startup.find(params[:id])
  end
  def edit
  end
  def update
  end
  def destroy
  end

end
