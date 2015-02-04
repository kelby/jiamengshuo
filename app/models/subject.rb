class Subject < ActiveRecord::Base
  has_many :sections
  has_many :posts, through: :sections
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :user
end
