require File.expand_path("../environment", __FILE__) 
require 'stalker'
include Stalker

job "#{SPREFIX}.request.notify" do |args|
  request = Request.find(args["id"])
  startup=request.startup
  followers = startup.followers
  followers.each do |f|
    Notifier.new_request_created(request,f).deliver!
  end
end

job "#{SPREFIX}.user.registered" do |args|
  user = User.find(args["id"])
  Notifier.new_user_registered(user).deliver!
end

job "#{SPREFIX}.user.approved" do |args|
  user = User.find(args["id"])
  Notifier.user_approved(user).deliver!
end
job "#{SPREFIX}.user.banned" do |args|
  user = User.find(args["id"])
  Notifier.user_banned(user).deliver!
end
