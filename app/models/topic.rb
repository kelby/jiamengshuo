class Topic < ActiveRecord::Base
  acts_as_taggable
  belongs_to :user

  # join tables
  has_many :sticks, ->{ where related_by: 'stick'}, class_name: 'TopicAndUser'
  has_many :followers, ->{ where related_by: 'follower'}, class_name: 'TopicAndUser'
  has_many :keepers, ->{ where related_by: 'keeper'}, class_name: 'TopicAndUser'

  has_many :sticked_users, class_name: 'User', through: :sticks
  has_many :followered_users, class_name: 'User', through: :followers
  has_many :keepered_users, class_name: 'User', through: :keepers

  validates_presence_of :user_id, :title, :body
end
