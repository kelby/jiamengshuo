class ContactMailer < ApplicationMailer
  default to: MAILER['user_name']

  def contact_us(contact)
    mail(from: contact.email, subject: contact.subject)
  end
end
