class ContactsController < ApplicationController
  def create
    @contact = Contact.new(params[:contact])
    if @contact.save
      flash[:notice] = "You've successfully contacted the admin"
      Stalker.enqueue("#{$SPREFIX}.contact.sent", :email => @contact.email, :subject => @contact.subject, :message => @contact.message)
    else
      flash[:notice] = "The request could not be completed. You must fill all fields."
    end
    redirect_to :back
  end
end
