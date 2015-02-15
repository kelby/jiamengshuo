class ContactController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    contact = Contact.new params[:contact]
    Contact.delay.deliver(contact) if contact.valid?

    redirect_to root_path
  end
end
