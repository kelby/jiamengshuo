class AddUserIdToApplies < ActiveRecord::Migration
  def change
    add_column :applies, :user_id, :integer
  end
end
