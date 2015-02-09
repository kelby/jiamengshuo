class TopicAndUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic

  validates_uniqueness_of :type, :scope => [:user_id, :topic_id]
end
