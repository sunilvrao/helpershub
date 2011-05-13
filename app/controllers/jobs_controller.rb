class JobsController < ApplicationController
  before_filter :authenticate_user!, :except=>[:index,:show]
  before_filter :set_categories
  def index
    @startup = Startup.where(:slug=>params[:startup_id]).first if params[:startup_id]
    @category = Category.where(:slug=>params[:category_id]).first if params[:category_id]
    @jobs = Job.page(params[:page]) unless @startup or @category
    @jobs = @startup.jobs.page(params[:page]) if @startup
    @jobs = @category.jobs.page(params[:page]) if @category
  end
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

  def edit
    @job=Job.where(:slug=>params[:id]).first
    @startups = Startup.all
  end

  def update
    @job=Job.where(:slug=>params[:id]).first
    category_ids = params[:job].delete(:category_ids)
    category_ids.delete("")
    removed_cats = @job.category_ids.collect(&:to_s) - category_ids
    added_cats = category_ids - @job.category_ids.collect(&:to_s)
    puts category_ids.inspect
    puts removed_cats.inspect
    puts added_cats.inspect
    if(@job.update_attributes(params[:job]))
      added_cats.each do |c|
        Category.find(c).inc(:job_count,1)
      end
      removed_cats.each do |c|
        Category.find(c).inc(:job_count,-1)
      end
      flash[:notice] = "Job updated successfully"
      redirect_to @job
    else
      render :action=>:edit
    end
  end

  private
  
  def set_categories
    @categories=Category.all
    @selected_category = params[:category_id] 
  end

end
