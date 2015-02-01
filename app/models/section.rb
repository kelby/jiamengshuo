class Section < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates_presence_of :user_id

  scope :present_heading_sections, -> { where("heading IS NOT NULL AND heading != ?", "") }
end
