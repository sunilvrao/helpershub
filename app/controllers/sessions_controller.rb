class SessionsController < ApplicationController
  layout 'sessions'
  def new
    if(current_user)
      flash[:notice] = "You are already signed in as #{current_user.full_name}"
      redirect_to root_url
    end
  end
  def sign_in_as
    flash[:error] = "Naughty Naughty"
    redirect_to root_url unless Rails.env=="development"
    u=User.where(:email=>params[:email]).first
    if(u)
      session[:current_user_id] = u.id.to_s
    else
      flash[:error]="User not found"
    end
    redirect_to root_url
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

      if service_name=="linked_in"
        @auth[:uid] = omniauth['uid']
        @auth[:uname] = omniauth['user_info']['name']
        @auth[:provider] = "linked_in"
        @bio = omniauth['user_info']['description']
      end
      if service_name=="facebook"
        @auth[:uid] = omniauth['uid']
        @auth[:uname] = omniauth['user_info']['name']
        @auth[:provider] = "facebook"
        @auth[:email] = omniauth['user_info']['email']
        @bio = omniauth['user_info']['description']
      end

      # find out the associated user or else create one
      if @auth[:uid] and not @auth[:uid].blank?
        @user = User.where("services.uid"=>@auth[:uid]).first
        if(@user) 
          session[:current_user_id]=@user.id.to_s
        else
          u = User.new(:full_name=>@auth[:uname], :email=>@auth[:email])
          u.bio = @bio if @bio
          s = u.services.build(@auth)
          u.save!
          Stalker.enqueue("#{$SPREFIX}.user.registered",:id=>u.id)
          session[:current_user_id]=u.id.to_s
          @user=u
        end
      else
        flash[:error] = "I am sorry but we could not sign you in."
      end
      if(@user and (not @user.activated))
        redirect_to profile_path
      else
        redirect_to request.env['omniauth.origin'] if request.env['omniauth.origin']
        redirect_to root_url unless request.env['omniauth.origin']
      end
    end
  end
end
