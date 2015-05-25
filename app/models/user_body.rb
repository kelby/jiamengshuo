class UserBody < ActiveRecord::Base
  belongs_to :user
  validates_format_of :qq, :with => /\A\d{5,15}\z/
  validates_format_of :phone, :with => /\A[0-9\-]{7,14}\z/

  enum gender: { default: 0, male: 1, female: 2 }
  
end
