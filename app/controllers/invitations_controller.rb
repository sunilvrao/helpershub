class InvitationsController < ApplicationController
  def index
    @startup = current_user.startups.where(:slug => params[:startup_id]).first
    @invitees = @startup.invitations.desc.pending.page(params[:page]).per(10)
    @invitation = @startup.invitations.build
  end

  def create
    @startup = current_user.startups.where(:slug => params[:startup_id]).first
    @invitees = @startup.invitations.desc.pending.page(params[:page]).per(10)
    @invitation = Invitation.new(params[:invitation])
    @invitation.startup = @startup
    @invitation.user = current_user
    if @invitation.save
      #Stalker.enqueue("#{SPREFIX}.send.invitation", :id => @invitation.id)
      flash[:notice] = "Invitation has been sent sucessfully."
      redirect_to startup_invitations_path(@startup)
    else
      flash[:alert] = "Invitation cannot be sent."
      render :action => :index
    end
  end

end
