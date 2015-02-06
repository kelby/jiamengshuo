class Apply < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :apply_student, class_name: 'User', foreign_key: :user_id
  belongs_to :applied_mentor, class_name: 'User', foreign_key: :mentor_id

  belongs_to :pending_apply_student, class_name: 'User', foreign_key: :user_id

  enum status: {pending: 0, approved: 1, refused: 2}

  validates_uniqueness_of :user_id, scope: :mentor_id
end
