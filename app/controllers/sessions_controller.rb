class SessionsController < ApplicationController
  def new
  end
  def destroy
    session[:current_user_id]=nil
    session.delete :current_user_id
    flash[:notice]="You have been signed out"
    redirect_to root_url
  end
  def failure
    flash[:error] = "I am sorry. But we could not sign you in."
  end
  def create
    service_name = params[:service]
    omniauth = request.env['omniauth.auth']
    if omniauth and service_name
      @auth = {}

      # extract the relevant portions from the hash

      if service_name == "google"
        @auth[:email] = omniauth['user_info']['email']
        @auth[:uid] = omniauth['uid']
        @auth[:uname] = omniauth['user_info']['name']
        @auth[:provider] = "google" # this is currently the only one we have
      end

      if service_name=="twitter"
        @auth[:uid] = omniauth['uid']
        @auth[:uname] = omniauth['user_info']['name']
        @auth[:provider] = "twitter"
        @bio = omniauth['user_info']['description']
      end

      # find out the associated user or else create one
      if @auth[:uid] and not @auth[:uid].blank?
        user = User.where("services.uid"=>@auth[:uid]).first
        if(user) 
          session[:current_user_id]=user.id.to_s
        else
          u = User.new(:full_name=>@auth[:uname], :email=>@auth[:email])
          u.bio = @bio if @bio
          s = u.services.build(@auth)
          u.save!
          session[:current_user_id]=u.id.to_s
        end
      else
        flash[:error] = "I am sorry but we could not sign you in."
      end
      redirect_to root_url
    end
  end
end
