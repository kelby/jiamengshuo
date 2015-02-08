class AddIconFromToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :icon_from, :integer
  end
end
