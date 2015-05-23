class LikerComment < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :liker, class_name: 'User'
  belongs_to :comment

  validates_uniqueness_of :comment_id, :scope => [:liker_id]
end
