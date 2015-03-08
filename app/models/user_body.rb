class UserBody < ActiveRecord::Base
  belongs_to :user

  enum gender: { default: 0, male: 1, female: 2 }
end
