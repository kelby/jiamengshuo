class AddIconToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :icon, :string
  end
end
