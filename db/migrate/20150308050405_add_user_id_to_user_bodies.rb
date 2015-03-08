class AddUserIdToUserBodies < ActiveRecord::Migration
  def change
    add_column :user_bodies, :user_id, :integer
  end
end
