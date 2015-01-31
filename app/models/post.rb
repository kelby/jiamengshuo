class Post < ActiveRecord::Base
  has_many :sections

  accepts_nested_attributes_for :sections
end
