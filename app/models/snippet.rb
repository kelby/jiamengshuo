class Snippet < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :topic
  belongs_to :user

  enum status: { pendding: 0, approve: 1, refuse: 2}
end
