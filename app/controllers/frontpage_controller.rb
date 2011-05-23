class FrontpageController < ApplicationController
  before_filter :authenticate_user!, :except=>[:index]
  before_filter :must_be_activated!, :except=>[:index]

  def index
    if(current_user)
      redirect_to dashboard_path
    end
  end
end
