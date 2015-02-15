class ContactController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    contact = Contact.new params[:contact]
    Contact.delay.deliver(contact) if contact.valid?

    redirect_to root_path, notice: "邮件发送成功，感谢您的反馈。"
  end
end
