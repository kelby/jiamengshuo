class Wish < ActiveRecord::Base
  scope :active_wish, -> { last }

  belongs_to :user, required: true

  delegate :username, to: :user

  validates_presence_of :content, :user_id
  validates_length_of :content, maximum: 140, message: "less than 140 if you don't mind"
end
