class InvitationsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  before_filter :must_be_activated!, :except => [:show]
  
  def index
    @startup = current_user.startups.where(:slug => params[:startup_id]).first
    @invitees = @startup.invitations.recent.pending.page(params[:page]).per(10)
    @invitation = @startup.invitations.build
  end

  def create
    @startup = current_user.startups.where(:slug => params[:startup_id]).first
    @invitees = @startup.invitations.recent.pending.page(params[:page]).per(10)
    @invitation = Invitation.new(params[:invitation])
    @invitation.startup = @startup
    @invitation.user = current_user
    if @invitation.save
      Stalker.enqueue("#{$SPREFIX}.user.invited", :id => @invitation.id)
      flash[:notice] = "Invitation has been sent sucessfully."
      redirect_to startup_invitations_path(@startup)
    else
      flash[:alert] = "Invitation cannot be sent."
      render :action => :index
    end
  end
  
  def show
    @invitation = Invitation.where(:unique_id => params[:id], :deleted => false).first
    @startup = Startup.where(:slug => params[:startup_id]).first
    if @invitation.blank? || @startup.blank?
      redirect_to '/'
    end    
  end
  
  def accept
    @invitation = Invitation.where(:unique_id => params[:id], :deleted => false).first
    @startup = Startup.where(:slug => params[:startup_id]).first
    if @invitation.blank? || @startup.blank?
      redirect_to '/'
    else
      @startup.team.users << current_user
      @invitation.update_attributes(:accepted => true, :status => 'registered')
      redirect_to '/dashboard'
    end  
  end
  
  def destroy
    @invitation = Invitation.where(:unique_id => params[:id]).first
    @startup = Startup.where(:slug => params[:startup_id]).first
    @invitation.deleted = true
    require 'pp'
    pp 'I\'m here'
    if @invitation.save
      flash[:notice] = "The invitation was deleted."
      redirect_to startup_invitations_path(@startup)
    else
      flash[:notice] = "There was some problem in deleting the invitation."
      redirect_to :back
    end
  end

end
