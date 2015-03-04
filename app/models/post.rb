class Post < ActiveRecord::Base
  include PublicActivity::Common

  has_many :sections, dependent: :destroy
  has_many :subjects, through: :sections
  belongs_to :user, counter_cache: true
  has_many :comments, as: :commentable

  validates_presence_of :title, :user_id

  accepts_nested_attributes_for :sections, reject_if: proc { |attributes| attributes['description'].blank? }

  enum icon_from: { fi: 1, fa: 2 }
  validates_inclusion_of :icon_from, in: ['fi', 'fa'], allow_nil: true

  attr_accessor :icon_fi, :icon_fa

  def icon_fi
    self.icon if self.fi?
  end

  def icon_fa
    self.icon if self.fa?
  end
end
