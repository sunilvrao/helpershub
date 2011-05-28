class Notifier < ActionMailer::Base
  default :from => "noreply@helpershub.com"

  def new_request_created(request, user)
    @user=user
    @request=request
    @startup=request.startup
    mail(:from=>"noreply@helpershub.com", :to=>@user.email, :subject=>"A new request from #{@startup.name}")
  end
end
