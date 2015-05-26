class Catalog < ActiveRecord::Base
  acts_as_tree order: "name"
  acts_as_paranoid

  default_scope { where('deleted_at is NULL') }

  enum icon_from: { fi: 1, fa: 2 }
  validates_inclusion_of :icon_from, in: ['fi', 'fa'], allow_nil: true

  has_many :topics , dependent: :destroy
end
