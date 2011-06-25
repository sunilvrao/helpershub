class Notifier < ActionMailer::Base
  default :from => "noreply@helpershub.com"

  def new_request_created(request, user)
    @user=user
    @request=request
    @startup=request.startup
    mail(:from=>"noreply@helpershub.com", :to=>@user.email, :subject=>"A new request from #{@startup.name}")
  end
  def new_user_registered(user)
    @user = user
    mail(:from=>"noreply@helpershub.com", :to=>@user.email, :subject=>"Thanks for registering with Helpers Hub")
  end
  def user_approved(user)
    @user = user
    mail(:from=>"noreply@helpershub.com", :to=>@user.email, :subject=>"Your membership has been approved")
  end
  def user_banned(user)
    @user = user
    mail(:from=>"noreply@helpershub.com", :to=>@user.email, :subject=>"Your membership has been rejected")
  end
  
  def user_invited(invitation)
    @invitation = invitation
    mail(:from=>"noreply@helpershub.com", :to=>@invitation.email, :subject=>"An invitation to join #{@invitation.startup.name}")
  end
end
