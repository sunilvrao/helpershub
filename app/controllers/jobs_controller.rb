class JobsController < ApplicationController
  before_filter :set_categories
  def new
    @startup = Startup.where(:slug=>params[:startup_id]).first if params[:startup_id]
    @job = Job.new unless @startup
    @startups = Startup.all
    @job = @startup.jobs.build if @startup
  end

  def create
    @startup = Startup.where(:slug=>params[:startup_id]).first if params[:startup_id]
    @job = Job.new(params[:job])
    category_ids = params[:job][:category_ids]
    categories = Category.find(category_ids)
    @startups = Startup.all
    @job.owner = current_user
    if(@job.save)
      categories.each do |c|
        c.jobs<<@job
        c.inc(:job_count, 1)
        c.save!
      end
      flash[:notice]="Job saved successfully"
      redirect_to @job
    else
      render :action=>:new
    end
  end

  def show
    @job=Job.where(:slug=>params[:id]).first
  end

  private
  
  def set_categories
    @categories=Category.all
  end

end
