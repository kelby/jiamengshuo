class Wish < ActiveRecord::Base
  scope :active_wish, -> { last }

  belongs_to :user, required: true

  delegate :username, to: :user
end
