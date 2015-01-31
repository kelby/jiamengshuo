class Post < ActiveRecord::Base
  has_many :sections, dependent: :destroy

  accepts_nested_attributes_for :sections, reject_if: proc { |attributes| attributes['description'].blank? }
end
