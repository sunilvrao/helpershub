class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_categories
  def index
    @category = Category.where(:slug=>params[:category_id]).first if params[:category_id]
    @users = User.page(params[:page]) unless @category
    @users = @category.users.page(params[:page]) if @category
  end

  def most_active
    @category = Category.where(:slug=>params[:category_id]).first if params[:category_id]
    @users = User.most_active.page(params[:page]) unless @category
    @users = @category.users.most_active.page(params[:page]) if @category
    render :action => :index
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    @user.profile_set = true
    category_ids = params[:user][:category_ids]
    category_ids.delete("")
    removed_cats = @user.category_ids.collect(&:to_s) - category_ids
    added_cats = category_ids - @user.category_ids.collect(&:to_s)
    if @user.update_attributes(params[:user])
      added_cats.each do |c|
        Category.find(c).inc(:volunteer_count,1)
      end
      removed_cats.each do |c|
        Category.find(c).inc(:volunteer_count,-1)
      end
      flash[:notice] = "Thanks for filling up your profile."
      redirect_to root_path
    else
      render :action=>"welcome#profile"
    end
  end
  
  def follow
    @user = User.find(params[:id])
    current_user.follow(@user)
    redirect_to @user
  end
  
  def unfollow
    @user = User.find(params[:id])
    current_user.unfollow(@user)
    redirect_to @user
  end

  private

  def set_categories
    @categories=Category.all
    @selected_category = params[:category_id]
  end
end
