class InvitationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :must_be_activated!
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
    if @invitation.present?
      @invitation.update_attributes(:accepted => true, :status => 'registered')
      @startup.team.users.push(current_user)
      current_user.teams.push(@startup.team)
      redirect_to '/dashboard'
    else
      render :status => 404
    end    
  end

end
