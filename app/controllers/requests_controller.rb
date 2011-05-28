class RequestsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :must_be_activated!
  before_filter :set_categories
  
  def index
    @startup = Startup.where(:slug=>params[:startup_id]).first if params[:startup_id]
    @category = Category.where(:slug=>params[:category_id]).first if params[:category_id]
    @requests= Request.page(params[:page]) unless @startup or @category
    @requests= @startup.requests.page(params[:page]) if @startup
    @requests= @category.requests.page(params[:page]) if @category
  end
  
  def new
    @startup = Startup.where(:slug=>params[:startup_id]).first if params[:startup_id]
    @request= Request.new unless @startup
    @startups = current_user.startups
    @request= @startup.requests.build if @startup
  end

  def create
    @startup = Startup.where(:slug=>params[:startup_id]).first if params[:startup_id]
    category_ids = params[:request].delete(:category_ids)
    category_ids.delete("")
    params[:request][:category_ids]=category_ids
    @request= Request.new(params[:request])
    categories = Category.find(category_ids)
    @startups = Startup.all
    @request.owner = current_user
    if(@request.save)
      categories.each do |c|
        c.requests<<@request
        c.inc(:request_count, 1)
        c.save!
      end
      flash[:notice]="Request saved successfully"
      Stalker.enqueue('request.notify',:id=>@request.id)
      redirect_to @request
    else
      render :action=>:new
    end
  end

  def show
    @request=Request.where(:slug=>params[:id]).first
    @comments = @request.comments
  end

  def edit
    @request=Request.where(:slug=>params[:id]).first
    @startups = current_user.startups
  end

  def update
    @request=Request.where(:slug=>params[:id]).first
    category_ids = params[:request].delete(:category_ids)
    category_ids.delete("")
    removed_cats = @request.category_ids.collect(&:to_s) - category_ids
    added_cats = category_ids - @request.category_ids.collect(&:to_s)
    if(@request.update_attributes(params[:request]))
      added_cats.each do |c|
        Category.find(c).inc(:request_count,1)
      end
      removed_cats.each do |c|
        Category.find(c).inc(:request_count,-1)
      end
      flash[:notice] = "Request updated successfully"
      redirect_to @request
    else
      render :action=>:edit
    end
  end

  def commit
    @request= Request.where(:slug=>params[:id]).first
    @commitment= @request.commitments.build
  end
  
  private
  
  def set_categories
    @categories=Category.all
    @selected_category = params[:category_id] 
  end
end
