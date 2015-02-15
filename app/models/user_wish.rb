class UserWish < ActiveRecord::Base
  # For checkin and checkout
  belongs_to :user
  belongs_to :wish

  validates_uniqueness_of :user_id, scope: :wish_id
end
