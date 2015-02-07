class UserRelationship < ActiveRecord::Base
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  belongs_to :recipient, class_name: 'User', foreign_key: :recipient_id

  validates_presence_of :owner_id, :recipient_id
  validates_uniqueness_of :recipient_id, scope: :owner_id

  ### owner is teacher ###
end
