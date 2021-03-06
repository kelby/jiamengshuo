class ContactMailer < ApplicationMailer
  default to: MAILER['user_name']

  def contact_us(contact)
    @contact = contact
    mail(from: MAILER['user_name'], subject: contact.subject)
  end
end
