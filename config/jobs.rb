require File.expand_path("../environment", __FILE__) 
require 'stalker'
include Stalker

job "#{$SPREFIX}.request.notify" do |args|
  request = Request.find(args["id"])
  startup=request.startup
  followers = startup.followers
  followers.each do |f|
    Notifier.new_request_created(request,f).deliver!
  end
end

job "#{$SPREFIX}.user.registered" do |args|
  user = User.find(args["id"])
  Notifier.new_user_registered(user).deliver!
end

job "#{$SPREFIX}.user.approved" do |args|
  user = User.find(args["id"])
  Notifier.user_approved(user).deliver!
end

job "#{$SPREFIX}.user.banned" do |args|
  user = User.find(args["id"])
  Notifier.user_banned(user).deliver!
end

job "#{$SPREFIX}.user.invited" do |args|
  invitation = Invitation.find(args["id"])
  puts "sending invitation mail to #{invitation.email}" 
  Notifier.user_invited(invitation).deliver!
end

job "#{$SPREFIX}.contact.sent" do |args|
  c = Contact.new(:id => 1, :email => args['email'], :subject => args['subject'], :message => args['message'])
  puts "sending contact us mail from #{c.email}"
  Notifier.contact_notification(c).deliver!
end
