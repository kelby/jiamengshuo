class Subject < ActiveRecord::Base
  has_many :sections
  has_many :posts, through: :sections
end
