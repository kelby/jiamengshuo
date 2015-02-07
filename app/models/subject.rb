class Subject < ActiveRecord::Base
  has_many :sections
  has_many :posts, through: :sections
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :user

  has_one :desc_long_comment, -> { where("LENGTH(content) > ?", 140).order("id desc").limit(1) }, as: :commentable, class_name: 'Comment', foreign_key: :commentable_id

  validates_presence_of :title, :body, :user_id
end
