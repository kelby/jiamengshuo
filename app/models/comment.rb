class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :replies, dependent: :destroy

  validates_presence_of :content, :user_id
end
