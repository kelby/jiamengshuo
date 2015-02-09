class TopicAndUser < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :user
  belongs_to :topic

  validates_uniqueness_of :type, :scope => [:user_id, :topic_id]
end
