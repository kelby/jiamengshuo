class DirectMessage < ActiveRecord::Base
  validates_presence_of :from_user_id, :to_user_id, :content

  belongs_to :from_user, class_name: "User", foreign_key: :from_user_id
  belongs_to :to_user, class_name: "User", foreign_key: :to_user_id

  scope :not_read, -> { where.not(read: true)}
end
