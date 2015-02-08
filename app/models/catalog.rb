class Catalog < ActiveRecord::Base
  acts_as_tree order: "name"

  enum icon_from: { fi: 1, fa: 2 }
  validates_inclusion_of :icon_from, in: [1, 2], allow_nil: true
end
