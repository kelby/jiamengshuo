class AddFromUserIdAndToUserIdToDirectMessages < ActiveRecord::Migration
  def change
    add_column :direct_messages, :from_user_id, :integer
    add_column :direct_messages, :to_user_id, :integer
  end
end
