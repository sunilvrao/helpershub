class WelcomeController < ApplicationController
  before_filter :authenticate_user!, :except=>[:index]
  before_filter :must_be_activated!, :except=>[:index,:not_activated, :profile]
  before_filter :set_categories
  def index
    if(current_user)
      redirect_to dashboard_path
    end
  end
  def dashboard
    render :index
  end
  def set_categories
    @categories=Category.all
  end
  def not_activated
  end
  def profile
  end
end
