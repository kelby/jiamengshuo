class Post < ActiveRecord::Base
  include PublicActivity::Common

  has_many :sections, dependent: :destroy
  has_many :subjects, through: :sections
  belongs_to :user

  validates_presence_of :title, :description, :user_id

  accepts_nested_attributes_for :sections, reject_if: proc { |attributes| attributes['description'].blank? }
end
