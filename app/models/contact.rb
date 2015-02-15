class Contact
  include ActiveModel::Model

  attr_accessor :email, :message, :subject

  validates :email,   :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, :presence => true
  validates :message, :presence => true
  validates :subject, :presence => true

  def self.deliver(contact)
    ContactMailer.contact_us(contact).deliver_now
  end
end
