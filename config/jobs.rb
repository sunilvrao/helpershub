require File.expand_path("../environment", __FILE__) 
require 'stalker'
include Stalker

job "request.notify" do |args|
  request = Request.find(args["id"])
  startup=request.startup
  followers = startup.followers
  followers.each do |f|
    Notifier.new_request_created(request,f).deliver!
  end
end

