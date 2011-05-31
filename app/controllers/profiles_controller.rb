class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :must_be_activated!

  before_filter :set_professions

  def set_professions
      @professions = Profession.all
  end
end
