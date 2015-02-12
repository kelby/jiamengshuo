class Section < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  belongs_to :subject

  validates_presence_of :user_id

  scope :present_heading_sections, -> { where("heading IS NOT NULL AND heading != ?", "") }

  enum head: { two: 2, three: 3 }
end
