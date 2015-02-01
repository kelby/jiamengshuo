class Comment < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  has_many :replies, dependent: :destroy

  validates_presence_of :content, :topic_id, :user_id
end
