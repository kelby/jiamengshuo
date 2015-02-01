class Post < ActiveRecord::Base
  has_many :sections, dependent: :destroy
  belongs_to :user

  validates_presence_of :title, :description, :user_id

  accepts_nested_attributes_for :sections, reject_if: proc { |attributes| attributes['description'].blank? }
end
