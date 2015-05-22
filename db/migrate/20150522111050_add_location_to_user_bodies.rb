class AddLocationToUserBodies < ActiveRecord::Migration
  def change
    add_column :user_bodies, :location, :string
  end
end
