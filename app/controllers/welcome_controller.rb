class WelcomeController < ApplicationController
  before_filter :set_categories

  def set_categories
    @categories=Category.all
  end
end
