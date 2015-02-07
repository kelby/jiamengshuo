class DirectMessage < ActiveRecord::Base
  validates_presence_of :from_user_id, :to_user_id, :content
end
