class TopicAndUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic

  belongs_to :stick_topic, class_name: 'Topic', foreign_key: :topic_id
  belongs_to :keeper_topic, class_name: 'Topic', foreign_key: :topic_id
  belongs_to :follower_topic, class_name: 'Topic', foreign_key: :topic_id

  belongs_to :sticked_user, class_name: 'User', foreign_key: :user_id
  belongs_to :keepered_user, class_name: 'User', foreign_key: :user_id
  belongs_to :followered_user, class_name: 'User', foreign_key: :user_id
end
