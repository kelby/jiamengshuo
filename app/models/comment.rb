class Comment < ActiveRecord::Base
  include PublicActivity::Common

  acts_as_taggable

  default_scope { where('deleted_at is NULL') }

  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :replies, dependent: :destroy
  has_many :liker_comments, dependent: :destroy

  validates_presence_of :content, :user_id
end
