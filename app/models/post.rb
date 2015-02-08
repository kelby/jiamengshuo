class Post < ActiveRecord::Base
  include PublicActivity::Common

  has_many :sections, dependent: :destroy
  has_many :subjects, through: :sections
  belongs_to :user

  validates_presence_of :title, :user_id

  accepts_nested_attributes_for :sections, reject_if: proc { |attributes| attributes['description'].blank? }

  enum icon_from: { fi: 1, fa: 2 }
  validates_inclusion_of :icon_from, in: [1, 2], allow_nil: true
end
